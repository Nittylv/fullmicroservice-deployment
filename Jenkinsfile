pipeline {
    agent any

     tools {
        // Use the name you provided for Maven installation
        maven 'benny-mvn'
    }

    environment {
        DOCKER_IMAGE = "hello-world-java"
        ECR_REPO = "your-ecr-repo"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from Git repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/Nittylv/fullmicroservice-deployment.git']]])
            }
        }

        stage('Unit Tests') {
            steps {
                // Run unit tests using Maven
                sh "mvn test"
            }
        }

        stage('Integration Tests') {
            steps {
                // Run integration tests using Maven or your preferred testing framework
                sh "mvn integration-test"
            }
        }



        stage('Build Docker Image') {
            steps {
                script {
                    def dockerPath = tool name: 'benny-docker' // Replace 'ToolType' with the actual tool type used in your configuration
                    // Build the Docker image
                    sh "${dockerPath}/docker build -t $DOCKER_IMAGE ."
                }
            }
        }

        stage('Install Trivy') {
            steps {
                // Install Trivy
                sh "wget https://github.com/aquasecurity/trivy/releases/download/v0.20.0/trivy_0.20.0_Linux-64bit.deb"
                sh "sudo dpkg -i trivy_0.20.0_Linux-64bit.deb"
                sh "trivy --version"
            }
        }

        stage('Scan Docker Image') {
            steps {
                script {
                    // Scan the Docker image using Trivy
                    sh "trivy --severity HIGH,CRITICAL --no-progress $DOCKER_IMAGE"
                }
            }
        }

        stage('Static Code Analysis') {
            steps {
                // Execute static code analysis using SonarQube
                // Make sure to configure your SonarQube server in Jenkins before using this step
                withSonarQubeEnv('SonarQubeServer') {
                    sh "mvn clean package sonar:sonar -Dsonar.projectKey=my-project-key"
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                        credentialsId: 'your-aws-credentials-id'
                    ]]) {
                        // Log in to ECR
                        sh "aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin your-account-id.dkr.ecr.your-region.amazonaws.com"

                        // Tag the Docker image for ECR
                        sh "docker tag $DOCKER_IMAGE:latest $ECR_REPO:latest"

                        // Push the Docker image to ECR
                        sh "docker push $ECR_REPO:latest"
                    }
                }
            }
        }
    }
}
