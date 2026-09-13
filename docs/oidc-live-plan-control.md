# NorthStar OIDC Live Terraform Plan Control

## Objective

Provide a GitHub Actions workflow that evaluates the live NorthStar Azure environment without storing Azure client secrets or receiving permission to deploy infrastructure.

## Authentication Design

GitHub Actions authenticates to Azure through OpenID Connect (OIDC) and the user-assigned managed identity `northstar-lz-devsecops-plan`.

The federated identity credential is restricted to the `main` branch of `gdiangana-alt/northstar-secure-devsecops-pipeline`. The workflow receives a short-lived token from GitHub; no Azure client secret is stored in GitHub.

## Least-Privilege Boundary

| Permission | Scope | Purpose |
|---|---|---|
| Reader | `NorthStar-Landing-Zone-RG` | Read landing-zone resources during Terraform refresh |
| Reader | `NorthStar-Azure-RG` | Read SOC monitoring resources during Terraform refresh |
| Storage Blob Data Contributor | `northstartfstate244d` only | Read Terraform state and acquire the state-lock lease |
| NorthStar Terraform Plan Reader | App Service and subscription diagnostic setting only | Allow the two provider-required read actions omitted from the generic Reader role |

The custom role permits only:

- `Microsoft.Web/sites/config/list/action`
- `Microsoft.Insights/diagnosticSettings/read`

The role definition is stored in `deployment/azure-rbac/northstar-terraform-plan-reader.json`.

The identity has no Contributor, Owner, User Access Administrator, Key Vault data-plane, or deployment permission.

## Workflow Control

`NorthStar Live Terraform Plan` is manually triggered through GitHub Actions. It:

1. checks out the Terraform source;
2. authenticates through Azure OIDC;
3. initializes the Azure remote backend;
4. generates a live Terraform plan; and
5. never runs `terraform apply`.

A Terraform plan can acquire a temporary state-lock lease. This protects remote-state consistency and does not modify Azure infrastructure.

## Validation Evidence

GitHub Actions run `34761064709` completed successfully on September 13, 2026.

The plan refreshed the live NorthStar environment and returned:

> No changes. Your infrastructure matches the configuration.

## Scope

This control is intentionally plan-only for the NorthStar portfolio environment. A future deployment workflow would require a separate managed identity, narrowly scoped Contributor roles, protected GitHub Environment approvals, and an explicit change-control design.
