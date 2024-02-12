pipeline{
    agent any
        environment{
            PROJECT_ID='logical-factor-315804'
            LOCATION='us-west1'
            CLUSTER_NAME = 'my-gke-cluster'
            CREDENTIALS_ID = 'gke'
        }
    stages{
        stage('Terraform Init') {
            steps {
                script {
                    sh "terraform init"
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh "terraform refresh "
                    sh "terraform destroy -auto-approve"
                    sh "terraform apply -auto-approve"
                }
            }
        }
        stage('Building Docker image'){
            steps{
                sh "docker build -t udaygagguturu/flask:${env.BUILD_ID} ."
            }
        }
        stage('Pushing docker image into the docker hub'){
            steps{
                script{
                    echo "Pushing docker image"
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]){
                        sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                        sh "docker push udaygagguturu/flask:${env.BUILD_ID}"
                    }
                }
            }
        }
        stage('Deploying to K8s') {
                    steps{
                                sh "sed -i 's/tagversion/${env.BUILD_ID}/g' deployment.yaml" 
                                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
                            echo "Deployment successfully finished ..."
                    }
             }
    }
}
