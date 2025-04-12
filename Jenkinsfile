pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'mybvc365/medicio:latest'
        APP_SERVER = 'ec2-user@3.224.127.93'
    }
 
    stages {
       stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Mybvc365/medicalwebsite.git'
            }
        }
 
        stage('Build & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker build -t $DOCKER_IMAGE .
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }
 
        stage('Deploy on App Server') {
            steps {
                sshagent(credentials: ['app-server-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no $APP_SERVER "
                            docker pull $DOCKER_IMAGE &&
                            docker stop myapp || true &&
                            docker rm myapp || true &&
                            docker run -d --name myapp -p 80:80 $DOCKER_IMAGE
                        "
                    '''
                }
            }
        }
    }
}

 
