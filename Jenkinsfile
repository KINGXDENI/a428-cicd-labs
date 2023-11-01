node {
    def dockerImage = 'node:16-buster-slim'

    try {
        stage('Build') {
            docker.image(dockerImage).inside("-p 3000:3000") {
                sh 'npm install'
            }
        }

        stage('Test') {
            docker.image(dockerImage).inside("-p 3000:3000") {
                sh './jenkins/scripts/test.sh'
            }
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
    }
}
