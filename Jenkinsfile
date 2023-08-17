pipeline {
    agent any
    
    environment {
        ECR_REPO = "your-ecr-repo"
        EKS_CLUSTER = "your-eks-cluster-name"
        EKS_NAMESPACE = "your-namespace"
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
        
        stage('Scan Image using Trivy') {
            steps {
                sh 'trivy image -q -s HIGH,CRITICAL docker-image-name'
            }
        }
        
        stage('Push to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-id', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh "aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin $ECR_REPO"
                    sh "docker build -t $ECR_REPO:latest ."
                    sh "docker push $ECR_REPO:latest"
                }
            }
        }
        
        stage('Deploy to EKS') {
            steps {
                script {
                    def eksConfig = """
                    apiVersion: apps/v1
                    kind: Deployment
                    metadata:
                      name: your-app-deployment
                      namespace: $EKS_NAMESPACE
                    spec:
                      replicas: 3
                      selector:
                        matchLabels:
                          app: your-app
                      template:
                        metadata:
                          labels:
                            app: your-app
                        spec:
                          containers:
                          - name: your-app
                            image: $ECR_REPO:latest
                            ports:
                            - containerPort: 80
                    """
                    
                    writeFile file: 'eks-deployment.yaml', text: eksConfig
                    
                    sh "kubectl apply -f eks-deployment.yaml --kubeconfig /path/to/your/kubeconfig"
                }
            }
        }
    }
}
