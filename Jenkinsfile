pipeline {
    agent any

    environment {
        DOCKER_USER = 'mehek08'
        DOCKER_PASS = credentials('docker-hub-credentialss') // Your Docker Hub credentials ID
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
                bat '"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe" build -t mehek08/java-docker-app:latest .'
            }
        }

        stage('Login to Docker Hub & Push Image') {
            steps {
                echo 'Logging into Docker Hub and pushing Docker image...'
                // Docker login
                bat(script: "echo %DOCKER_PASS% | \"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\" login --username %DOCKER_USER% --password-stdin", returnStatus: true)
                // Docker push
                bat(script: '"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe" push mehek08/java-docker-app:latest', returnStatus: true)
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
