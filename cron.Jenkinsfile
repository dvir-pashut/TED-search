def up
pipeline{
    agent any 
    stages{
        stage("A"){
            steps{
            echo "========executing what is up========"
            sh """
                pushd terr
                terraform workspace select dev
                dev_env=\$(terraform show | wc -l)
                terraform workspace select prod
                prod_env=\$(terraform show | wc -l)
                what_is_up=()

                if [ ${dev_env} != "1" ];
                then 
                    what_is_up+=("dev")
                    export dev_env="up"
                else
                    export dev_env="down"
                fi

                if [ ${prod_env} != "1" ];
                then 
                    what_is_up+=("prod")
                    export prod_env="up"
                else
                    export prod_env="down"
                fi

                echo "prod env is \${prod_env}"
                echo "dev env is  \${dev_env}"
            """
            }
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
                }
            }
        }
    }
    post{
        always{
            echo "========piplen ended!!!!!!!!!!!!!!!!!!========"
            
            // sending emails 
            emailext body: """Status Report
                    Project: ${env.JOB_NAME} 
                    what is up : \${what_is_up[@]}"""
                recipientProviders: [developers(), requestor()],
                subject: 'tests resulte: Project name -> ${JOB_NAME}'
        }
    }
}