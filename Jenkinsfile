pipeline {
    agent any
    stages {

       stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }         


        stage('Build') {
            steps {
                sh 'docker build -t ms-app:1.0 .'
                echo 'buidling docker image'
            }
        }

        //stage('Test') {
        //    steps {
                // Test steps go here
        //    }
       // }
       // stage('Deploy') {
        //    steps {
                // Deployment steps go here
        //    }
       // }

       } 

     }

}

  