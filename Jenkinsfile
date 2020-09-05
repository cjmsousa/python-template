pipeline {
   
    agent any

    environment {
        IMAGE_NAME = "${JOB_NAME}"
        IMAGE_TAG = "${BUILD_ID}"
        APP_PORT = 5000
        DEVELOPMENT_CONTAINER_ID = ""
    }
   
    stages {

        stage("Create Development Container") {
            steps {
                //Build container in development mode
                sh("docker build --target development -t ${IMAGE_NAME}:${IMAGE_TAG} .")

                //Start development container
                script {
                    DEVELOPMENT_CONTAINER_ID = sh(script: 'docker run -d -p ${APP_PORT}:${APP_PORT} ${IMAGE_NAME}:${IMAGE_TAG}', returnStdout: true)
                }
            }
        }

        stage("Validate Code") {
            steps {
                echo "${DEVELOPMENT_CONTAINER_ID}"
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
    post {
        always { 
            echo "${DEVELOPMENT_CONTAINER_ID}"
            //Remove development container
            sh("docker container stop ${DEVELOPMENT_CONTAINER_ID}")
            sh("docker container rm ${DEVELOPMENT_CONTAINER_ID}")
        }
    }
}