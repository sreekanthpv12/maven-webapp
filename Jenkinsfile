
pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage ('git repo') {
            steps {
                git branch: 'master', url: 'https://github.com/sreekanthpv12/maven-webapp.git'
            }
        }
        
        stage ('mvn build') {
           steps {
               
               
               withSonarQubeEnv('SonarQube'){
                        sh """mvn install sonar:sonar \
                       -Dsonar.organization=sreekanthpv12 \
                        -Dsonar.projectKey=sreekanthpv12_maven-webapp \
                        -Dsonar.host.url=https://sonarcloud.io
                          """
               }

           }
        }
        stage('Build Docker Image') {
            steps {
                script {
                  sh 'docker build -t sreekanthpv12/maven-webapp .'
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {
                script {
                withCredentials([string(credentialsId: 'sreekanthpv12', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u sreekanthpv12 -p ${dockerhubpwd}'
                   sh 'docker push sreekanthpv12/maven-webapp'
                    
                    
                }
   
                    }
                
                
            }
        }
    }
    post {
        always {
            sh 'docker rmi sreekanthpv12/maven-webapp'
            sh 'docker logout'
        }
    }
}

