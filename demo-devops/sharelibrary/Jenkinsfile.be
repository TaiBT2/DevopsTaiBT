pipeline {
    environment {
        registry = "rkapp.vcenter.com.vn/smp/rikkei/singhai-be"
        registryCredential = 'dg1repo'
        tag = "rikkei-${createTag()}"
    }
    parameters  {
         choice(
            name: 'services', 
            choices: ['all', 'alibaba-service', 'api-gateway', 'auth-service', 'dispatch-service', 'finance-service', 'system-service', 'user-service'], 
            description: 'Pick services to build')
    }
    agent {
        kubernetes {
            showRawYaml false
            yaml """
                apiVersion: v1
                kind: Pod
                metadata:
                    labels:
                        jenkins: agent
                spec:
                    imagePullPolicy: IfNotPresent
                    containers:
                    - name: jnlp
                      image: jenkins/inbound-agent:latest
                      args: ['\$(JENKINS_SECRET)', '\$(JENKINS_NAME)']   
                      volumeMounts:
                      - name: data
                        mountPath: /data   
                      env:
                      - name: GIT_SSH_COMMAND
                        value: ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /data/SSH-KEY/id_rsa_gitlab                      
                    - name: maven
                      image: maven:3.8.3-openjdk-17
                      command:
                      - cat
                      tty: true
                    - name: sonarqube
                      image: sonarsource/sonar-scanner-cli
                      command:
                      - cat
                      tty: true
                    - name: docker
                      image: docker:dind
                      command:
                      - cat
                      tty: true
                      env:
                      - name: DOCKER_HOST
                        value: tcp://dind:2375                    
                    volumes:
                    - name: data
                      persistentVolumeClaim:
                        claimName: jenkins-agent-pv            
            """
        }
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/smp_staging']], userRemoteConfigs: [[url: 'git@git.rikkei.org:dg1/singhai-group/singhai-be.git', credentialsId: 'git-ssh-rk']]])
            }
        }
        stage ("add properties file") {
            steps {
                script {
                    if (params.services == 'all') {
                        for ( item in ['alibaba-service', 'api-gateway', 'auth-service', 'dispatch-service', 'finance-service', 'system-service', 'user-service'] ) {
                            sh """
                                cat <<EOF | tee zhy-${item}/src/main/resources/application.properties
discoveryServer=nacos.smp-rikkei:8848
discoveryGroup=testing
configGroup=testing
nacos.username=nacos
nacos.password=Rikkei@2024
nacos.namespace=staging
                            """
                        }
                    } else {
                        sh """
                            cat <<EOF | tee zhy-\${services}/src/main/resources/application.properties
discoveryServer=nacos.smp-rikkei:8848
discoveryGroup=testing
configGroup=testing
nacos.username=nacos
nacos.password=Rikkei@2024
nacos.namespace=staging
                        """
                    }
                    
                }
            }
        }         
        stage('Build Maven') {
            steps {
                container('maven') {
                    echo 'Building..'
                    script {
                        if (params.services == 'all') {
                            sh '''
                                mvn clean package -Dmaven.javadoc.skip=true -Dmaven.test.skip=true
                            '''
                        } else {
                            sh '''
                                mvn clean package -DskipTests -pl zhy-\$services -am -Dmaven.javadoc.skip=true -Dmaven.test.skip=true
                            '''
                        }                       
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                container('docker') {
                    echo 'Testing....'
                    withCredentials([
                        usernamePassword(
                            credentialsId: "dg1repo",
                            usernameVariable: 'REGISTRY_USER', passwordVariable: 'REGISTRY_PASS'
                        )
                    ]) {
                        script {
                            def collection = ['alibaba-service', 'api-gateway', 'auth-service', 'dispatch-service', 'finance-service', 'system-service', 'user-service']
                            sh '''
                                echo \$REGISTRY_PASS | docker login --username  \$REGISTRY_USER  rkapp.vcenter.com.vn --password-stdin
                            '''
                            if (params.services == 'all') {
                                def parallelBuilds = [:]
                                for ( item in collection ) {
                                    parallelBuilds["Build and Push ${item}"] = {
                                        sh """
                                            cd zhy-${item}
                                            docker build -f Dockerfile --tag \${registry}/zhy-${item}:\${tag} .
                                        """    
                                        def count = 0                                      
                                        while (true) {                                    
                                            try {
                                                sh """
                                                    docker push \${registry}/zhy-${item}:\${tag}
                                                """                                         
                                                break;
                                            } catch (Exception e) {
                                                echo 'Exception occurred: ' + e.toString()
                                            }
                                            count ++
                                            if (count == 10) {
                                                break;
                                            }                                        
                                        }
                                    }
                                }
                                parallel parallelBuilds
                            } else {
                                sh '''
                                    cd zhy-\${services}
                                    docker build -f Dockerfile --tag \${registry}/zhy-\${services}:\${tag} .
                                '''
                                def count = 0
                                while (true) {                                    
                                    try {
                                        sh """
                                            docker push \${registry}/zhy-\${services}:\${tag}
                                        """                                         
                                        break;
                                    } catch (Exception e) {
                                        echo 'Exception occurred: ' + e.toString()
                                    }
                                    count ++
                                    if (count == 10) {
                                        break;
                                    }                                        
                                }                                
                            }
                        }
                    }
                }
            }
        }
        stage('Update Helm chart') {
            steps {
                script {
                    def count = 0
                    while (true) {
                        try {                    
                            if (params.services == 'all') {
                                sh """
                                    git clone git@git.rikkei.org:devops/smp-development.git
                                    cd smp-development                                
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-alibaba-service/values-rikkei.yaml
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-api-gateway/values-rikkei.yaml
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-auth-service/values-rikkei.yaml
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-dispatch-service/values-rikkei.yaml
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-finance-service/values-rikkei.yaml
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-system-service/values-rikkei.yaml
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-user-service/values-rikkei.yaml
                                    git config --global user.email "taibt@rikkeisoft.com"
                                    git config --global user.name "taibt"
                                    git add .
                                    git commit -m 'update helm chart all service'
                                    git push                                
                                """
                            } else {
                                sh """
                                    git clone git@git.rikkei.org:devops/smp-development.git
                                    cd smp-development   
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/singhai-be-zhy-\${services}/values-rikkei.yaml
                                    git config --global user.email "taibt@rikkeisoft.com"
                                    git config --global user.name "taibt"
                                    git add .
                                    git commit -m 'update helm chart \${services}'
                                    git push                                
                                """
                            }
                            break;
                        } catch (Exception e) {
                              echo 'Exception occurred: ' + e.toString()
                        }
                        count ++
                        if (count == 10) {
                            break;
                        }
                    }
                }
            }
        }
    }
}

@NonCPS
def createTag() {
    date = new Date()
    def BUILD_NUMBER = env.BUILD_NUMBER
    def TAG = "${date.format('yyyyMMddHHmmss')}-${BUILD_NUMBER}"
    return TAG
}
