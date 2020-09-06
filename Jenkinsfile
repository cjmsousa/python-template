pipeline {
   
    agent any

    environment {
        IMAGE_NAME = "${JOB_NAME}"
        IMAGE_TAG = "${BUILD_ID}"
        APP_PORT = 5000
        DEVELOPMENT_CONTAINER_ID = ""
        DEVELOPMENT_IMAGE_ID = ""
        SOURCE_CODE_FOLDER = "/app"
        UNIT_TESTS_FOLDER = "/tests/unit_tests"
        INTEGRATION_TESTS_FOLDER = "/tests/integration_tests"
        ENDTOEND_TESTS_FOLDER = "/tests/endtoend_tests"
    }
   
    stages {
        stage("Clear Resources") {
            steps {
                //Remove all old containers from this build
                sh(script: "docker ps -a | awk '/${IMAGE_NAME}/ { print \$1 }' | xargs -r docker stop | xargs -r docker rm")
            }
        }

        stage("Create Development Container") {
            steps {
                //Build container in development mode
                sh("docker build --target development -t ${IMAGE_NAME}:${IMAGE_TAG} .")

                //Start development container
                script {

                    DEVELOPMENT_IMAGE_ID = sh(script: "docker build --target development -t ${IMAGE_NAME}:${IMAGE_TAG} .", returnStdout: true).trim()
                    DEVELOPMENT_CONTAINER_ID = sh(script: 'docker run -d -p ${APP_PORT}:${APP_PORT} ${IMAGE_NAME}:${IMAGE_TAG}', returnStdout: true).trim()
                }
                echo "Image created with id [${DEVELOPMENT_IMAGE_ID}]"
                echo "Development container created with id [${DEVELOPMENT_CONTAINER_ID}]"
            }
        }

        stage("Validate Code") {
            steps {
                //Run code validations
                sh("docker container exec ${DEVELOPMENT_CONTAINER_ID} pylint --exit-zero ${SOURCE_CODE_FOLDER}/")
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
                echo "${IMAGE_ID}"
            }
        }
    }
    post {
        always { 
            //Remove development container
            sh("docker container stop ${DEVELOPMENT_CONTAINER_ID}")
            sh("docker container rm ${DEVELOPMENT_CONTAINER_ID}")
        }
    }
}