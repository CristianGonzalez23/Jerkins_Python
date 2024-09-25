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
                sh 'mkdir -p reports'
                sh 'behave -f allure_behave.formatter:AllureFormatter -o reports/'
            }
        }
    }
    post {
        always {
            script {
                try {
                    sh 'allure generate reports/ -o allure-report'
                } catch (Exception e) {
                    echo 'Allure report generation failed'
                }
            }
            archiveArtifacts artifacts: 'reports/**/*.json', allowEmptyArchive: true
            archiveArtifacts artifacts: 'allure-report/**', allowEmptyArchive: true
        }
        failure {
            mail to: 'you@example.com',
                 subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                 body: "Something is wrong with ${env.BUILD_URL}"
        }
    }
}