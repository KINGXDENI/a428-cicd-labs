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
            input(id: 'manual-approval', message: 'Lanjutkan ke tahap Deploy?', parameters: [boolean(defaultValue: false, description: 'Klik "Proceed" untuk melanjutkan', name: 'Proceed')])
        }

        stage('Deploy') {
            docker.image(dockerImage).inside("-p 3000:3000") {
                sh './jenkins/scripts/deliver.sh' 
                input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 
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
