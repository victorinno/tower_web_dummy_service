pipeline {
    agent {
        docker {
            image 'rustlang/rust:nightly'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh "cargo build --release"
            }
        }
        stage('Test') {
            steps {
                sh "cargo test"
            }
        }
        stage('Deliver') { 
            steps {
                sh 'nohup ./target/release/tower_web_dummy_service &'  
            }
        }
    }
}
        
