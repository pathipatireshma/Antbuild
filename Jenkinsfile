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
                    sh 'ant clean init compile'
                }
            }
        }
        stage('Ant package') {
            steps {                
                dir('Registration Page'){
                    sh 'ant war'
                }
            }
        }
        stage ('Archive the package')
        {
            steps{
                dir('Registration Page/dist'){
                   archiveArtifacts artifacts: 'AntExample.war', followSymlinks: false
                }
            }
        }
        stage ('Login to deployment server')
        {
            steps{
                sshagent(['centos-slave']) {
                    sh 'scp script.sh centos@3.236.110.239:~'
                    sh 'ssh -o StrictHostKeyChecking=no centos@3.236.110.239'
                    sh 'chmod +x script.sh' 
                    script {
                    env.MYVAR = sh( script: "./script.sh",
                             returnStdout: true).trim()
                    echo "MYVAR: ${env.MYVAR}"
                    }
               }
            }
        }
        stage ("Deploy package to tomcat"){
            steps{
              script {
                  if (env.MYVAR == 'tomcat needs to be installed')
                  {
                      sh 'ansible -i hosts.ini web --list-hosts'
                      sh 'ansible-playbook -i hosts.ini role.yml'
                  }
                  sshagent(['centos-slave']) {
                      sh 'scp dist/AntExample.war centos@3.236.110.239:/opt/tomcat/webapps'
                      sh 'ssh -o StrictHostKeyChecking=no centos@3.236.110.239'
                      sh 'systemctl tomcat restart'
				   }              
              }
            }
        }
    }
}
