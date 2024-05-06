pipeline {

    agent {
        kubernetes {
          yaml '''
            apiVersion: v1
            kind: Pod
            metadata:
              labels:
                app: jenkins-agent
            spec:
              imagePullPolicy: IfNotPresent
              imagePullSecrets:
              - name: regcred-repo-edsolabs
              containers:
              - name: jnlp
                image: jenkins/inbound-agent:3148.v532a_7e715ee3-1
                args: ['\$(JENKINS_SECRET)', '\$(JENKINS_NAME)']   
                volumeMounts:
                - name: data
                  mountPath: /data   
                env:
                - name: GIT_SSH_COMMAND
                  value: ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /data/SSH-KEY/id_rsa_bitbucket_b22dadtubac   
              - name: gitleaks
                image: zricethezav/gitleaks
                command:
                - cat
                tty: true


              volumes:
              - name: data
                persistentVolumeClaim:
                    claimName: jenkins-agent-pv
            '''
        }
    }
    stages {
        stage ("Secret Scanning") {
            // environment  {
            //     URL_WEBHOOK = credentails("urlwebhook")
            // }
            steps {
                script {
                    FAILED_STAGE=env.STAGE_NAME
                }
                container("gitleaks") {
                    script {
                        try {
                            def gitleaksCommand = "gitleaks detect -v -s . -f json -r gitleaks.json"
                            def scanOutput = sh(script: gitleaksCommand, returnStdout: true).trim()
                            println scanOutput
                            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: '', reportFiles: 'gitleaks-report.json', reportName: 'Gitleaks Report', reportTitles: ''])
                        } catch (Exception e) {
                            println "detect secret key"
                            exit 1
                            // office365ConnectorSend webhookUrl: "${URL_WEBHOOK}",
                            // message: 'Code is deployed',
                            // status: 'Success' 
                        }
                    }
                }
            }
        }
    }
}