# TDD Workflow Guide

This guide provides the practical TDD workflow proven in FloCommand development.

## The TDD Cycle

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│    1. RED        →    2. GREEN      →    3. REFACTOR       │
│    Write test        Make it pass       Clean up code      │
│    (fails)           (minimum code)     (maintain tests)   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Phase 1: Before Writing Any Code

### 1.1 Locate Requirements (BMAD)

```bash
# Check for relevant intents
ls bmad/intents/ || ls intent/

# Check PRD
cat docs/prd.md || cat docs/01_strategy/prd/index.md

# Search for related requirements
rg "FR-" docs/ --type md
```

### 1.2 Design Tests First

For each requirement, write a test scenario:

```gherkin
Given [initial context]
When [action is performed]
Then [expected outcome]
```

### 1.3 Create Test File

**Python (pytest):**
```python
# tests/test_feature.py
import pytest
from myapp.feature import Feature

class TestFeature:
    """Tests for Feature - Intent 06: Opportunity Pipeline"""
    
    def test_create_opportunity_with_valid_data(self):
        """Given valid opportunity data, When created, Then returns opportunity ID."""
        # Arrange
        data = {"name": "Test Opportunity", "value": 10000}
        
        # Act
        result = Feature.create_opportunity(data)
        
        # Assert
        assert result.id is not None
        assert result.name == "Test Opportunity"
    
    def test_create_opportunity_with_missing_name_raises_error(self):
        """Given missing name, When created, Then raises ValidationError."""
        data = {"value": 10000}
        
        with pytest.raises(ValidationError):
            Feature.create_opportunity(data)
```

**JavaScript (vitest):**
```typescript
// tests/feature.test.ts
import { describe, it, expect } from 'vitest';
import { Feature } from '../src/feature';

describe('Feature - Intent 06: Opportunity Pipeline', () => {
  it('creates opportunity with valid data', async () => {
    // Given
    const data = { name: 'Test Opportunity', value: 10000 };
    
    // When
    const result = await Feature.createOpportunity(data);
    
    // Then
    expect(result.id).toBeDefined();
    expect(result.name).toBe('Test Opportunity');
  });
  
  it('throws error when name is missing', async () => {
    const data = { value: 10000 };
    
    await expect(Feature.createOpportunity(data))
      .rejects.toThrow('Validation');
  });
});
```

## Phase 2: Run Tests (They Should Fail)

```bash
# Python
pytest tests/test_feature.py -v

# JavaScript
npm test -- tests/feature.test.ts

# E2E
npx cypress run --spec "cypress/e2e/feature.cy.ts"
```

Expected output: Tests fail because implementation doesn't exist yet.

## Phase 3: Implement Minimum Code

Write ONLY the code needed to make tests pass:

```python
# myapp/feature.py
from dataclasses import dataclass
from uuid import uuid4

class ValidationError(Exception):
    pass

@dataclass
class Opportunity:
    id: str
    name: str
    value: int

class Feature:
    @staticmethod
    def create_opportunity(data: dict) -> Opportunity:
        if "name" not in data:
            raise ValidationError("Name is required")
        
        return Opportunity(
            id=str(uuid4()),
            name=data["name"],
            value=data.get("value", 0)
        )
```

## Phase 4: Run Tests Again

```bash
pytest tests/test_feature.py -v
```

Expected output: All tests pass.

## Phase 5: Refactor (If Needed)

- Clean up code while keeping tests green
- Run tests after each refactor step
- Never refactor and change functionality simultaneously

## Test Categories

### Unit Tests
- Test individual functions/methods in isolation
- Mock external dependencies
- Fast execution (<100ms per test)

### Integration Tests
- Test component interactions
- Use real database (test instance)
- Slower execution (acceptable)

### E2E Tests
- Test complete user workflows
- Use browser automation
- Slowest execution (use sparingly)

## Test Naming Conventions

```
test_<action>_<condition>_<expected_result>

Examples:
- test_create_opportunity_with_valid_data_returns_id
- test_create_opportunity_with_missing_name_raises_error
- test_delete_opportunity_when_not_found_returns_404
```

## Directory Structure

```
project/
├── src/                    # Source code
│   └── feature/
├── tests/
│   ├── unit/              # Unit tests
│   │   └── test_feature.py
│   ├── integration/       # Integration tests
│   │   └── test_feature_db.py
│   └── e2e/               # E2E tests
│       └── test_feature_workflow.py
├── cypress/               # Cypress E2E tests
│   └── e2e/
│       └── feature.cy.ts
└── pytest.ini             # Test configuration
```

## Commands Reference

```bash
# Run all tests
pytest                      # Python
npm test                    # JavaScript

# Run specific test file
pytest tests/test_feature.py -v
npm test -- tests/feature.test.ts

# Run tests matching pattern
pytest -k "opportunity"
npm test -- --grep "opportunity"

# Run with coverage
pytest --cov=src --cov-report=html
npm test -- --coverage

# Run E2E tests
npx cypress run
npx playwright test
```

## CI/CD Integration

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: |
          pip install -r requirements.txt
          pytest --cov=src
```
