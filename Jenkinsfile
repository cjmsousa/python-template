pipeline {
   
    agent any
   
    stages {

        stage("Build Development Container") {
            steps {
               
                //Build container in development mode
                echo "${env.BUILD_ID}"
                echo "${WORKSPACE}"
                echo "${WORKSPACE_TMP}"
                echo "${JOB_NAME}"
                sh("docker build --target development -t python-template:latest .")

            }
        }

        stage("Validate Code") {
            steps {
               echo "${STAGE_NAME}"
            }
        }

        stage("Run Unit Tests") {
            steps {
               echo "${STAGE_NAME}"
            }
        }

        stage("Run Integrations Tests") {
            steps {
               echo "${STAGE_NAME}"
            }
        }

        stage("Run End-to-End Tests") {
            steps {
               echo "${STAGE_NAME}"
            }
        }

        stage("Push to Docker Hub") {
            steps {
               echo "${STAGE_NAME}"
            }
        }
    }
}