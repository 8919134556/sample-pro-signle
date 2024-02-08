
pipeline {
    agent any

    stages {
        stage('Checkout') {
            agent {
                label 'mdvr' // Specify the label of the Linux node here
            }
            steps {
                git branch: 'main', url: 'https://github.com/8919134556/sample-pro-signle.git'
            }
        }
        
        stage('Build Approval') {
            steps {
                script {
                    def buildApprovalURL = "${env.BUILD_URL}input"
                    def recipients = 'apeksha@infotracktelematics.com' // Add dynamic recipients here
                    def subject = 'Build Approval Needed' // Add dynamic subject here
                    // Send an email notification with a clickable URL for build approval
                    mail to: recipients,
                         subject: subject,
                         body: "Build process requires approval. Click the following link to approve or reject: ${buildApprovalURL}"
                }
                timeout(time: 5, unit: 'MINUTES') {
                    input message: 'Do you want to proceed with the build?', ok: 'Proceed'
                }
            }
        }
        
        stage('Build and Push Docker Image') {
            agent {
                label 'mdvr' // Specify the label of the Linux node here
            }
            steps {
                // Build Docker image
                sh 'docker build -t 9989228601/sample-project:16 .'
                
                // Push Docker image to Docker Hub registry
                withCredentials([usernamePassword(credentialsId: '377e98fd-7ba5-4b8f-a3a2-405f82ade900', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push 9989228601/sample-project:16'
                }
            }
        }
        
        stage('Deployment Approval') {
            steps {
                script {
                    def deploymentApprovalURL = "${env.BUILD_URL}input"
                    def recipients = 'suryaanand@infotracktelematics.com' // Add dynamic recipients here
                    def subject = 'Deployment Approval Needed' // Add dynamic subject here
                    // Send an email notification with a clickable URL for deployment approval
                    mail to: recipients,
                         subject: subject,
                         body: "Deployment to Kubernetes staging requires approval. Click the following link to approve or reject: ${deploymentApprovalURL}"
                }
                timeout(time: 5, unit: 'MINUTES') {
                    input message: 'Do you want to proceed with the deployment?', ok: 'Proceed'
                }
            }
        }
        
        stage('Deploy to Kubernetes Staging') {
            agent {
                label 'mdvr' // Specify the label of the Linux node here
            }
            steps {
                // Apply Kubernetes manifests to staging environment
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}