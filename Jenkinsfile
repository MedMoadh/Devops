pipeline {
  
  agent any

 environment {
         DOCKERHUB_CREDENTIALS = credentials('DockerHubID')
         NEXUS_VERSION = "nexus3"
         NEXUS_PROTOCOL = "http"
         NEXUS_URL = "172.10.0.140:8081/"
         NEXUS_REPOSITORY = "java-app"
         NEXUS_CREDENTIAL_ID = "nexus_credentials"
     }

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
           stage('Junit Testing') {
              steps{
                  sh 'echo "Junit Test is processing ...."'
                  sh 'mvn  test'
              }
           }

           stage('Sonar Check'){
              steps{
                 script{
           			withSonarQubeEnv('sonar') {
           			   sh "mvn compile sonar:sonar -Dsonar.login=admin -Dsonar.password=maysa"
                    }
           		 }
              }
           }
           /*stage("Publish to Nexus Repo_Man") {
              steps {

                 sh 'mvn deploy -DskipTests'
              }

           }*/


           stage("Publish to Nexus Repository Manager") {
                       steps {
                           script {
                               pom = readMavenPom file: "pom.xml";
                               filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                               echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                               artifactPath = filesByGlob[0].path;
                               artifactExists = fileExists artifactPath;
                               if(artifactExists) {
                                   echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                                   nexusArtifactUploader(
                                       nexusVersion: NEXUS_VERSION,
                                       protocol: NEXUS_PROTOCOL,
                                       nexusUrl: NEXUS_URL,
                                       groupId: pom.groupId,
                                       version: pom.version,
                                       repository: NEXUS_REPOSITORY,
                                       credentialsId: NEXUS_CREDENTIAL_ID,
                                       artifacts: [
                                           [artifactId: pom.artifactId,
                                           classifier: '',
                                           file: artifactPath,
                                           type: pom.packaging],
                                           [artifactId: pom.artifactId,
                                           classifier: '',
                                           file: "pom.xml",
                                           type: "pom"]
                                       ]
                                   );
                               } else {
                                   error "*** File: ${artifactPath}, could not be found";
                               }
                           }
                       }
           }



                    stage('Docker build') {
                       	agent any
                         steps {
                           sh 'echo "Docker is building ...."'
                         	sh 'docker build -t $DOCKERHUB_CREDENTIALS_USR/devops_project .'
                         }
                     }


                       stage('Docker login') {
                       	agent any
                         steps {
                           sh 'echo "login Docker ...."'
                         	//sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
                         }
                       }


                       stage('Docker push') {
                       	agent any
                         steps {
                           sh 'echo "Docker is pushing ...."'
                   	   //sh 'docker push $DOCKERHUB_CREDENTIALS_USR/devops_project'

                         }
                       }


                       stage('docker check containers') {
                         steps {

                           sh 'docker ps'
                         }
                       }
}






 post {
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
 }

}

