node {
    def app

    stage('Clone repository') {
        /* Clone the repository to the workspace */
        checkout scm
    }

    stage('Build image') {
        /* Build the Docker image */
        app = docker.build("vipinlalrv/node-pipeline")
    }

    stage('Test image') {
        /* Test the Docker image */
        app.inside {
            sh 'echo "Tests passed"'
            // You can replace the above line with actual test commands
        }
    }

    stage('Push image') {
        /* Push the Docker image to the registry with two tags */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
