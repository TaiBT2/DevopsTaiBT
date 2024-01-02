#!/bin/bash
set -e
OUT=jmeter.save.saveservice.output_format
JMX_FOLDER=/home/jenkins/BCDT
JTL=/home/jenkins/reports/bcdt/$FILENAME-$SAMPLE-$LOOP-$RAMP_TIME.jtl
SCRIPTS=$FILENAME.jmx
sed -i -r "s|(stringProp name=\"LoopController.loops\">)(.+?)(</stringProp>)|\1${LOOP}\3|g" $JMX_FOLDER/$SCRIPTS
sed -i -r "s|(<stringProp name=\"ThreadGroup.num_threads\">)(.+?)(</stringProp>)|\1${SAMPLE}\3|g" $JMX_FOLDER/$SCRIPTS
sed -i -r "s|(<stringProp name=\"ThreadGroup.ramp_time\">)(.+?)(</stringProp>)|\1${RAMP_TIME}\3|g" $JMX_FOLDER/$SCRIPTS
echo $JTL
/home/jenkins/apache-jmeter-5.3/bin/jmeter -j $OUT=xml -n -t $JMX_FOLDER/$SCRIPTS -l $JTL
exit 0