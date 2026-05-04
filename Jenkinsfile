pipeline {
    agent any

    stages {
        stage('Source Checkout') {
            steps {
                // Pulls the latest code from your GitHub repository
                checkout scm
            }
        }

        stage('Deploy to XAMPP') {
            steps {
                echo 'Deploying to C:\\xampp\\htdocs\\DEVOPS...'
                // Create the DEVOPS directory if it does not exist
                bat 'if not exist "C:\\xampp\\htdocs\\DEVOPS" mkdir "C:\\xampp\\htdocs\\DEVOPS"'
                // Copy all files to the XAMPP htdocs subfolder (/Y overwrites automatically)
                bat 'copy /Y * "C:\\xampp\\htdocs\\DEVOPS\\"'
                echo 'Traditional XAMPP Deployment Successful!'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker Image...'
                // Builds the image with the tag portfolio-app:v1
                bat 'docker build -t portfolio-app:v1 .'
            }
        }

        stage('Docker Run') {
            steps {
                echo 'Cleaning old container and starting new one on Port 8083...'
                /* 
                   Force remove the old container if it exists. 
                   Using '|| ver > nul' prevents the pipeline from failing if the container isn't found.
                */
                bat 'docker rm -f portfolio-container || ver > nul'
                
                // Run the new container on port 8083
                bat 'docker run -d --name portfolio-container -p 8083:80 portfolio-app:v1'
                echo 'Containerized Deployment Successful on Port 8083!'
            }
        }
    }

    post {
        success {
            echo 'Pipeline Execution Finished Successfully!'
            echo 'Access XAMPP at: http://localhost/DEVOPS/index.html'
            echo 'Access Docker at: http://localhost:8083'
        }
        failure {
            echo 'Pipeline Failed. Please check the Console Output for errors.'
        }
    }
}
