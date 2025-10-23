pipeline {
    agent any

    environment {
        // Docker Hub credentials ID in Jenkins
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
        // Docker image name and tag
        DOCKER_IMAGE_NAME = 'mehek08/java-docker-app'
        DOCKER_IMAGE_TAG = 'latest'
        // Maven and Java paths
        MAVEN_HOME = 'C:\\Program Files\\Apache\\maven-3.9.9'
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk-21'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/mehek89/Java-Docker-Appp.git'
            }
        }

        stage('Build Java App') {
            steps {
                echo 'Building Java application using Maven...'
                bat "\"%MAVEN_HOME%\\bin\\mvn\" clean package -DskipTests"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat "docker build -t %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_TAG% ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                echo 'Logging in to Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: DOCKERHUB_CREDENTIALS,
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                bat "docker push %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_TAG%"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Docker image pushed to Docker Hub.'
        }
        failure {
            echo 'Pipeline failed! Check console output for errors.'
        }
    }
}
