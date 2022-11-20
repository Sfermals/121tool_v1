pipeline {
    environment {
        registry = 'sfermals/121tools'
        registryCredential = 'dockerHub'
        dockerImage = ''
    }

    agent any

    tools {nodejs "node"}

    stages {
        stage('Cloning git') {
      steps {
        git 'https://github.com/Sfermals/121TOOL_v1.git'
      }
    }

        stage('Build') {
            steps {
                echo 'Building...'
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'npm test'
            }
        }
        stage('Docker Build') {
    	    agent any
        steps {

      	    script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
            }
        }
        stage('Deploy Image') {
            steps{
            script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
            dockerImage.push('latest')
            }
            }
            }
            }
        stage ('Deploy') {
        steps {
            sh 'scp deploy.sh ubuntu@54.251.26.179:~/'
            sh 'ssh ubuntu@54.251.26.179 "chmod +x deploy.sh"'
            sh 'ssh ubuntu@54.251.26.179 ./deploy.sh'
        }
        }
    }
        post {  
         always {  
             echo 'This will always run'  
         }  
         success {  
              mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "SUCCESS CI: Project name -> ${env.JOB_NAME}", to: "azhar.sg@outlook.com";    
         }  
         failure {  
             mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "azhar.sg@outlook.com";  
         }  
         unstable {  
             echo 'This will run only if the run was marked as unstable'  
         }  
         changed {  
             echo 'This will run only if the state of the Pipeline has changed'  
             echo 'For example, if the Pipeline was previously failing but is now successful'  
         }
        }
    
}