pipeline{
    agent any
     options{
        // set time stamps on the log
        timestamps()
        
        // set gitlab connection where to sent an update
        gitLabConnection('my repo')
    }
    tools {
        // set tools to work with 
        terraform "terraform-1.3.7"
        maven "maven 3.6.2"
        jdk "java 8 kit"
    }
    stages{
        stage("checkout"){
            steps{
                echo "========checking out (loking hella fine)========"
                deleteDir()
                checkout scm
                sh """
                    cd app
                    mvn clean
                """
                sh "git checkout main"
            }
        }
        stage("build"){
            steps{
                // starting build
                echo "========executing build========"
                withMaven {
                    sh """
                    cd app
                    mvn verify
                    ls
                    docker save -o ../to-send/image.tar embedash:1.1-SNAPSHOT
                    chmod 777 ../to-send/image.tar
                    """
                } // withMaven will discover the generated Maven artifacts, JUnit Surefire & FailSafe reports and FindBugs reports
            }
            post{
                success{
                    echo "========build executed successfully========"
                }
                failure{
                    echo "========build execution failed========"
                }
            }
        }
        stage("tests"){
            steps{
                // starting build
                echo "========executing tests========"
                sh """
                    cd terr
                    terraform init
                    terraform workspace select dev
                    terraform apply -auto-approve -var-file dev.tfvars
                """
                sh "bash e2e-tests.sh"

            }
            post{
                always{
                    sh """
                        cd terr
                        terraform workspace select dev
                        terraform destroy -auto-approve -var-file dev.tfvars
                    """
                }
                success{
                    echo "========tests executed successfully========"
                }
                failure{
                    echo "========tests execution failed========"
                }
            }
        }
        
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
    
}
