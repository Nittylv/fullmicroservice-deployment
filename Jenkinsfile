pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1' // Replace with your desired AWS region
        BUILD_ID = 
        
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your code from version control
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile in your repository
                script {
                    def buildId = env.BUILD_ID
                    dockerImage = docker.build("my-ms-app:${env.BUILD_ID}")
                }
            }
        }
    }
}
       