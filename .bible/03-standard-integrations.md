# Standard Integrations

This document defines the standard integrations used across all projects.

## Authentication: Clerk

**Repository:** https://clerk.com/docs

### Standard Configuration

```bash
# Environment Variables
CLERK_PUBLISHABLE_KEY=pk_test_xxx
CLERK_SECRET_KEY=sk_test_xxx
```

### Backend Middleware (FastAPI)

```python
from clerk_backend_api import Clerk

clerk = Clerk(bearer_auth=os.getenv("CLERK_SECRET_KEY"))

async def verify_clerk_token(token: str) -> dict:
    """Verify Clerk JWT token."""
    # Implementation per Clerk docs
    pass
```

### Frontend (React/Next.js)

```typescript
import { ClerkProvider } from '@clerk/nextjs';

export default function RootLayout({ children }) {
  return (
    <ClerkProvider>
      {children}
    </ClerkProvider>
  );
}
```

## Issue Tracking: Linear

**Module Repository:** https://github.com/dudleypeacockqa/linear-integration-module

### Standard Configuration

```bash
# Environment Variables
LINEAR_API_KEY=lin_api_xxx
LINEAR_DEFAULT_TEAM_ID=team-uuid
LINEAR_CLIENT_ID=xxx
LINEAR_CLIENT_SECRET=xxx
LINEAR_REDIRECT_URI=https://backend.com/api/auth/linear/callback
LINEAR_WEBHOOK_SECRET=lin_wh_xxx
```

### Features
- OAuth 2.0 with PKCE
- Automatic fault reporting
- Webhook event processing
- Error deduplication

## Database: Supabase/PostgreSQL

**Standard Configuration:**

```bash
# Environment Variables
DATABASE_URL=postgresql://user:pass@host:5432/db
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=xxx
SUPABASE_SERVICE_ROLE_KEY=xxx
```

### Row Level Security (RLS)

All tables should have RLS policies for multi-tenant isolation:

```sql
CREATE POLICY "tenant_isolation" ON table_name
  USING (organization_id = current_setting('app.current_org_id')::uuid);
```

## Deployment: Render

**Standard Configuration:**

```yaml
# render.yaml
services:
  - type: web
    name: backend
    runtime: python
    buildCommand: pip install -r requirements.txt
    startCommand: uvicorn backend.app:app --host 0.0.0.0 --port $PORT
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: db
          property: connectionString
```

### Health Check Endpoints

Every service must expose:
- `GET /api/health` - Basic health check
- `GET /api/health/db` - Database connectivity
- `GET /api/health/ready` - Readiness probe

## AI/LLM: Claude API

**Standard Configuration:**

```bash
ANTHROPIC_API_KEY=sk-ant-xxx
```

### Usage Pattern

```python
import anthropic

client = anthropic.Anthropic()

response = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=1024,
    messages=[{"role": "user", "content": prompt}]
)
```

## MCP Servers

Model Context Protocol servers for enhanced AI capabilities:

- **Linear MCP** - Linear issue management
- **GitHub MCP** - Repository operations
- **Playwright MCP** - Browser automation
- **Context7 MCP** - Documentation lookup

### Configuration Location

```
~/.claude/claude_desktop_config.json  # Claude Desktop
~/.cursor/mcp.json                     # Cursor IDE
```

## CI/CD: GitHub Actions

**Standard Workflow:**

```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Run tests
        run: pytest --cov=src
      - name: Upload coverage
        uses: codecov/codecov-action@v4
```
