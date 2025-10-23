pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mehek08/java-docker-app:latest'
        MVN_HOME = 'C:\\Users\\Mahak Modi\\Downloads\\apache-maven-3.9.11-bin\\apache-maven-3.9.11'
        DOCKER_PATH = 'C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Checking out code from GitHub...'
                git branch: 'main',
                    url: 'https://github.com/mehek89/Java-Docker-Appp.git'
            }
        }

        stage('Build Java App') {
            steps {
                echo 'Building Java application using Maven...'
                bat "\"${MVN_HOME}\\bin\\mvn.cmd\" clean package -DskipTests"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat "\"${DOCKER_PATH}\" build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Login to Docker Hub & Push Image') {
            steps {
                echo 'Logging into Docker Hub and pushing Docker image...'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentialss',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    bat """echo %DOCKER_PASS% | \"${DOCKER_PATH}\" login --username %DOCKER_USER% --password-stdin"""
                    bat "\"${DOCKER_PATH}\" push ${DOCKER_IMAGE}"
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
