# FloCommand Lessons Learned

This document captures the proven patterns and lessons from FloCommand development
that should be applied to all future projects.

## Architecture Lessons

### 1. Backend Architecture

**Lesson:** Use FastAPI for production Python backends, not Express/Node.js when Python is the primary language.

**Why:** FloCommand initially had Express routes that weren't deployed because the production backend was FastAPI. This caused confusion when Linear integration routes returned HTML instead of JSON.

**Standard:** Choose one backend framework and commit to it. Document clearly which service is deployed where.

### 2. Route Prefix Consistency

**Lesson:** Always mount API routes under `/api` prefix.

**Why:** Frontend catch-all routes can intercept non-prefixed paths and return HTML instead of JSON.

**Standard:**
```python
# FastAPI
app.include_router(router, prefix="/api")

# Express
app.use('/api', router)
```

### 3. Environment Variable Documentation

**Lesson:** Document all required environment variables with examples.

**Why:** Missing or misconfigured environment variables cause silent failures that are hard to debug.

**Standard:** Create `.env.example` with all required variables and comments.

## TDD Lessons

### 4. Test Before Claim Success

**Lesson:** Never claim a feature is complete without running tests.

**Why:** "It should work" is not the same as "tests pass."

**Standard:**
- Always show test commands
- Always report actual test output or explicitly state tests weren't run
- Use the phrase "expected, not confirmed" when tests cannot be run

### 5. Integration Test Boundaries

**Lesson:** Test at the API boundary, not just unit tests.

**Why:** Unit tests passing doesn't guarantee the API works correctly.

**Standard:** Include integration tests that hit actual endpoints:
```python
def test_linear_webhook_health():
    response = client.get("/api/webhooks/linear/health")
    assert response.status_code == 200
    assert response.json()["status"] == "ok"
```

## BMAD Lessons

### 6. Intent Traceability

**Lesson:** Every feature change should reference the intent it implements.

**Why:** Without traceability, it's impossible to verify PRD coverage.

**Standard:** Use format: `Intent XX - Feature Name` in commits and documentation.

### 7. Single Source of Truth

**Lesson:** PRD and intent documents are the source of truth, not code.

**Why:** Code drifts from requirements without clear documentation.

**Standard:** Update intent coverage matrix when implementing features.

## Integration Lessons

### 8. Linear Fault Reporting

**Lesson:** Implement automatic error reporting with deduplication.

**Why:** Manual error tracking misses production issues.

**Standard:** Use the linear-integration-module with:
- MD5 hash deduplication (1-hour window)
- Priority mapping (critical=1, error=2, warning=3)
- Context capture (stack trace, user ID, URL)

### 9. Webhook Signature Verification

**Lesson:** Always verify webhook signatures in production.

**Why:** Unverified webhooks are security vulnerabilities.

**Standard:**
```python
def verify_signature(payload: bytes, signature: str) -> bool:
    expected = hmac.new(
        SECRET.encode(), payload, hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(signature, expected)
```

### 10. OAuth PKCE Flow

**Lesson:** Use PKCE for OAuth flows, especially for public clients.

**Why:** PKCE prevents authorization code interception attacks.

**Standard:** Generate verifier/challenge pair and validate on callback.

## Tool Configuration Lessons

### 11. Claude Code Rules

**Lesson:** Configure AI assistants with explicit rules about TDD and BMAD.

**Why:** Without rules, AI assistants skip test design and make overconfident claims.

**Standard:** Use the CLAUDE.md template from this repository.

### 12. Cursor Integration

**Lesson:** Provide context files to Cursor for better assistance.

**Why:** Without context, Cursor makes assumptions that don't match project standards.

**Standard:** Configure cursor-settings.json with project-specific rules.

## Deployment Lessons

### 13. Render Deployment Verification

**Lesson:** Test API endpoints after deployment, don't assume success.

**Why:** Deployment logs showing success don't guarantee endpoints work.

**Standard:** Add health check endpoints and verify them post-deployment:
```bash
curl https://your-backend.onrender.com/api/health
```

### 14. Environment Variable Sync

**Lesson:** Keep local `.env` and Render environment variables in sync.

**Why:** Features work locally but fail in production due to missing variables.

**Standard:** Use a checklist when adding new environment variables.

## Communication Lessons

### 15. No Overconfident Claims

**Lesson:** Use precise language about what has been verified.

**Why:** "Everything works" when tests haven't run erodes trust.

**Standard:**
- "Tests pass" = Actually ran tests and saw output
- "Expected to pass" = Haven't run tests yet
- "Not verified" = Cannot confirm
