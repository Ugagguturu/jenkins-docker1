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
                    withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]){
                        sh "echo ${dockerhub} | docker login -u udaygagguturu --password-stdin"
                        sh "docker push udaygagguturu/flask:${env.BUILD_ID}"
                    }
                }
            }
        }
    }
}
