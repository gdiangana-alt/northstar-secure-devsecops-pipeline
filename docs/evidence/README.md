# Phase 2 Visual Evidence

Only real screenshots from the completed NorthStar controls belong here. Do not use reconstructed or illustrative portal images.

| Filename | Required evidence | Source |
|---|---|---|
| `01-pr-security-gates.png` | Three successful required checks on a pull request | GitHub PR checks |
| `02-main-branch-protection.png` | Required checks, strict mode, admin enforcement, and blocked force pushes/deletion | GitHub branch settings |
| `03-oidc-live-plan-success.png` | Successful OIDC authentication, remote-state initialization, and live Terraform plan | GitHub Actions run `34764259985` |
| `04-sanitized-plan-artifact.png` | Artifact name and sanitized no-change result | Run artifact plus downloaded summary |

## Sanitization Rules

- Hide tokens, credentials, tenant IDs, subscription IDs, client IDs, principal IDs, object IDs, email addresses, public IP addresses, and sensitive DNS names.
- Keep repository name, workflow names, job names, conclusions, timestamps, commit hashes, and public run URLs visible.
- Crop browser tabs, bookmarks, notifications, and unrelated account information.
- Do not label reconstructed images as screenshots.
