## Checklist
Creating a security checklist for a DevOps environment ensures that best practices are followed to protect systems and data. Here's a comprehensive security checklist for DevOps:

### Infrastructure Security

1. **Network Security:**
   - Implement VPCs and subnets for network segmentation.
   - Use security groups, NACLs, and firewalls to control inbound and outbound traffic.
   - Ensure all communication is encrypted (TLS/SSL).

2. **Access Control:**
   - Enforce the principle of least privilege.
   - Use role-based access control (RBAC).
   - Implement multi-factor authentication (MFA) for all accounts.
   - Regularly review and update access permissions.

3. **System Hardening:**
   - Regularly update and patch systems and software.
   - Disable unnecessary services and ports.
   - Use strong, unique passwords and keys.
   - Implement host-based firewalls and intrusion detection/prevention systems (IDS/IPS).

### Application Security

4. **Secure Development:**
   - Integrate security into the CI/CD pipeline (e.g., SAST, DAST).
   - Perform regular code reviews and security testing.
   - Use secure coding practices and libraries.
   - Manage secrets securely (e.g., environment variables, secret management tools).

5. **Dependency Management:**
   - Regularly update and patch dependencies.
   - Use tools to scan for vulnerabilities in dependencies.
   - Validate and verify third-party components before use.

### Data Security

6. **Data Protection:**
   - Encrypt data at rest and in transit.
   - Implement data backup and recovery plans.
   - Classify and handle data according to its sensitivity.
   - Ensure secure data disposal and sanitization.

### Monitoring and Logging

7. **Logging:**
   - Enable detailed logging for all systems and applications.
   - Use centralized logging solutions (e.g., ELK stack, Splunk).
   - Protect log integrity and confidentiality.

8. **Monitoring:**
   - Implement continuous monitoring for security events.
   - Use SIEM tools to aggregate and analyze security data.
   - Set up alerts for suspicious activities.

### Compliance and Governance

9. **Compliance:**
   - Ensure adherence to relevant compliance standards (e.g., GDPR, HIPAA, PCI-DSS).
   - Conduct regular security audits and assessments.
   - Maintain documentation for security policies and procedures.

10. **Incident Response:**
    - Develop and maintain an incident response plan.
    - Regularly train and drill the incident response team.
    - Implement mechanisms for incident detection, analysis, and mitigation.

### DevOps-Specific Practices

11. **Infrastructure as Code (IaC):**
    - Secure IaC templates and scripts.
    - Use version control for IaC.
    - Scan IaC for security misconfigurations and vulnerabilities.

12. **Container Security:**
    - Use minimal base images and regularly update them.
    - Scan container images for vulnerabilities.
    - Implement runtime security for containers (e.g., security policies, monitoring).

13. **CI/CD Pipeline Security:**
    - Secure CI/CD tools and infrastructure.
    - Implement pipeline security checks (e.g., security scans, code quality checks).
    - Manage secrets and credentials securely within the pipeline.

### User Awareness and Training

14. **Training:**
    - Regularly train employees on security best practices and awareness.
    - Promote a security-first culture within the organization.
### Sumary

| **Category**                  | **Checklist Item**                                                                                                                                             | **Details**                                                                                                           |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| Infrastructure Security       | Implement VPCs and subnets for network segmentation.                                                                                                           | Create isolated network environments to separate different parts of the infrastructure and limit potential breaches.  |
| Infrastructure Security       | Use security groups, NACLs, and firewalls to control inbound and outbound traffic.                                                                             | Define and enforce rules to control traffic flow at various levels within the network.                               |
| Infrastructure Security       | Ensure all communication is encrypted (TLS/SSL).                                                                                                               | Protect data in transit by using strong encryption protocols like TLS/SSL.                                           |
| Infrastructure Security       | Enforce the principle of least privilege.                                                                                                                       | Limit access permissions to the minimum necessary for users to perform their roles.                                  |
| Infrastructure Security       | Use role-based access control (RBAC).                                                                                                                           | Assign permissions based on user roles to streamline management and enhance security.                                |
| Infrastructure Security       | Implement multi-factor authentication (MFA) for all accounts.                                                                                                   | Add an extra layer of security by requiring multiple forms of verification for user access.                         |
| Application Security          | Regularly review and update access permissions.                                                                                                                 | Periodically audit and adjust access controls to ensure they remain appropriate.                                     |
| Application Security          | Regularly update and patch systems and software.                                                                                                                | Keep systems and applications secure by applying the latest patches and updates.                                     |
| Application Security          | Disable unnecessary services and ports.                                                                                                                         | Reduce the attack surface by turning off unused services and closing unused ports.                                   |
| Application Security          | Use strong, unique passwords and keys.                                                                                                                          | Enhance security by avoiding weak or reused passwords and using robust encryption keys.                              |
| Application Security          | Implement host-based firewalls and intrusion detection/prevention systems (IDS/IPS).                                                                            | Protect individual hosts with dedicated security controls to detect and prevent intrusions.                          |
| Application Security          | Integrate security into the CI/CD pipeline (e.g., SAST, DAST).                                                                                                  | Embed security checks within the development pipeline to catch vulnerabilities early.                                |
| Application Security          | Perform regular code reviews and security testing.                                                                                                              | Ensure code quality and security by conducting routine reviews and tests.                                             |
| Application Security          | Use secure coding practices and libraries.                                                                                                                      | Follow best practices for secure coding and leverage well-vetted libraries.                                           |
| Application Security          | Manage secrets securely (e.g., environment variables, secret management tools).                                                                                 | Store and handle sensitive information securely to prevent unauthorized access.                                      |
| Data Security                 | Regularly update and patch dependencies.                                                                                                                        | Maintain up-to-date and secure dependencies by applying patches promptly.                                             |
| Data Security                 | Use tools to scan for vulnerabilities in dependencies.                                                                                                          | Identify and mitigate vulnerabilities in third-party components.                                                     |
| Data Security                 | Validate and verify third-party components before use.                                                                                                          | Ensure the safety and reliability of external components before integrating them.                                    |
| Monitoring and Logging        | Encrypt data at rest and in transit.                                                                                                                            | Secure data wherever it is stored or transmitted.                                                                    |
| Monitoring and Logging        | Implement data backup and recovery plans.                                                                                                                       | Prepare for data loss by having reliable backup and recovery processes in place.                                     |
| Monitoring and Logging        | Classify and handle data according to its sensitivity.                                                                                                          | Apply appropriate controls based on the data's classification level.                                                  |
| Monitoring and Logging        | Ensure secure data disposal and sanitization.                                                                                                                   | Properly dispose of data to prevent unauthorized recovery.                                                           |
| Monitoring and Logging        | Enable detailed logging for all systems and applications.                                                                                                       | Capture comprehensive logs to support security monitoring and incident response.                                     |
| Monitoring and Logging        | Use centralized logging solutions (e.g., ELK stack, Splunk).                                                                                                    | Consolidate logs from multiple sources for easier management and analysis.                                           |
| Compliance and Governance     | Protect log integrity and confidentiality.                                                                                                                      | Safeguard log data against tampering and unauthorized access.                                                        |
| Compliance and Governance     | Implement continuous monitoring for security events.                                                                                                            | Continuously watch for and respond to security incidents.                                                            |
| Compliance and Governance     | Use SIEM tools to aggregate and analyze security data.                                                                                                          | Leverage Security Information and Event Management (SIEM) tools to detect threats.                                   |
| Compliance and Governance     | Set up alerts for suspicious activities.                                                                                                                        | Get timely notifications of potential security issues.                                                               |
| Compliance and Governance     | Ensure adherence to relevant compliance standards (e.g., GDPR, HIPAA, PCI-DSS).                                                                                 | Follow industry regulations and standards to stay compliant.                                                         |
| DevOps-Specific Practices     | Conduct regular security audits and assessments.                                                                                                                | Regularly evaluate security measures to identify and address gaps.                                                   |
| DevOps-Specific Practices     | Maintain documentation for security policies and procedures.                                                                                                    | Keep detailed and up-to-date records of security protocols and practices.                                            |
| DevOps-Specific Practices     | Develop and maintain an incident response plan.                                                                                                                 | Plan and prepare for responding to security incidents effectively.                                                   |
| DevOps-Specific Practices     | Regularly train and drill the incident response team.                                                                                                           | Ensure the response team is ready and capable through regular training.                                              |
| DevOps-Specific Practices     | Implement mechanisms for incident detection, analysis, and mitigation.                                                                                          | Establish processes and tools to identify, analyze, and address security incidents.                                  |
| DevOps-Specific Practices     | Secure IaC templates and scripts.                                                                                                                               | Protect Infrastructure as Code (IaC) assets from unauthorized changes.                                                |
| DevOps-Specific Practices     | Use version control for IaC.                                                                                                                                    | Track changes and manage versions of IaC templates using version control systems.                                     |
| DevOps-Specific Practices     | Scan IaC for security misconfigurations and vulnerabilities.                                                                                                    | Identify and fix security issues in IaC configurations.                                                              |
| User Awareness and Training   | Use minimal base images and regularly update them.                                                                                                              | Use lightweight and secure container base images and keep them updated.                                              |
| User Awareness and Training   | Scan container images for vulnerabilities.                                                                                                                      | Regularly check container images for known security issues.                                                          |
| User Awareness and Training   | Implement runtime security for containers (e.g., security policies, monitoring).                                                                                | Monitor and enforce security policies during container execution.                                                    |
| User Awareness and Training   | Secure CI/CD tools and infrastructure.                                                                                                                          | Protect the continuous integration and delivery environment from threats.                                            |
| User Awareness and Training   | Implement pipeline security checks (e.g., security scans, code quality checks).                                                                                 | Integrate security checks within the CI/CD pipeline to catch issues early.                                           |
| User Awareness and Training   | Manage secrets and credentials securely within the pipeline.                                                                                                    | Safeguard sensitive information in the CI/CD process.                                                                |
| User Awareness and Training   | Regularly train employees on security best practices and awareness.                                                                                             | Continuously educate staff on maintaining and improving security.                                                    |
| User Awareness and Training   | Promote a security-first culture within the organization.                                                                                                       | Foster a culture that prioritizes security at all levels of the organization.                                        |

## Phase N
Để thực hiện checklist bảo mật hiệu quả, bạn có thể chia các mục kiểm tra vào các giai đoạn (phase) khác nhau của dự án như sau:

1. **Planning Phase (Giai đoạn lập kế hoạch)**:
   - Implement VPCs and subnets for network segmentation.
   - Use security groups, NACLs, and firewalls to control inbound and outbound traffic.
   - Enforce the principle of least privilege.
   - Use role-based access control (RBAC).
   - Implement multi-factor authentication (MFA) for all accounts.
   - Integrate security into the CI/CD pipeline (e.g., SAST, DAST).
   - Develop and maintain an incident response plan.

2. **Design Phase (Giai đoạn thiết kế)**:
   - Ensure all communication is encrypted (TLS/SSL).
   - Implement host-based firewalls and intrusion detection/prevention systems (IDS/IPS).
   - Use secure coding practices and libraries.
   - Manage secrets securely (e.g., environment variables, secret management tools).
   - Classify and handle data according to its sensitivity.
   - Secure IaC templates and scripts.
   - Use version control for IaC.
   - Scan IaC for security misconfigurations and vulnerabilities.
   - Use minimal base images and regularly update them.

3. **Development Phase (Giai đoạn phát triển)**:
   - Perform regular code reviews and security testing.
   - Regularly update and patch dependencies.
   - Validate and verify third-party components before use.
   - Implement pipeline security checks (e.g., security scans, code quality checks).
   - Manage secrets and credentials securely within the pipeline.

4. **Testing Phase (Giai đoạn kiểm thử)**:
   - Perform regular code reviews and security testing.
   - Regularly update and patch systems and software.
   - Scan container images for vulnerabilities.
   - Implement runtime security for containers (e.g., security policies, monitoring).
   - Use tools to scan for vulnerabilities in dependencies.
   - Implement mechanisms for incident detection, analysis, and mitigation.
   - Regularly review and update access permissions.
   - Disable unnecessary services and ports.

5. **Deployment Phase (Giai đoạn triển khai)**:
   - Implement data backup and recovery plans.
   - Enable detailed logging for all systems and applications.
   - Use centralized logging solutions (e.g., ELK stack, Splunk).
   - Protect log integrity and confidentiality.
   - Implement continuous monitoring for security events.
   - Use SIEM tools to aggregate and analyze security data.
   - Set up alerts for suspicious activities.

6. **Maintenance Phase (Giai đoạn bảo trì)**:
   - Regularly update and patch systems and software.
   - Regularly train and drill the incident response team.
   - Conduct regular security audits and assessments.
   - Maintain documentation for security policies and procedures.
   - Regularly train employees on security best practices and awareness.
   - Promote a security-first culture within the organization.
   - Regularly review and update access permissions.
   - Perform regular code reviews and security testing.
   - Ensure secure data disposal and sanitization.

Dưới đây là bảng cập nhật với cột "Phase" để xác định giai đoạn thích hợp cho từng mục kiểm tra:

| **Category**                  | **Checklist Item**                                                                                                          | **Details**                                                                                                           | **Status** | **Assigned To** | **Phase**          |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|------------|-----------------|-------------------|
| Infrastructure Security       | Implement VPCs and subnets for network segmentation.                                                                        | Create isolated network environments to separate different parts of the infrastructure and limit potential breaches.  |            |                 | Planning          |
| Infrastructure Security       | Use security groups, NACLs, and firewalls to control inbound and outbound traffic.                                          | Define and enforce rules to control traffic flow at various levels within the network.                               |            |                 | Planning          |
| Infrastructure Security       | Ensure all communication is encrypted (TLS/SSL).                                                                            | Protect data in transit by using strong encryption protocols like TLS/SSL.                                           |            |                 | Design            |
| Infrastructure Security       | Enforce the principle of least privilege.                                                                                    | Limit access permissions to the minimum necessary for users to perform their roles.                                  |            |                 | Planning          |
| Infrastructure Security       | Use role-based access control (RBAC).                                                                                        | Assign permissions based on user roles to streamline management and enhance security.                                |            |                 | Planning          |
| Infrastructure Security       | Implement multi-factor authentication (MFA) for all accounts.                                                                | Add an extra layer of security by requiring multiple forms of verification for user access.                         |            |                 | Planning          |
| Application Security          | Regularly review and update access permissions.                                                                              | Periodically audit and adjust access controls to ensure they remain appropriate.                                     |            |                 | Development       |
| Application Security          | Regularly update and patch systems and software.                                                                             | Keep systems and applications secure by applying the latest patches and updates.                                     |            |                 | Maintenance       |
| Application Security          | Disable unnecessary services and ports.                                                                                      | Reduce the attack surface by turning off unused services and closing unused ports.                                   |            |                 | Development       |
| Application Security          | Use strong, unique passwords and keys.                                                                                       | Enhance security by avoiding weak or reused passwords and using robust encryption keys.                              |            |                 | Development       |
| Application Security          | Implement host-based firewalls and intrusion detection/prevention systems (IDS/IPS).                                         | Protect individual hosts with dedicated security controls to detect and prevent intrusions.                          |            |                 | Design            |
| Application Security          | Integrate security into the CI/CD pipeline (e.g., SAST, DAST).                                                               | Embed security checks within the development pipeline to catch vulnerabilities early.                                |            |                 | Planning          |
| Application Security          | Perform regular code reviews and security testing.                                                                           | Ensure code quality and security by conducting routine reviews and tests.                                             |            |                 | Testing           |
| Application Security          | Use secure coding practices and libraries.                                                                                   | Follow best practices for secure coding and leverage well-vetted libraries.                                           |            |                 | Design            |
| Application Security          | Manage secrets securely (e.g., environment variables, secret management tools).                                              | Store and handle sensitive information securely to prevent unauthorized access.                                      |            |                 | Design            |
| Data Security                 | Regularly update and patch dependencies.                                                                                     | Maintain up-to-date and secure dependencies by applying patches promptly.                                             |            |                 | Development       |
| Data Security                 | Use tools to scan for vulnerabilities in dependencies.                                                                       | Identify and mitigate vulnerabilities in third-party components.                                                     |            |                 | Testing           |
| Data Security                 | Validate and verify third-party components before use.                                                                       | Ensure the safety and reliability of external components before integrating them.                                    |            |                 | Development       |
| Monitoring and Logging        | Encrypt data at rest and in transit.                                                                                         | Secure data wherever it is stored or transmitted.                                                                    |            |                 | Design            |
| Monitoring and Logging        | Implement data backup and recovery plans.                                                                                    | Prepare for data loss by having reliable backup and recovery processes in place.                                     |            |                 | Deployment        |
| Monitoring and Logging        | Classify and handle data according to its sensitivity.                                                                       | Apply appropriate controls based on the data's classification level.                                                  |            |                 | Design            |
| Monitoring and Logging        | Ensure secure data disposal and sanitization.                                                                                | Properly dispose of data to prevent unauthorized recovery.                                                           |            |                 | Maintenance       |
| Monitoring and Logging        | Enable detailed logging for all systems and applications.                                                                    | Capture comprehensive logs to support security monitoring and incident response.                                     |            |                 | Deployment        |
| Monitoring and Logging        | Use centralized logging solutions (e.g., ELK stack, Splunk).                                                                 | Consolidate logs from multiple sources for easier management and analysis.                                           |            |                 | Deployment        |
| Compliance and Governance     | Protect log integrity and confidentiality.                                                                                   | Safeguard log data against tampering and unauthorized access.                                                        |            |                 | Deployment        |
| Compliance and Governance     | Implement continuous monitoring for security events.                                                                         | Continuously watch for and respond to security incidents.                                                            |            |                 | Deployment        |
| Compliance and Governance     | Use SIEM tools to aggregate and analyze security data.                                                                       | Leverage Security Information and Event Management (SIEM) tools to detect threats.                                   |            |                 | Deployment        |
| Compliance and Governance     | Set up alerts for suspicious activities.                                                                                     | Get timely notifications of potential security issues.                                                               |            |                 | Deployment        |
| Compliance and Governance     | Ensure adherence to relevant compliance standards (e.g., GDPR, HIPAA, PCI-DSS).                                              | Follow industry regulations and standards to stay compliant.                                                         |            |                 | Planning          |
| DevOps-Specific Practices     | Conduct regular security audits and assessments.                                                                             | Regularly evaluate security measures to identify and address gaps.                                                   |            |                 | Maintenance       |
| DevOps-Specific Practices     | Maintain documentation for security policies and procedures.                                                                 | Keep detailed and up-to-date records of security protocols and practices.                                            |            |                 | Maintenance       |
| DevOps-Specific Practices     | Develop and maintain an incident response plan.                                                                              | Plan and prepare for responding to security incidents effectively.                                                   |            |                 | Planning          |
| DevOps-Specific Practices     | Regularly train and drill the incident response team.                                                                        | Ensure the response team is ready and capable through regular training.                                              |            |                 | Maintenance       |
| DevOps-Specific Practices     | Implement mechanisms for incident detection, analysis, and mitigation.                                                       | Establish processes and tools to identify, analyze, and address security incidents.                                  |            |                 | Maintenance
## Create Code pipeline
```
resource "aws_codepipeline" "example" {
  name = "example-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = aws_codecommit_repository.example.name
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.example.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ApplicationName     = aws_codedeploy_app.example.name
        DeploymentGroupName = aws_codedeploy_deployment_group.example.name
      }
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

resource "aws_codecommit_repository" "example" {
  repository_name = "example-repo"
  description     = "An example CodeCommit repository"
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "example-codepipeline-bucket"
}

resource "aws_codebuild_project" "example" {
  name          = "example-build"
  description   = "Example build project"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"

```
## Pipeline parallel
```
resource "aws_codepipeline" "example" {
  name = "example-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = aws_codecommit_repository.example.name
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build1"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output1"]
      run_order        = 1

      configuration = {
        ProjectName = aws_codebuild_project.example1.name
      }
    }

    action {
      name             = "Build2"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output2"]
      run_order        = 1

      configuration = {
        ProjectName = aws_codebuild_project.example2.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["build_output1", "build_output2"]

      configuration = {
        ApplicationName     = aws_codedeploy_app.example.name
        DeploymentGroupName = aws_codedeploy_deployment_group.example.name
      }
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

resource "aws_codecommit_repository" "example" {
  repository_name = "example-repo"
  description     = "An example CodeCommit repository"
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "example-codepipeline-bucket"
}

resource "aws_codebuild_project" "example1" {
  name          = "example-build1"
  description   = "Example build project 1"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  source {
    type            = "CODECOMMIT"
    location        = aws_codecommit_repository.example.repository_url
  }
}

resource "aws_codebuild_project" "example2" {
  name          = "example-build2"
  description   = "Example build project 2"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  source {
    type            = "CODECOMMIT"
    location        = aws_codecommit_repository.example.repository_url
  }
}

resource "aws_codedeploy_app" "example" {
  name = "example-codedeploy-app"
}

resource "aws_codedeploy_deployment_group" "example" {
  app_name              = aws_codedeploy_app.example.name
  deployment_group_name = "example-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime"
  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = "example-instance"
      type  = "KEY_AND_VALUE"
    }
  }

  load_balancer_info {
    elb_info {
      name = "example-elb"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy_attachment" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

```
## 