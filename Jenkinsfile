pipeline {
   
    agent any

    environment {
        IMAGE_NAME = "${JOB_NAME}"
        IMAGE_TAG = "${BUILD_ID}"
        APP_PORT = 5000
    }
   
    stages {

        stage("Create Development Container") {
            steps {
                //Build container in development mode
                sh("docker build --target development -t ${IMAGE_NAME}:${IMAGE_TAG} .")
                sh('docker run -d -p ${APP_PORT}:${APP_PORT} ${IMAGE_NAME}:${IMAGE_TAG}')
            }
        }

        stage("Validate Code") {
            steps {
                sh('')
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