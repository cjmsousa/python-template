pipeline {
   
    agent any

    environment {
        IMAGE_NAME = "${JOB_NAME}" 
        IMAGE_TAG = "${BUILD_ID}"
    }
   
    stages {

        stage("Build Development Container") {
            steps {
                //Build container in development mode
                sh("docker build --target development -t ${IMAGE_NAME}:${IMAGE_TAG} .")
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