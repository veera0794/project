pipeline{
  agent any
  environment {
    BRANCH_NAME = "${env.BRANCH_NAME}"
    DOCKER_CREDENTIALS_ID = 'docker-hub-credential'
        DEPLOY_SERVER = '3.88.205.234'          // Deployment server
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
        withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
    sh '''
        export DOCKER_USER=$DOCKER_USER
        export DOCKER_PASS=$DOCKER_PASS
        ./build.sh
        ./deploy.sh
    '''
}


      }
    }
    stage('Pull the pushed image and Deploy to EC2') {
          steps{
      
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                    sh """
                    echo "Deploying with $USER"
                    scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/grafana-key.pem deploy.sh ec2-user@3.88.205.234:/home/ec2-user/
                    #ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/grafana-key.pem ec2-user@3.82.107.138 'bash /home/ec2-user/deploy.sh'
                    """
                    }               
}
          }
          }
}
          
