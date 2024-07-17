## SSH EC2
To create a stage in AWS CodePipeline that executes an SSH command to an EC2 instance, you can use AWS CodeBuild as an intermediary. Here are the steps:

1. **Create an IAM Role for CodeBuild:**

   - Go to the **IAM** console.
   - Create a new role.
   - Choose **CodeBuild** as the trusted entity.
   - Attach the policies `SecretsManagerReadWrite`, `AmazonEC2ReadOnlyAccess`, and `AmazonSSMFullAccess`.
   - Give the role a name, for example, `CodeBuildEC2AccessRole`.

2. **Create a CodeBuild Project:**

   - Go to the **CodeBuild** console.
   - Create a new build project.
   - Configure the project source to match your pipeline source.
   - In the **Environment** section, choose a managed image and select the operating system and runtime you need.
   - Under **Service role**, select the role `CodeBuildEC2AccessRole`.
   - In the **Buildspec** section, choose **Insert build commands** and add the buildspec below.

   Example `buildspec.yml`:

   ```yaml
   version: 0.2

   phases:
     install:
       runtime-versions:
         python: 3.8
       commands:
         - echo Installing AWS CLI
         - pip install awscli
     pre_build:
       commands:
         - echo Retrieving private key from Secrets Manager
         - export SECRET_NAME=my-ec2-private-key
         - export REGION=us-west-2 # Change this to your region
         - export PRIVATE_KEY=$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION --query SecretString --output text)
         - echo "$PRIVATE_KEY" > private_key.pem
         - chmod 400 private_key.pem
     build:
       commands:
         - echo Executing SSH command on EC2 instance
         - export SSH_USER=ec2-user # Change this to your instance's user
         - export EC2_IP=your.ec2.ip.address # Change this to your instance's IP
         - ssh -o StrictHostKeyChecking=no -i private_key.pem $SSH_USER@$EC2_IP 'bash -s' < deploy_script.sh
     post_build:
       commands:
         - echo Cleaning up
         - rm -f private_key.pem

   artifacts:
     files:
       - '**/*'
   ```

   Create a file named `deploy_script.sh` in your repository. This script will contain the commands to deploy your application.

3. **Create or Update the CodePipeline:**

   - Go to the **CodePipeline** console.
   - Create a new pipeline or edit an existing one.
   - Add a new stage for deployment.
   - In the deployment stage, add an action group.
   - Choose **AWS CodeBuild** as the provider.
   - Select the CodeBuild project you created earlier.

4. **Configure Pipeline Triggers:**

   Ensure your pipeline is configured to trigger on the source stage updates (e.g., when there are new commits in your GitHub repository).

5. **Run the Pipeline:**

   - Trigger the pipeline manually or by pushing a change to the source repository.
   - The pipeline will now include a stage that executes an SSH command on the EC2 instance using the private key stored in Secrets Manager.

With this setup, your CodePipeline will securely retrieve the private key, use it to SSH into the EC2 instance, and execute the specified deployment script.