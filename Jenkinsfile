pipeline {
    environment {
        registry = 'sfermals/121toolr'
        registryCredential = 'dockerHub'
        dockerImage = ''
    }

    agent any

    tools {nodejs "node"}

    stages {
        stage('Cloning git') {
      steps {
        git 'https://github.com/Sfermals/121tool_v1.git'
        
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
    }
