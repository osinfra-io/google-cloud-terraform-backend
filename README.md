# <img align="left" width="55" height="45" src="https://github.com/osinfra-io/google-cloud-opentofu-backend/assets/1610100/728bce8c-4c5a-471d-bf0e-36835d7796ff"> Google Cloud Platform - OpenTofu Backend

**[GitHub Actions](https://github.com/osinfra-io/google-cloud-opentofu-backend/actions):**

[![Dependabot](https://github.com/osinfra-io/google-cloud-opentofu-backend/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-opentofu-backend/actions/workflows/dependabot.yml)

## 📄 Repository Description

This repository builds the OpenTofu backend for state management. OpenTofu uses persisted state data to keep track of the resources it manages. Most non-trivial OpenTofu configurations use a backend to store state remotely. This lets multiple people access the state data and work together on that collection of infrastructure resources. This repository aligns with our [Google Cloud landing zone platform](https://docs.osinfra.io/google-cloud-platform/landing-zone) design. A landing zone should be a prerequisite to deploying enterprise workloads in a cloud environment.

## 🏭 Platform Information

- Documentation: [docs.osinfra.io](https://docs.osinfra.io/product-guides/google-cloud-platform/landing-zone/google-cloud-opentofu-backend)
- Service Interfaces: [github.com](https://github.com/osinfra-io/google-cloud-opentofu-backend/issues/new/choose)

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with OpenTofu documentation.

See the documentation for setting up a development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [pre-commit](https://github.com/pre-commit/pre-commit)
- [osinfra-pre-commit-hooks](https://github.com/osinfra-io/pre-commit-hooks)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [storage buckets](https://cloud.google.com/storage/docs/key-terms#buckets)
- [cloud identity groups](https://cloud.google.com/identity/docs/concepts/groups)
- [service accounts](https://cloud.google.com/iam/docs/service-accounts)
- [iam roles](https://cloud.google.com/iam/docs/understanding-roles)
- [opentofu backend type gcs](https://opentofu.org/docs/language/settings/backends/gcs)

### 📓 OpenTofu Documentation
