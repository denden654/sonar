pipeline {
    agent any

    tools {
        maven 'M2_HOME'
        jdk 'JAVA_HOME'
    }

    environment {
        SONAR_TOKEN = credentials('jenkins-sonar')
        GIT_CREDS   = credentials('github-creds')
    }

    stages {
        stage('Checkout Git') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/denden654/sonar.git',
                    credentialsId: 'github-creds'
            }
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sqsd') {
                    sh 'mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN}'
                }
            }
        }

        stage('Package (JAR)') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }


        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
                stage('Build Docker Image') {
                    steps {
                        script {
                            // Construire l'image Docker à partir du Dockerfile
                            dockerImage = docker.build("saifdenden/sonar:latest")
                        }
                    }
                }

                stage('Push Docker Image') {
                    steps {
                        script {
                            // Pousser l'image sur Docker Hub avec tes credentials Jenkins
                            docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                                dockerImage.push('latest')
                            }
                        }
                    }
                }

    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline CI réussi !'
        }
        failure {
            echo 'Échec du pipeline '
        }
    }
}
