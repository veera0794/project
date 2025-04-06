pipeline{
  agent any
  environment {
    BRANCH_NAME = "${env.BRANCH_NAME}"
}

  stages{
    stage('Checkout'){
      steps{
        checkout scm
      }
    }
    stage('Execution permission to scripts'){
      steps{
        sh '''
        chmod +x build.sh
        chmod +x deploy.sh
        '''
      }
    }
    stage('Build and Push Docker Image'){
      steps{
         sh'./build.sh'
        sh'./deploy.sh'
      }
    }
    stage('Pull the pushed image and Deploy to EC2') {
          steps{
            sh '''
            scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/grafana-key.pem deploy.sh ec2-user@13.218.164.137:/home/
            ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/grafana-key.pem ec2-user@13.218.164.137 "BRANCH_NAME bash deploy.sh"
            '''}
          }
          }
          }
          
          
            
