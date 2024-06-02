pipeline {
    environment {
        registry = "rkapp.vcenter.com.vn/dotalk-sdk/dev/be"
        registryCredential = 'dg1repo'
        tag = "rk-${createTag()}"
    }
    agent {
        node {
            label 'sdk' 
        }

    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/dev-golive']], userRemoteConfigs: [[url: 'git@git.rikkei.org:dg1/dotalk-sdk/beclientportal.git', credentialsId: 'git-ssh-rk']]])
            }
        }
        stage('add .env file') {
            steps {
                sh """
                cat <<EOF > .env
key=value                
                """
            }
        }           
        stage('Build Docker Image') {
            steps {
                echo 'Testing....'
                withCredentials([
                    usernamePassword(
                        credentialsId: "dg1repo",
                        usernameVariable: 'REGISTRY_USER', passwordVariable: 'REGISTRY_PASS'
                    )
                ]) {
                    script {
                        sh """
                            echo \$REGISTRY_PASS | docker login --username  \$REGISTRY_USER    rkapp.vcenter.com.vn --password-stdin
                            docker build -f dev.Dockerfile --tag \${registry}:\${tag} . --no-cache
                            docker push \${registry}:\${tag}                            
                        """
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
                            sh """
                                    cd /home/dg1-swe-sv/agent/sdk/dotalk-development
                                    git pull
                                    sed -i 's/tag: .*/tag: ${tag}/' helmchart/dotalk-be/values-dev.yaml
                                    git config --global user.email "taibt@rikkeisoft.com"
                                    git config --global user.name "taibt"
                                    git add .
                                    git commit -m 'update be dotalk'
                                    git push                     
                            """
                            break
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
