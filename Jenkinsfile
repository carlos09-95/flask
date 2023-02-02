pipeline {
    environment{
        registry = 'carlosgarciagomez/flask_app'
        registryCredentials = 'docker'
        cluster_name = 'skillstorm'
    }
  agent {
    node {
      label 'docker'
    }

  }
  stages {
    stage('Git') {
      steps {
        git(url: 'https://github.com/carlos09-95/flasking.git', branch: 'main')
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
            

      