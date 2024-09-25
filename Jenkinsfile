pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/CristianGonzalez23/Jerkins_Python.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'behave'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'reports/**', allowEmptyArchive: true
            junit 'reports/**/*.xml'
        }
    }
}