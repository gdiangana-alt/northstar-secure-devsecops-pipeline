# NorthStar Checkov Remediation and Exception Register

## Objective

Record Checkov findings, remediation decisions, compensating controls, and approved portfolio-lab exceptions. The security gate remains blocking; exceptions must be documented rather than hidden.

| Check | Decision | Rationale and control |
|---|---|---|
| CKV_AZURE_217 | Remediate | The gateway redirects HTTP to HTTPS, but the scan cannot infer the redirect. Confirm the listener design and document the control. |
| CKV_AZURE_218 | Remediate | Define an explicit Application Gateway TLS policy with modern protocols. |
| CKV_AZURE_213 | Remediate | Add an App Service health-check path. |
| CKV_AZURE_63 | Review | Confirm App Service diagnostics are routed to the SOC workspace or document the monitoring boundary. |
| CKV_AZURE_212 | Exception | B1 is a deliberate cost-controlled single-instance portfolio deployment; Application Gateway health monitoring provides backend visibility. |
| CKV_AZURE_225 | Exception | Zone redundancy is not available on the selected cost-controlled App Service plan. |
| CKV_AZURE_211 | Exception | Production-grade App Service plans exceed the portfolio cost boundary. |
| CKV_AZURE_222 | Exception | Public ingress is required for Application Gateway integration; direct access is denied except from the WAF subnet. |
| CKV_AZURE_17 | Exception | Client certificates are not required for this public web workload. |
| CKV_AZURE_13 | Exception | Application authentication is outside the Nginx demonstration workload; network access is restricted at the App Service boundary. |
| CKV_AZURE_78 | Exception | Terraform explicitly disables FTP and Web Deploy basic authentication; this is a Checkov provider-detection limitation. |
| CKV_AZURE_110 | Exception | Purge protection is disabled only for portfolio teardown and name-reuse constraints; soft delete remains enabled. |
| CKV_AZURE_189 | Exception | Key Vault public access supports controlled Azure service access; data-plane firewall default action is Deny. |
| CKV_AZURE_42 | Exception | Seven-day soft-delete retention supports the portfolio cost and teardown model. |
| CKV2_AZURE_32 | Exception | Private Endpoint is deferred because this portfolio design uses firewall controls and managed identities. |
| CKV2_AZURE_31 | Exception | Application Gateway requires a dedicated WAF subnet without an NSG. |

## Approval Standard

Every exception is limited to the NorthStar portfolio environment. A production deployment requires a separate risk review, architecture approval, and remediation plan.
