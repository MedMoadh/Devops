pipeline {
  
  agent any


  stages {

    stage ('Checkout GIT') {
            steps {
               echo 'Pulling...';
               git branch : 'maysa_branch',
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
                sh 'mvn clean install -DskipTests'
              }
           }
           stage ('Artifact construction') {
              steps {
                 sh 'echo "Artifact construction is processing ...."'
                 sh 'mvn  package -DskipTests'
              }

           }
           /*stage('Junit Testing') {
              steps{
                  sh 'echo "Junit Test is processing ...."'
                  sh 'mvn  test'
              }
           }*/
           stage('Sonar Check'){
              steps{
                 script{
           			withSonarQubeEnv('sonar') {
           			   sh "mvn compile sonar:sonar -Dsonar.login=admin -Dsonar.password=maysa"
                    }
                    //sh "mvn clean install"
           		 }
              }
           }
           stage("Publish to Nexus Repo_Man") {
              steps {

                 sh 'mvn deploy -DskipTests'
              }

           }

  /*post {
          success {
               mail to: "nefzimaysa27@gmail.com",
                      subject: "Build sucess",
                      body: "sucess"
              echo 'successful'
          }
         failure {
               mail to: "nefzimaysa27@gmail.com",
                      subject: "Build failed",
                      body: "failed"
              echo 'failed'
          }
        }*/

}
}
