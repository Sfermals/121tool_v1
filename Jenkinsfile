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
        stage('Run Docker container on remote hosts') {
            
            def dockerrun = 'docker container run -p 3000:3000 -d --name sfermals sfermals/121tools tail -f /dev/null'
            def docker_image = ' docker image rmi -f sfermals/121tools'
            
            
            sh "ssh -o StrictHostKeyChecking=no ubuntu@54.251.26.179 ${docker_image}"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@54.251.26.179 ${dockerrun}"
        }
    }
    post {
        always {
            echo 'end of pipeline'
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            
        }
    }
}
}