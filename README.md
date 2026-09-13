# NorthStar Secure DevSecOps Delivery Pipeline

A secure infrastructure-delivery pipeline for the NorthStar Azure security architecture. This project demonstrates how Terraform changes are validated, scanned, policy-checked, and reviewed before cloud deployment.

## Objective

Reduce delivery risk by applying automated controls to infrastructure-as-code before changes reach Azure.

## Delivery Controls

- Terraform formatting and validation
- Static infrastructure security scanning with Checkov
- Policy-as-code checks for required security controls
- Pull-request quality gates
- Protected deployment workflow design
- Evidence and remediation documentation

## Pipeline Flow

```mermaid
flowchart LR
    Change["Terraform change"] --> Validate["Format and validate"]
    Validate --> Scan["Security scan"]
    Scan --> Policy["Policy checks"]
    Policy --> Review["Pull-request review"]
    Review --> Plan["OIDC live plan"]
    Plan --> Evidence["Sanitized evidence"]
```

## Relationship to NorthStar

This pipeline governs Terraform delivery practices for the live NorthStar Secure Azure Landing Zone. It is a separate portfolio project focused on secure cloud delivery rather than the landing-zone architecture itself.

## Live Plan Control

- `NorthStar Live Terraform Plan` is a manually triggered GitHub Actions workflow that authenticates through OIDC and generates a Terraform plan against live Azure remote state.
- It uses a dedicated user-assigned managed identity, short-lived tokens, and least-privilege Reader and state-access roles.
- The workflow is plan-only: it contains no `terraform apply` step, and its identity cannot deploy infrastructure.
- It uploads a sanitized summary artifact while keeping the raw Terraform plan temporary to the GitHub runner.

### OIDC Trust Flow

```mermaid
flowchart TD
    Repo["Protected main"] --> Workflow["Manual live-plan workflow"]
    Workflow --> Token["Short-lived OIDC token"]
    Token --> Identity["Federated managed identity"]
    Identity --> Reader["Azure read scopes"]
    Identity --> State["Remote-state access"]
    Reader --> Plan["Terraform plan only"]
    State --> Plan
    Plan --> Evidence["Sanitized evidence artifact"]
```

[View the detailed trust flow and security boundaries](docs/diagrams/oidc-live-plan-trust-flow.md)

## Validated Implementation

- Pull request #1 validated all three required delivery gates before merge.
- The `main` branch requires Terraform quality, Checkov security, and policy-as-code checks.
- Branch protection enforces strict synchronization, linear history, conversation resolution, and administrator compliance.
- Force pushes and branch deletion are disabled.
- Pull request #2 added sanitized live-plan evidence through the protected workflow.
- Live-plan run `34764259985` used Azure OIDC, detected no infrastructure changes, and uploaded sanitized evidence.

## Evidence

- [Checkov remediation and exception register](docs/checkov-remediation-register.md)
- [OIDC live Terraform plan control](docs/oidc-live-plan-control.md)
- [Pull-request gate validation](docs/pull-request-gate-validation.md)
- [Custom least-privilege plan role](deployment/azure-rbac/northstar-terraform-plan-reader.json)

## Scope

NorthStar is portfolio and lab work, not employer production experience.
