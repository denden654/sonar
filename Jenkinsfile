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
                pipeline {
                    agent any

                    environment {
                        DOCKER_IMAGE = "mydockeruser/tpdevopssaifden:latest"
                    }

                    stages {
                        stage('Build Docker Image') {
                            steps {
                                script {
                                    // Build l'image Docker à partir du Dockerfile à la racine
                                    docker.build(DOCKER_IMAGE)
                                }
                            }
                        }

                        stage('Push Docker Image') {
                            steps {
                                script {
                                    // Push l'image sur Docker Hub
                                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                                        docker.image(DOCKER_IMAGE).push()
                                    }
                                }
                            }
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
