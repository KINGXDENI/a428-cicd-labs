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

        stage('Manual Approval') {
            input message: 'Lanjutkan ke tahap Deploy? (Klik "Proceed" untuk melanjutkan eksekusi pipeline ke tahap Deploy)' 
        }

        stage('Deploy') {
            docker.image(dockerImage).inside("-p 3000:3000") {
                sh './jenkins/scripts/deliver.sh' 
                sh 'sleep 60' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
    }
}
