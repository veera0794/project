pipeline{
  agent any
  environment {
    BRANCH_NAME = "${env.BRANCH_NAME}"
    
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
          

