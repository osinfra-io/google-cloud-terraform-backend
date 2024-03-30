# <img align="left" width="55" height="45" src="https://github.com/osinfra-io/google-cloud-terraform-backend/assets/1610100/728bce8c-4c5a-471d-bf0e-36835d7796ff"> Google Cloud Platform - Terraform Backend

**[GitHub Actions](https://github.com/osinfra-io/google-cloud-terraform-backend/actions):**

[![Dependabot](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-terraform-backend/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/9c3ee651-0722-41fc-8486-1a44637bd381/branch/af4debc9-dbda-4648-97ba-42a664cd3856)](https://dashboard.infracost.io/org/osinfra-io/repos/9c3ee651-0722-41fc-8486-1a44637bd381?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## 📄 Repository Description

This repository builds the Terraform backend for state management. Terraform uses persisted state data to keep track of the resources it manages. Most non-trivial Terraform configurations use a backend to store state remotely. This lets multiple people access the state data and work together on that collection of infrastructure resources. This repository aligns with our [Google Cloud landing zone platform](https://docs.osinfra.io/google-cloud-platform/landing-zone) design. A landing zone should be a prerequisite to deploying enterprise workloads in a cloud environment.

## 🏭 Platform Information

- Documentation: [docs.osinfra.io](https://docs.osinfra.io/product-guides/google-cloud-platform/landing-zone/google-cloud-terraform-backend)
- Service Interfaces: [github.com](https://github.com/osinfra-io/google-cloud-terraform-backend/issues/new/choose)

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [infracost](https://github.com/infracost/infracost)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [storage buckets](https://cloud.google.com/storage/docs/key-terms#buckets)
- [cloud identity groups](https://cloud.google.com/identity/docs/concepts/groups)
- [service accounts](https://cloud.google.com/iam/docs/service-accounts)
- [iam roles](https://cloud.google.com/iam/docs/understanding-roles)
- [terraform backend type gcs](https://developer.hashicorp.com/terraform/language/settings/backends/gcs)

### 📓 Terraform Documentation

- [global](global/infra/README.md)
