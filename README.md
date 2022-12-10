# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/197364816-35422195-84cf-4c2e-8c02-73570faf445d.png"> Google Cloud Platform - Terraform Backend

**[GitHub Actions](https://github.com/osinfra-io/google-cloud-terraform-backend/actions):**

[![Infracost](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/infracost.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/infracost.yml) [![Dependabot](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/dependabot.yml)

**[Bridgecrew](https://www.bridgecrew.cloud/projects?types=Passed&repository=osinfra-io%2Fgoogle-cloud-terraform-backend&branch=main):**

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/osinfra-io/google-cloud-terraform-backend/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=osinfra-io%2Fgoogle-cloud-terraform-backend&benchmark=INFRASTRUCTURE+SECURITY) [![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/osinfra-io/google-cloud-terraform-backend/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=osinfra-io%2Fgoogle-cloud-terraform-backend&benchmark=CIS+GCP+V1.1)

This repository builds the Terraform backend for state management. Terraform uses persisted state data to keep track of the resources it manages. Most non-trivial Terraform configurations use a backend to store state remotely. This lets multiple people access the state data and work together on that collection of infrastructure resources. It aligns with our [landing zone](https://cloud.google.com/architecture/landing-zones) design. A landing zone should be a prerequisite to deploying enterprise workloads in a cloud environment. It's intended for cloud system administrators, architects, and technical practitioners responsible for designing the resource hierarchy. As every organization is different, there is no single best approach for resource hierarchy; this is considered a sensible default that scales well and can be customized to meet the needs and requirements of your organization.

It's designed to be used with:

- [google-cloud-hierarchy](https://github.com/osinfra-io/google-cloud-hierarchy): Metaphorically speaking, the [Google Cloud resource hierarchy](https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy) resembles the file system found in traditional operating systems as a way of organizing and managing entities hierarchically.
- [google-cloud-logging](https://github.com/osinfra-io/google-cloud-logging): Google Cloud Platform (GCP) services write audit logs that record administrative activities and accesses within your Google Cloud Platform (GCP) resources. [Audit logs](https://cloud.google.com/logging/docs/audit) help you answer "who did what, where, and when?" within your Google Cloud resources with the same level of transparency as in on-premises environments. Enabling audit logs helps your security, auditing, and compliance entities monitor Google Cloud data and systems for possible vulnerabilities or external data misuse.
- [google-cloud-observability](https://github.com/osinfra-io/google-cloud-observability): Good monitoring is a staple of high-performing teams. [DevOps](https://cloud.google.com/devops) Research and Assessment (DORA) research shows that a comprehensive monitoring and observability solution, along with a number of other technical practices, positively contributes to [continuous delivery](https://cloud.google.com/architecture/devops/devops-tech-continuous-delivery).
- [google-cloud-services](https://github.com/osinfra-io/google-cloud-services): Google Cloud Platform (GCP) provides a wide range of services that can be used to build and run applications.
- [google-cloud-workload-identity](https://github.com/osinfra-io/google-cloud-workload-identity): With [workload identity federation](https://cloud.google.com/iam/docs/workload-identity-federation), you can use Identity and Access Management (IAM) to grant external identities IAM roles, including the ability to impersonate service accounts. This lets you access resources directly, using a [short-lived access token](https://cloud.google.com/iam/docs/create-short-lived-credentials-direct), and eliminates the maintenance and security burden associated with service account keys.

## Terraform Documentation

[**Global Infrastructure**](global/infra/README.md)
