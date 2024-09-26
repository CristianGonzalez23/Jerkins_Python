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
                // Ejecutar el comando de instalación con permisos elevados
                sh 'sudo pip install -r requirements.txt'
            }
        }
        stage('Start Server') {
            steps {
                // Iniciar el servidor de Python en segundo plano
                sh 'nohup python app.py &'
            }
        }
        stage('Run Tests') {
            steps {
                // Esperar unos segundos para asegurarse de que el servidor esté en funcionamiento
                sh 'sleep 10'
                // Ejecutar las pruebas
                sh 'behave -f allure_behave.formatter:AllureFormatter -o reports/'
            }
        }
    }
    post {
        always {
            // Detener el servidor de Python
            sh 'pkill -f "python app.py"'
            // Generar el reporte de Allure
            script {
                try {
                    sh 'allure generate reports/ -o allure-report'
                } catch (Exception e) {
                    echo 'Allure report generation failed'
                }
            }
            // Archivar los reportes
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