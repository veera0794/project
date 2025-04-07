pipeline{
  agent any
  environment {
    BRANCH_NAME = "${env.BRANCH_NAME}"
    SSH_CREDENTIALS_ID = 'SSH-credential'       // SSH credentials for deployment
        DEPLOY_SERVER = '3.84.157.233'          // Deployment server
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
      
                          sshagent([SSH_CREDENTIALS_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER << 'EOF'
                        cd $DEPLOY_PATH
                        docker pull your-app-image:prod
                        docker-compose down
                        docker-compose up -d
                    EOF
                    """
                }
}
          }
          }
}
          

