pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'purna303703/zero-downtime-app' // Replace with your exact Docker Hub username
        SONAR_HOST_URL = 'https://Badland-deserve-ducking.ngrok-free.dev'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Compile & Unit Test') {
            steps {
                sh 'chmod +x mvnw && ./mvnw clean test'
            }
        }

        stage('SonarQube Static Analysis') {
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh "chmod +x mvnw && ./mvnw sonar:sonar -Dsonar.host.url=${SONAR_HOST_URL} -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }

        stage('Docker Multi-Stage Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${GIT_COMMIT} -t ${DOCKER_IMAGE}:latest ."
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}:${GIT_COMMIT}"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}