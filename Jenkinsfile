pipeline {
    agent {
         label 'workstation'
    }
      parameters {
            choice(name: 'CHOICE', choices: ['create', 'delete'], description: 'Pick something')
      }
   stages {
           stage('Terraform init') {
               steps {
                  sh '''
                  echo "Running Terraform INIT"
                  cd roboshop-chiru
                  terraform init
                  '''
               }
      }
   stage('Terraform Apply') {
           when {
               environment name: 'CHOICE', value: 'create'
           }
              steps {
                 sh '''
                 cd roboshop-chiru
                 terraform apply -auto-approve
                 '''
              }
      }
       stage('Terraform Destroy') {
           when {
                environment name: 'CHOICE', value: 'destroy'
           }
           input {
               message "Should we continue?"
               ok "Yes, we should."
           }
               steps {
                  sh '''
                  cd roboshop-chiru
                  terraform destroy
                  '''
               }
       }
    }
 }