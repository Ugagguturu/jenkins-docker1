pipeline{
    agent any
        environment{
            PROJECT_ID='ancient-booster-410310'
            LOCATION='us-central1-a'
        }
    stages{
        stage('Building Docker image'){
            steps{
                sh "docker build -t udaygagguturu/flask:${env.BUILD_ID} ."
            }
        }
        stage('Pushing docker image into the docker hub'){
            steps{
                script{
                    echo "Pushing docker image"
                    withCredentials([string(credentialsId: 'dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]){
                        sh "docker login -u ${env.DOCKERHUB_USERNAME} -p ${env.DOCKERHUB_PASSWORD}"
                        sh "docker push udaygagguturu/flask:${env.BUILD_ID}"
                    }
                }
            }
        }
    }
}
