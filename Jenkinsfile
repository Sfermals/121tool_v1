pipeline {
    triggers {
    githubPush()   //  pipeline triggered on new commits
    }
    options { 
        disableConcurrentBuilds() 
    }

    environment {
        registry = 'sfermals/121toolr'      // 1) change according to your repo name 
        registryCredential = 'dockerHub'           //* here i have added "r" at the end to differentiate release and staging 
        dockerImage = ''
    }                                       // 2) change registryCredential = <ID you used in docker credentials>

    agent any

    tools {nodejs "node"}

    stages {

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
                
                //push image to dockerhub
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
            }
            }
            }
            }
        stage ('Deploy') {
        steps {
            sh 'echo "Starting to deploy docker image...."'
            sh 'ssh ubuntu@18.143.190.255 "sudo docker run -d -p 3000:3000 sfermals/121toolr"'
                                   
                                                                 // 3) after the ports here: change to repo name
            
        }
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
    
