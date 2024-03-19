pipeline {
    agent any
    stages {
        stage('migrate database') {
            steps {
                sh '''
                    echo "migrating database"
                    apt update
                    apt install wget
                    apt install lsb-release
                    wget https://dev.mysql.com/get/mysql-apt-config_0.8.24-1_all.deb
                    ls
                    dpkg -r mysql-apt-config*
                    apt update
                    apt install mysql-server
                    mysql -h
                '''
            }
        }
    }
}