# OIDC Live-Plan Trust Flow

```mermaid
flowchart TD
    Repo["Protected main branch"] --> Workflow["Manual GitHub Actions workflow"]
    Workflow --> Token["Short-lived OIDC token"]
    Token --> Federation["Entra federated credential"]
    Federation --> Identity["northstar-lz-devsecops-plan"]
    Identity --> Reader["Reader on NorthStar resource groups"]
    Identity --> State["State-blob access and lock lease"]
    Identity --> Custom["Two custom provider read actions"]
    Reader --> Plan["Terraform plan only"]
    State --> Plan
    Custom --> Plan
    Plan --> Summary["Sanitized summary artifact"]
```

## Security Boundaries

- No Azure client secret is stored in GitHub.
- Federation is restricted to the repository main branch.
- The identity cannot run infrastructure deployments.
- Raw Terraform plan output remains temporary to the runner.
- Only the sanitized plan result is retained as evidence.
