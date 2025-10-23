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

        stage('Login to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub...'
                // You can store credentials in Jenkins and use withCredentials
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat "${DOCKER_PATH} login -u %DOCKER_USER% -p %DOCKER_PASS%"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                bat "${DOCKER_PATH} push %DOCKER_IMAGE_NAME%:%DOCKER_IMAGE_TAG%"
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
