pipeline {
   
    agent any

    environment {
        IMAGE_NAME = "${JOB_NAME}"
        IMAGE_TAG = "${BUILD_ID}"
        APP_PORT = 5000
        DEVELOPMENT_CONTAINER_ID = ""
        UNIT_TESTS_FOLDER = "/tests/unit-tests"
        INTEGRATION_TESTS_FOLDER = "/tests/integrations-tests"
        ENDTOEND_TESTS_FOLDER = "/tests/endtoend_tests"
    }
   
    stages {
        stage("Clear Resources") {
            steps {
                //Remove all old containers from this build
                sh("docker container rm \$(docker container stop \$(docker ps -a | grep \"${IMAGE_NAME}\" | awk '{ print \$1 }'))")
            }
        }

        stage("Create Development Container") {
            steps {
                //Build container in development mode
                sh("docker build --target development -t ${IMAGE_NAME}:${IMAGE_TAG} .")

                //Start development container
                script {
                    DEVELOPMENT_CONTAINER_ID = sh(script: 'docker run -d -p ${APP_PORT}:${APP_PORT} ${IMAGE_NAME}:${IMAGE_TAG}', returnStdout: true).trim()
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
                //Run unit tests
                sh("docker container exec ${DEVELOPMENT_CONTAINER_ID} pytest -v ${UNIT_TESTS_FOLDER}/")
            }
        }

        stage("Run Integrations Tests") {
            steps {
                //Run integration tests
                sh("docker container exec ${DEVELOPMENT_CONTAINER_ID} pytest -v ${INTEGRATION_TESTS_FOLDER}/")
            }
        }

        stage("Run End-to-End Tests") {
            steps {
                //Run end to end tests
                sh("docker container exec ${DEVELOPMENT_CONTAINER_ID} pytest -v ${ENDTOEND_TESTS_FOLDER}/")
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