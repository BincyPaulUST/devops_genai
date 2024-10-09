pipeline { 
    agent any

    environment {
        // Docker Hub Image Details
        DOCKER_IMAGE = '16bincyshalu/devops_repo1' 
        DOCKER_TAG = "${env.BUILD_NUMBER}" // You can also use 'latest' or other tags as needed
        
        // Credentials IDs
        DOCKERHUB_CREDENTIALS = 'docker-registry-credentials-id' // As defined in JCasC
        
        // Git Repository Details
        GIT_REPO = 'https://github.com/BincyPaulUST/devops_genai.git' // Your repository URL
        GIT_BRANCH = 'main' // Change to your desired branch
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with the specified tag
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Authenticate with Docker Hub and push the image
                    docker.withRegistry('https://registry.hub.docker.com', "${DOCKERHUB_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                        
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    // Remove unused Docker images to free up space
                    sh 'docker image prune -f'
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built and pushed to Docker Hub successfully!'
        }
        failure {
            echo 'Build failed. Check the logs for details.'
        }
    }
}
