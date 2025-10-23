pipeline {
    agent any

    environment {
        // Docker image name & tag
        DOCKER_IMAGE_NAME = 'mehek08/java-docker-app'
        DOCKER_IMAGE_TAG = 'latest'

        // Path to Docker executable on Windows
        DOCKER_PATH = '"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe"'

        // Path to Maven on Windows
        MAVEN_HOME = '"C:\\Users\\Mahak Modi\\Downloads\\apache-maven-3.9.11-bin\\apache-maven-3.9.11"'
    }

    stages {

        stage('Checkout SCM') {
            steps {
                echo 'Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/mehek89/Java-Docker-Appp.git'
            }
        }

        stage('Build Java App') {
            steps {
                echo 'Building Java application using Maven...'
                bat "${MAVEN_HOME}\\bin\\mvn.cmd clean package -DskipTests"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat "${DOCKER_PATH} build -t %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_TAG% ."
            }
        }

        stage('Login to Docker Hub & Push Image') {
            steps {
                echo 'Logging into Docker Hub and pushing Docker image...'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    // Secure login using password-stdin
                    bat """echo %DOCKER_PASS% | ${DOCKER_PATH} login --username %DOCKER_USER% --password-stdin"""
                    
                    // Push Docker image
                    bat "${DOCKER_PATH} push %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_TAG%"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Docker image pushed.'
        }
        failure {
            echo 'Pipeline failed! Check console output for errors.'
        }
    }
}
