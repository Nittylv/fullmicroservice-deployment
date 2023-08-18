pipeline {
    agent any

    environment {
        ECR_REPO = "902439583999.dkr.ecr.us-east-1.amazonaws.com/ms-hub"
        EKS_CLUSTER = "your-eks-cluster-name"
        EKS_NAMESPACE = "your-namespace"
        AWS_REGION = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        