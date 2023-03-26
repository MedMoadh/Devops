pipeline {
  
  agent any


  stages {

    stage ('Checkout GIT') {
            steps {
               echo 'Pulling...';
               git branch : 'main',
               url : 'https://github.com/maynef/Devops.git';

            }
        }
        stage ('Testing MVN') {
                    steps {
                       sh """mvn -version"""
                    }
                }
        stage('Cleaning the Project') {
              steps {
                 sh 'echo "Clean the Project is processing ...."'
                sh 'mvn clean'

              }

        }
           stage('Clean install') {
              steps {
                 sh 'echo "Clean the Project is processing ...."'
                sh 'mvn clean install -Dmaven.test.skip=true '
              }
           }
           stage ('Artifact construction') {
              steps {
                 sh 'echo "Artifact construction is processing ...."'
                 sh 'mvn  package -Dmaven.test.skip=true'
              }
           	  post {
           	     success {
           	       archiveArtifacts artifacts: 'target/*.jar'
           	     }
              }
           }
           stage('Junit Testing') {
              steps{
                  sh 'echo "Junit Test is processing ...."'
                  sh 'mvn  test'
              }
           }
  }

}
