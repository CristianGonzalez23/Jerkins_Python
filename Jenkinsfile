pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/CristianGonzalez23/Jerkins_Python.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'behave -f allure_behave.formatter:AllureFormatter -o reports/'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'reports/**', allowEmptyArchive: true
            junit 'reports/**/*.xml'
        }
        failure {
            mail to: 'you@example.com',
                 subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                 body: "Something is wrong with ${env.BUILD_URL}"
        }
    }
}