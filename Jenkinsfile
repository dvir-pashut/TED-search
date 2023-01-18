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
        maven "maven 3.6.2"
        jdk "java 8 kit"
    }
    stages{
        stage("checkout"){
            steps{
                echo "========checking out (loking hella fine)========"
                deleteDir()
                checkout scm
                sh "mvn clean"
                sh "git checkout main"
            }
        }
         stage("build"){
            steps{
                // starting build
                echo "========executing build========"
                withMaven {
                    sh "mvn -s ${set} verify"
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
