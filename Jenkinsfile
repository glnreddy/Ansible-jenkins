def pullRequest = false

node {
 
    // Mark the code checkout 'Checkout'....
    stage 'Checkout'
 
    // // Get some code from a GitHub repository
    git url: 'https://github.com/glnreddy/Ansible-jenkins.git'

    // we don't release or ask for user input on pull requests
    pullRequest = env.BRANCH_NAME != 'master'
    stage('install'){
      downloadTerraform()
      env.PATH = "${env.PATH}:${env.WORKSPACE}"
    }

    stage('plan') {
      // Assumes you have setup a credentials
      sh "terraform --version"
      sh "set +e; terraform plan -out=tfplan -input=false"
      }
    

    stage('show'){
      sh "terraform show tfplan"
      // Save plan output for future so they can be compared
      archiveArtifacts 'tfplan'
      // store the plan file to be used later on potentially different node
      stash includes: 'tfplan', name: 'tfplan'
    }  
// We don't run the rest of the code when we aren't running in master branch
// So pull requests only run a plan
if(pullRequest){
  return
}

// restore saved plan file
unstash name: 'tfplan'
stage('apply'){
      sh "set +e; terraform apply -input=false tfplan"
      }     
}

// -----------
// Functions
// -----------


def downloadTerraform(){
  if (!fileExists('terraform')) {
    sh "curl -o  terraform_0.8.7_linux_amd64.zip https://releases.hashicorp.com/terraform/0.8.7/terraform_0.8.7_linux_amd64.zip && unzip -o terraform_0.8.7_linux_amd64.zip && chmod 777 terraform"
  } else {
    println("terraform already downloaded")
  }
}
