pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentialss' // your Jenkins Docker Hub credentials ID
        DOCKER_IMAGE_NAME = 'mehek08/java-docker-app'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/mehek89/Java-Docker-Appp.git'
            }
        }

        stage('Build Java App') {
            steps {
                echo 'Building Java application using Maven...'
                bat '"C:\\Users\\Mahak Modi\\Downloads\\apache-maven-3.9.11-bin\\apache-maven-3.9.11\\bin\\mvn.cmd" clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Get short Git commit ID for tagging
                    def commitId = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    env.IMAGE_TAG = commitId
                    echo "Building Docker image with tag: ${env.IMAGE_TAG}"
                    
                    // Build Docker image
                    bat "\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" build -t ${DOCKER_IMAGE_NAME}:${env.IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Logging into Docker Hub and pushing Docker image...'
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    // Docker login
                    bat "echo %DOCKER_PASS% | \"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" login --username %DOCKER_USER% --password-stdin"
                    
                    // Push image quietly
                    bat "\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" push --quiet ${DOCKER_IMAGE_NAME}:${env.IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully. Docker image ${DOCKER_IMAGE_NAME}:${env.IMAGE_TAG} pushed!"
        }
        failure {
            echo "Pipeline failed! Check console output for errors."
        }
    }
}
