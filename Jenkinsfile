pipeline { 
    environment { 
        registry = "gtd777/testbuild" 
        registryCredential = 'dockerhubtestid' 
        dockerImage = '' 
    }
    agent any 
    stages { 
        stage('Building Image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        stage('Publishing Image to Docker Hub') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
    }
}

