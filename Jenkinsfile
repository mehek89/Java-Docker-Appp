pipeline {
    agent any

    environment {
        DOCKER_USER = 'mehek08'
        DOCKER_PASS = credentials('docker-hub-credentialss') // Docker Hub credentials ID
        IMAGE_NAME = "mehek08/java-docker-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Checking out code from GitHub...'
                git branch: 'main',
                    url: 'https://github.com/mehek89/Java-Docker-Appp.git',
                    credentialsId: '' // Add Git credentials if repo is private
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
                echo 'Building Docker image...'
                script {
                    def status = bat(script: "\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" build -t ${IMAGE_NAME}:${IMAGE_TAG} .", returnStatus: true)
                    if (status != 0) {
                        error "Docker build failed!"
                    }
                }
            }
        }

        stage('Push Docker Image if New') {
            steps {
                echo 'Checking if Docker image already exists on Docker Hub...'
                script {
                    def remoteDigest = bat(script: "\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" manifest inspect ${IMAGE_NAME}:${IMAGE_TAG}", returnStatus: true)
                    if (remoteDigest != 0) {
                        echo 'Docker image does not exist remotely. Logging in and pushing...'
                        // Login
                        bat(script: "echo %DOCKER_PASS% | \"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" login --username %DOCKER_USER% --password-stdin")
                        // Push
                        bat("\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" push ${IMAGE_NAME}:${IMAGE_TAG}")
                    } else {
                        echo 'Docker image already exists. Skipping push.'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed! Check console output for errors.'
        }
    }
}
