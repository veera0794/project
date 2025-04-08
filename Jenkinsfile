pipeline{
  agent any
  environment {
    BRANCH_NAME = "${env.BRANCH_NAME}"
    DOCKER_CREDENTIALS_ID = 'docker-hub-credential'
        DEPLOY_SERVER = '3.85.159.148'          // Deployment server
        DEPLOY_PATH = '/var/www/app'                    // Deployment path

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
        
      }
    }
    stage('Pull the pushed image and Deploy to EC2') {
          steps{
      
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                    sh """
                    echo "Deploying with $USER"
                    scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/grafana-key.pem deploy.sh ec2-user@3.85.159.148:/home/ec2-user/
                    """
                    }               
}
          }
          }
}
          

