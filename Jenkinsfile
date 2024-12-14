pipeline {
   agent {label 'slavenode-13'}
   environment {
       // scannerHome = tool "SonarScanner"
        REGISTRY_URL="lakshmisatya"
        REPO_NAME="lakshmisatya"
        IMAGE_NAME="sri-devapp-frontend"
        IMAGE_TAG="latest"
        //HELM_REPO="https://nexus.sri.devapp.com/repository"
        HELM_CHART="sri.devapp-helm"
    }

    stages {
        // stage('Git Checkout') {
        //     steps {
        //     script{
        //         git 'https://github.com/devopsodia/sri-devapp-frontend.git'  
        //         }  
        //     }
        // }
    //     stage('Static code Analisys'){
    //         steps {
    //         script{
    //            def scannerHome = tool 'SonarScanner';
    //            withSonarQubeEnv() {
    //                 sh "${scannerHome}/bin/sonar-scanner"
    //             }
    //         }
    //     }    
            
    // }
        stage('Login to Nexus Repo') {
            steps {
            script {
                sh "docker login"
            }
        }
    }
	// Building Docker images
        stage('Building image') {
            steps{
            script {
                dockerImage = docker.build "${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
    	stage('Pushing to Nexus') {
		    steps{
		    script {
                sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY_URL}/${IMAGE_NAME}:$IMAGE_TAG"
                sh "docker push ${REGISTRY_URL}/${IMAGE_NAME}:$IMAGE_TAG"
			}
		  }
		}
        stage('Publish  Helm') {
            steps{
              script {  
                 echo "Packing helm chart"
                 sh "helm package -d ${WORKSPACE}/helm ${WORKSPACE}/helm/sri-devapp-frontend"
		 sh "helm upgrade --install myfrontend ${WORKSPACE}/helm/sri-devapp-frontend-1.0.0.tgz -n frontend"
                 //sh "curl -u admin:admin ${HELM_REPO}/${HELM_CHART} --upload-file ${WORKSPACE}/helm/sri-devapp-frontend-1.0.0.tgz -v"          
            }
         }
      }
   }
}
