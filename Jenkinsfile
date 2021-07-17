pipeline{
    agent any
    tools {
        ant 'ant-setup'
    }
    stages{
        stage('Git clone'){
            steps{
               git credentialsId: 'git_creds', branch:'master', url: 'https://github.com/VivekDev123/Antbuild.git' 
            }
        }
        stage('Ant Build') {
            steps {
                sh 'ant -version'
                dir('Registration Page'){
                    sh 'ant clean init compile war'
                }
            }
        }
}
}
