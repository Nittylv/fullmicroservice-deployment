pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building docker image..'
                sh 'docker build -t ms-app:1.0 .'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}