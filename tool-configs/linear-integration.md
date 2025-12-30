# Linear Integration Module

This document references the standardized Linear integration patterns.

## Source Repository

**GitHub:** https://github.com/dudleypeacockqa/linear-integration-module

## Components

### 1. OAuth Flow (PKCE)
- Python: `python/linear_oauth.py`
- TypeScript: `typescript/linear-oauth.ts`

### 2. Webhook Handler
- Python: `python/linear_webhooks.py`
- TypeScript: `typescript/linear-webhooks.ts`

### 3. Fault Manager (Error Reporting)
- Python: `python/linear_faults.py`
- TypeScript: `typescript/linear-faults.ts`

## Required Environment Variables

```bash
# Linear API Configuration
LINEAR_API_KEY=lin_api_xxxxx
LINEAR_DEFAULT_TEAM_ID=your-team-uuid
LINEAR_APP_NAME=YourAppName

# Linear OAuth Configuration
LINEAR_CLIENT_ID=your-client-id
LINEAR_CLIENT_SECRET=your-client-secret
LINEAR_REDIRECT_URI=https://your-backend.com/api/auth/linear/callback

# Linear Webhook Configuration
LINEAR_WEBHOOK_SECRET=lin_wh_xxxxx
```

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/auth/linear` | GET | Initiate OAuth flow |
| `/api/auth/linear/callback` | GET | OAuth callback (PKCE) |
| `/api/auth/linear/status` | GET | Check OAuth configuration |
| `/api/webhooks/linear` | POST | Receive Linear webhook events |
| `/api/webhooks/linear/health` | GET | Webhook health check |

## Features

### Automatic Error Reporting
- Errors are automatically reported to Linear as issues
- Deduplication using MD5 hash (1-hour window)
- Priority mapping: critical=1, error=2, warning=3

### Webhook Events Handled
- Issue: create, update, remove
- Comment: create, update, remove
- Project: create, update, remove
- Cycle: create, update, remove

## Installation

```bash
# Clone the module
git clone https://github.com/dudleypeacockqa/linear-integration-module.git

# Copy required files to your project
cp linear-integration-module/python/*.py your-project/backend/services/
```

## FastAPI Integration Example

```python
from fastapi import FastAPI
from backend.routes import linear_oauth, linear_webhooks

app = FastAPI()

# Mount Linear routes
app.include_router(linear_oauth.router, prefix="/api")
app.include_router(linear_webhooks.router, prefix="/api")
```

## Express Integration Example

```typescript
import express from 'express';
import linearOAuthRouter from './routes/linear-oauth';
import linearWebhooksRouter from './routes/linear-webhooks';

const app = express();

// Mount Linear routes
app.use('/api/auth/linear', linearOAuthRouter);
app.use('/api/webhooks/linear', linearWebhooksRouter);
```
