pipeline {
    agent any
    
    //environment {
    //    ECR_REPO = "your-ecr-repo"

   }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }         
   } 
         stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
   }

         stage('Build Docker Image') {
            steps {
                sh 'docker build -t ms-app:1.0 .'
            }
   }









}    