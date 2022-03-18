@Library('test_shared_library')
import org.ganemo.BuildImages

def utils = new BuildImages(this)

def tagname

pipeline{
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '5')) 
    }
    
    agent any
    
    environment { 
        registry = "odoopartners/odoo:$BRANCH_NAME" 
        registryCredential = 'dockerhubtestid' 
        dockerImage = '' 
    }
    
    stages{
        
        stage("Cloning Repositories"){
            steps{
                script{
                    utils.cloneRepositories(git_credentials:"odoopartnersid",branch_to_clone:"15-dev")
                }
            }
        }
        
        stage("Building Image"){
            steps{
                script{
                    dockerImage = utils.buildImage(odoo_version:"15.0",registryCredential:"${registryCredential}",tagname_sanitized:"${registry}")
                }
            }
        }
        
        stage("Publishing Image to Docker Hub"){
            steps{
                script{
                    utils.publishImage(registryCredential:"${registryCredential}")
                }
            }
        }
        
        stage("Cleaning Up"){
            steps{
                script{
                    utils.cleanUp "${registry}"
                }
            }
        }

        stage("Restarting Test Deployment"){
            steps{
                script{

                   def deployment_name = "test-odoo15"

                   sshagent(credentials: ['34.197.227.39']) {
                       sh """ 
                           ssh -o StrictHostKeyChecking=no -l ubuntu 34.197.227.39 -A "kubectl rollout restart deployment ${deployment_name} -n odoo" 
                           """
                   }

                }
            }
        }


        
    }
    
    post {
        always {
            deleteDir()
        }
    }
    
}
