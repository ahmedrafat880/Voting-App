pipeline {
    agent any

    stages {
        stage('Verify Branch') {
            steps {
                echo "$GIT_BRANCH"
            }
        }
        stage('Docker Build') {
           steps {
              powershell (script: 'docker images -a')
              powershell (script: """
              cd azure-vote/
              docker images -a
              docker build -t jenkins-pipeline .
              docker images -a
              cd ..
              """)
           }
        }
      stage('Start test app') {
         steps {
            powershell (script: """
               ./scripts/test_container.ps1
            """)
         }
         post {
            success {
               echo "App started successfully :)"
            }
            failure {
               echo "App failed to start :("
            }
         }
      }
      stage('Run Tests') {
         steps {
            echo "It's done !!"
         }
      }
      stage('Stop test app') {
         steps {
            powershell (script: """
               docker-compose down
            """)
         }
      }
    }
}
