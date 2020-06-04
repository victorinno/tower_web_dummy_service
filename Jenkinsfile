pipeline {
    agent {
        dockerfile true
    }
    stages {
        stage('Build') {
            steps {
                container('dommy-base') {
                    sh "cargo build --release"
                }
            }
        }
        stage('Test') {
            steps {
                container('dommy-base') {
                    sh "cargo test"
                }
            }
        }
        stage('Deliver') { 
            steps {
                container('dommy-base') {
                    sh './target/release/tower_web_dummy_service' 
                }
            }
        }
    }
}
        
