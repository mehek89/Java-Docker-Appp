pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "mehek08/java-docker-app"
        DOCKERHUB_CREDENTIALS = "docker-hub-credentialss"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out code from GitHub..."
                git branch: 'main', url: 'https://github.com/mehek89/Java-Docker-Appp.git'
            }
        }

        stage('Build Java App') {
            steps {
                echo "Building Java application using Maven..."
                bat "\"C:\\Users\\Mahak Modi\\Downloads\\apache-maven-3.9.11-bin\\apache-maven-3.9.11\\bin\\mvn.cmd\" clean package -DskipTests"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Use Jenkins BUILD_NUMBER as Docker image tag
                    env.IMAGE_TAG = env.BUILD_NUMBER
                    echo "Building Docker image with tag: ${env.IMAGE_TAG}"
                    bat "\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" build -t ${DOCKER_IMAGE_NAME}:${env.IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Logging into Docker Hub and pushing Docker image..."
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", 
                                                 passwordVariable: 'DOCKER_PASS', 
                                                 usernameVariable: 'DOCKER_USER')]) {
                    bat "echo %DOCKER_PASS% | \"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" login --username %DOCKER_USER% --password-stdin"
                    bat "\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" push ${DOCKER_IMAGE_NAME}:${env.IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully. Docker image pushed: ${DOCKER_IMAGE_NAME}:${env.IMAGE_TAG}"
        }
        failure {
            echo "Pipeline failed! Check console output for errors."
        }
    }
}
