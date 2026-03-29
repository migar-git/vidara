# Architecture — vidara

## 3-Tier Diagram

```
┌──────────────────────────────────────────────────────┐
│  FRONTEND TIER                                        │
│  None                                              │
└──────────────────────┬───────────────────────────────┘
                       │ HTTP / WebSocket
┌──────────────────────▼───────────────────────────────┐
│  BACKEND TIER                                         │
│  Framework: N/A                                     │
│  Port:      N/A                                     │
└──────────────────────┬───────────────────────────────┘
                       │ Internal calls
┌──────────────────────▼───────────────────────────────┐
│  APPLICATION TIER (Services / Workers)                │
  - Python library
└──────────────────────────────────────────────────────┘
```

## Key Architectural Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Framework | N/A | (add rationale) |
| Auth | Bearer/JWT | Portfolio standard |
| API versioning | /api/v1/ | Portfolio standard |

## Dependencies

- **Upstream:** (what this repo calls)
- **Downstream:** (what calls this repo)
- See `AGENT.md → dependencies` for agency graph

## Data Flow

```
(describe primary data flow here)
```

*Last updated: 2026-03-29*
