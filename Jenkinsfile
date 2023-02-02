pipeline {
    environment{
        registry = 'carlosgarciagomez/flask_app'
        registryCredentials = 'docker'
        cluster_name = 'skillstorm'
        namespace = 'cgarcia'
    }
  agent {
    node {
      label 'docker'
    }

  }
  stages {
    stage('Git') {
      steps {
        git(url: 'https://github.com/carlos09-95/flask.git', branch: 'main')
      }
    }


    stage('Build Stages') {
        steps{
            script {
                dockerImage = docker.build(registry)
            }
        }
    }

    stage('Deploy Stage'){
        steps{
            script{
                docker.withRegistry('', registryCredentials){
                    dockerImage.push()
                }
            }
        }
    }
    stage('Kubernetes'){
        steps{
            withCredentials([aws(accesssKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){
                sh "aws eks update-kubeconfig --region us-east-1 --name ${cluster_name}"
                script{
                    try{
                        sh "kubectl create namespace ${namespace}"
                    }catch(Exception e){
                        sh "kubectl apply -f deployment.yaml -n ${namespace}"
                        sh "kubectl -n ${namespace} rollout restart deployment flaskcontainer"
                    }
                }
            }
        }

    }
  }        
}
      