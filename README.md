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
    Review --> Deploy["Approved deployment"]
```

## Relationship to NorthStar

This pipeline governs Terraform delivery practices for the live NorthStar Secure Azure Landing Zone. It is a separate portfolio project focused on secure cloud delivery rather than the landing-zone architecture itself.

## Scope

NorthStar is portfolio and lab work, not employer production experience.
