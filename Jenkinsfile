pipeline {
    agent {
        table 'rust'
    }

    stages {
        stage('Build') {
            steps {
                sh "cargo build"
            }
        }
        stage('Test') {
            steps {
                sh "cargo test"
            }
        }
        stage('Clippy') {
            steps {
                sh "cargo +nightly clippy --all"
            }
        }
        stage('Rustfmt') {
            steps {
                // The build will fail if rustfmt thinks any changes are
                // required.
                sh "cargo +nightly fmt --all -- --write-mode diff"
            }
        }
        stage('Doc') {
            steps {
                sh "cargo doc"
                // We run a python `SimpleHTTPServer` against
                // /var/lib/jenkins/jobs/<repo>/branches/master/javadoc to
                // display our docs
                step([$class: 'JavadocArchiver',
                      javadocDir: 'target/doc',
                      keepAll: false])
            }
        }
    }
    post {
            always {
                script {
                    step([$class: 'WarningsPublisher',
                        canResolveRelativePaths: true,
                        canComputeNew: true,
                        unHealthy: '10',
                        healthy: '0',
                        unstableTotalAll: '0',
                        thresholds: [[$class              : 'FailedThreshold',
                                        failureNewThreshold : '',
                                        failureThreshold    : '',
                                        unstableNewThreshold: '',
                                        unstableThreshold   : '0']],
                        consoleParsers: [[parserName: 'Rustc Warning Parser'],
                                        [parserName: 'Clippy warnings']]])
                }
            }
            step([$class: 'GitHubIssueNotifier',
                  issueAppend: true,
                  issueTitle: '$JOB_NAME $BUILD_DISPLAY_NAME failed'])
        }
        stage('Initialise') {
            steps {
                script {
                    properties([[$class: 'GithubProjectProperty',
                                projectUrlStr: 'https://github.com/victorinno/tower_web_dummy_service.git']])
                }
            }
        }
}
        