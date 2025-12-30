# Claude Code Skills & Capabilities

This document defines the standard capabilities and skills that Claude Code should have access to in all projects. These should be configured in Claude Code settings or MCP server configurations.

## Core Capabilities

### 1. File Operations

| Capability | Tool | Description |
|------------|------|-------------|
| Read files | `Read` | Read file contents with line numbers |
| Write files | `Write` | Create or overwrite files |
| Edit files | `Edit` | Make targeted edits to existing files |
| Search files | `Glob` | Find files by pattern |
| Search content | `Grep` | Search file contents with regex |

### 2. Shell Operations

| Capability | Tool | Description |
|------------|------|-------------|
| Run commands | `Bash` | Execute shell commands |
| Background tasks | `Bash` (background) | Run long-running processes |
| Git operations | `Bash` | Version control commands |

### 3. Web Operations

| Capability | Tool | Description |
|------------|------|-------------|
| Fetch URLs | `WebFetch` | Retrieve and process web content |
| Search web | `WebSearch` | Search the internet for information |

### 4. Task Management

| Capability | Tool | Description |
|------------|------|-------------|
| Todo tracking | `TodoWrite` | Track task progress |
| Sub-agents | `Task` | Spawn specialized agents |

## MCP Server Integrations

### Required MCP Servers

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-playwright"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"]
    },
    "linear": {
      "command": "npx",
      "args": ["-y", "mcp-linear"],
      "env": {
        "LINEAR_API_KEY": "${LINEAR_API_KEY}"
      }
    },
    "clerk": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-clerk"],
      "env": {
        "CLERK_SECRET_KEY": "${CLERK_SECRET_KEY}"
      }
    }
  }
}
```

### MCP Server Capabilities

#### Playwright MCP
- Browser automation
- Screenshot capture
- Page navigation
- Form filling
- Element interaction

#### GitHub MCP
- Repository management
- Issue creation/updates
- Pull request operations
- Code search
- File operations on remote repos

#### Context7 MCP
- Documentation lookup
- Library reference
- Up-to-date API information

#### Linear MCP
- Issue management
- Project tracking
- Comment creation
- Team operations

#### Clerk MCP
- User management
- Organization operations
- Metadata updates
- Invitation management

## Skill Definitions

### Code Analysis
```
Skill: Analyze codebase structure
Tools: Glob, Grep, Read
Workflow:
1. Use Glob to find relevant files
2. Use Grep to search for patterns
3. Use Read to examine specific files
```

### TDD Implementation
```
Skill: Implement feature with TDD
Tools: Read, Write, Edit, Bash
Workflow:
1. Read existing tests and code
2. Write new test file
3. Run tests (should fail)
4. Write implementation
5. Run tests (should pass)
```

### Git Operations
```
Skill: Commit and push changes
Tools: Bash
Workflow:
1. git status - check changes
2. git diff - review changes
3. git add - stage files
4. git commit - create commit
5. git push - push to remote
```

### Web Research
```
Skill: Research technical topic
Tools: WebSearch, WebFetch, Context7
Workflow:
1. WebSearch for overview
2. WebFetch specific documentation
3. Context7 for library-specific info
```

### Bug Investigation
```
Skill: Investigate and fix bug
Tools: Grep, Read, Edit, Bash
Workflow:
1. Grep for error message
2. Read relevant files
3. Identify root cause
4. Edit fix
5. Run tests
```

## Configuration Files

### Claude Desktop Config

Location: `~/.claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    // See MCP Server Integrations above
  }
}
```

### Project CLAUDE.md

Location: `.claude/CLAUDE.md` or project root

See `tool-configs/CLAUDE.md` for the standard template.

## Capability Verification

To verify Claude Code has required capabilities, run these checks:

```bash
# Check MCP servers
claude mcp list

# Verify file access
claude "Read the README.md file"

# Verify git access
claude "Run git status"

# Verify web access
claude "Search for Python pytest documentation"
```

## Capability Restrictions

The following should be restricted or require approval:

| Action | Restriction | Reason |
|--------|-------------|--------|
| `git push --force` | Require approval | Destructive |
| `rm -rf` | Require approval | Destructive |
| Database writes | Require approval | Data integrity |
| External API calls | Log and monitor | Security |
| File writes outside project | Block | Security |

## Best Practices

1. **Always use TodoWrite** for multi-step tasks
2. **Verify file paths** before operations
3. **Run tests** after code changes
4. **Commit frequently** with descriptive messages
5. **Use Context7** for library documentation
6. **Use Task tool** for complex searches
