

pipeline {
    agent { node { label 'loadtest' } }
    environment {
        OUT= "jmeter.save.saveservice.output_format"
        // JTL="/home/jenkins/reports/lgsp/${FILENAME-$SAMPLE}-${LOOP}-${RAMP_TIME}.jtl"

    }
    stages {
        stage("Test Performance") {
            steps {
                // sh '''
                //     sed -i -r "s|(stringProp name=\"LoopController.loops\">)(.+?)(</stringProp>)|\1${LOOP}\3|g" $JMX_FOLDER/$SCRIPTS
                //     sed -i -r "s|(<stringProp name=\"ThreadGroup.num_threads\">)(.+?)(</stringProp>)|\1${SAMPLE}\3|g" $JMX_FOLDER/$SCRIPTS
                //     sed -i -r "s|(<stringProp name=\"ThreadGroup.ramp_time\">)(.+?)(</stringProp>)|\1${RAMP_TIME}\3|g" $JMX_FOLDER/$SCRIPTS
                //     /home/jenkins/apache-jmeter-5.3/bin/jmeter -j $OUT=xml -n -t $JMX_FOLDER/$SCRIPTS -l $JTL
                // // // // // // // '''
                sh " /home/jenkins/apache-jmeter-5.3/bin/jmeter -h"
            }
        }
    }
}