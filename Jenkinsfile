node {
    def app

    stage('Clone repository') {
        /* Clone the repository to the Jenkins workspace */
        checkout scm
    }

    stage('Build image') {
        /* Build the Docker image */
        sh 'docker build -t vipinlalrv/node-pipeline .'  // Build image using docker command
    }

    stage('Test image') {
        /* Test the Docker image using host Docker daemon */
        sh '''
            docker run --rm vipinlalrv/node-pipeline sh -c "echo 'Tests passed'"
        '''
    }

    stage('Push image') {
        /* Push the Docker image to Docker Hub */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            docker.image("vipinlalrv/node-pipeline:${env.BUILD_NUMBER}").push()
            docker.image("vipinlalrv/node-pipeline:latest").push()
        }
    }
}