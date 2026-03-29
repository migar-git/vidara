# MEMORY.md — vidara
**Last updated:** 2026-03-29
**Group:** Infrastructure

## Portfolio Role
Vidara Python library — UV-managed, src layout

## Architecture Snapshot
- **Backend tier:** None
- **Application tier:**
- Python library
- **Frontend tier:** None
- **API connectors:** None defined

## Key Decisions
<!-- Add major architectural decisions here as they are made -->
- (none yet)

## Known Issues
<!-- Non-obvious bugs, workarounds, gotchas -->
- (none recorded)

## Integration Points
<!-- How this repo connects to others in the portfolio -->
- Governed by: `AGENT.md` (authority ceiling: see authority.max_auto_level)
- Monitored by: `dev-analytics/analytics/`
- Swarm assigned via: `AGENTS.md`

## Notes for Agents
<!-- Context that an agent needs to work effectively in this repo -->
- Read `AGENT.md` before making any changes
- Check `dev-analytics/analytics/gap_ledger.jsonl` for open gaps
- Follow `dev-analytics/SWARM_RUNBOOK.md` iteration protocol
