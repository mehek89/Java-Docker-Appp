pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds' // Jenkins credentials ID
        DOCKER_IMAGE_NAME = 'mehek08/java-docker-app'
        DOCKER_IMAGE_TAG = 'latest'
    }

    tools {
        maven 'Maven3' // Name from Global Tool Configuration
        jdk 'JDK21'    // Name from Global Tool Configuration
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub
                git branch: 'main', url: 'https://github.com/mehek89/Java-Docker-Appp.git'
            }
        }

        stage('Build Java App') {
            steps {
                // Use Maven to build the app
                withMaven(maven: 'Maven3') {
                    bat 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                bat "docker build -t %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_TAG% ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                // Login using Jenkins credentials
                withCredentials([usernamePassword(
                    credentialsId: DOCKERHUB_CREDENTIALS, 
                    usernameVariable: 'DOCKER_USER', 
                    passwordVariable: 'DOCKER_PASS')]) {
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                // Push Docker image to Docker Hub
                bat "docker push %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_TAG%"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Docker image pushed to Docker Hub.'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
