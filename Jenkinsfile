pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credential' // Docker Hub credentials ID
        SSH_CREDENTIALS_ID = 'SSH-credential'       // SSH credentials for deployment
        DEPLOY_SERVER = '3.85.159.148'          // Deployment server
        DEPLOY_PATH = '/var/www/app'                    // Deployment path
    }
    stages {
                stage('Clone Repository') {
            steps {
                git 'https://github.com/veera0794/project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = env.BRANCH_NAME == 'master' ? 'prod' : env.BRANCH_NAME
                    echo "Building image with tag: ${imageTag}"
                    docker.build("your-app-image:${imageTag}")
                    
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    def imageTag = env.BRANCH_NAME == 'master' ? 'prod' : 'dev'
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("your-app-image:${imageTag}").push("${imageTag}")
                    }
                }
            }
        }
        stage('Deploy to Server') {
            when {
                branch 'master'
            }
            steps {
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
    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}

