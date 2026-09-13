# Pull-Request Gate Validation

## Objective

Verify that the NorthStar DevSecOps quality, static-security, and policy-as-code gates execute successfully against a pull request before its change is merged to `main`.

## Validation Change

This pull request adds documentation only. It does not modify Terraform configuration or Azure infrastructure.

## Required Checks

- Terraform Quality Gates — Terraform format and configuration validation
- Terraform Security Scan — Checkov static infrastructure security scan
- Terraform Policy as Code — Custom OPA policy enforcement

## Expected Result

All three controls must pass before this validation pull request is merged. This demonstrates that secure-delivery checks are active at the pull-request boundary, not only after changes reach `main`.

## Scope

This is controlled portfolio validation for the NorthStar Secure DevSecOps Delivery Pipeline.
