pipeline {
    agent any
    environment {
        GIT_CREDENTIALS_ID = 'SHA256:70iZH7ffbCG7IWjsZeo1qipWI4AuJwJtBPHxjRVR/Bg'  // Reemplaza con el ID de las credenciales que creaste
    }
    stages {
        stage('Clonar Repositorio') {
            steps {
                git branch: 'main', url: 'https://github.com/CristianGonzalez23/Jerkins_Python.git', credentialsId: env.GIT_CREDENTIALS_ID
            }
        }
        stage('Instalar Dependencias') {
            steps {
                script {
                    // Instalar dependencias
                    sh 'pip install -r requirements.txt'
                }
            }
        }
        stage('Ejecutar Pruebas con Allure') {
            steps {
                script {
                    // Ejecutar pruebas con Behave y generar reportes Allure
                    sh 'behave -f allure_behave.formatter:AllureFormatter -o reports/'
                }
            }
        }
        stage('Publicar Reportes Allure') {
            steps {
                allure([
                    includeProperties: false,
                    reportBuildPolicy: 'ALWAYS',
                    results: [[path: 'reports/']]
                ])
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '**/reports/*.json', allowEmptyArchive: true
        }
        success {
            echo 'Las pruebas fueron exitosas.'
        }
        failure {
            echo 'Las pruebas fallaron.'
        }
    }
}
