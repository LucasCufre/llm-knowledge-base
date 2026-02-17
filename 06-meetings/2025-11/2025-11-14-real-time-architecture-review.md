---
title: Real-Time Architecture Review
type: meeting-note
date: 2025-11-14
attendees: [Maria Chen, James Park, Alex Torres, Sarah Kim]
meeting-type: review
tags: [architecture, real-time, websockets, technical-review]
summary: |
  Technical review of the proposed real-time architecture for TaskFlow.
  Approved WebSocket approach with Redis pub/sub. Decided on event
  schema and presence indicator design. Implementation starts next sprint.
related-docs:
  - ../../05-research/example-real-time-architecture-options.md
  - ../../04-knowledge-base/business/requirements/example-real-time-task-collaboration-requirement.md
  - ../../04-knowledge-base/technical/architecture/example-system-architecture-overview.md
---

# Real-Time Architecture Review

**Date:** 2025-11-14
**Time:** 14:00 - 15:00 ET
**Attendees:** Maria Chen (Tech Lead), James Park, Alex Torres, Sarah Kim (PM)
**Facilitator:** Maria Chen

## Agenda

1. Review real-time architecture research findings
2. Agree on WebSocket event schema
3. Presence indicator design decisions
4. Implementation plan and timeline

## Key Discussion Points

### Research Findings Review

(14:02) Maria presented the real-time architecture options research. WebSockets were the clear winner over SSE and long polling.

- Maria: "WebSockets give us 45ms average delivery and bidirectional communication. We need bidirectional for presence features - knowing when someone starts viewing or editing a task."
- Alex: "What about Socket.IO vs. the raw ws library?"
- Maria: "The ws library. Socket.IO adds 30KB to the client bundle and includes features we don't need like rooms and namespaces. We're building our own room logic with Redis pub/sub anyway."

### Event Schema Design

(14:20) The team discussed what events should flow through the WebSocket connection.

- Maria proposed a simple event envelope:
  ```json
  { "type": "task.updated", "workspaceId": "ws_123", "payload": { ... }, "userId": "usr_456", "timestamp": "..." }
  ```
- James: "Should we include the full task object in the payload, or just the changed fields?"
- Maria: "Changed fields only (partial update). Full objects would waste bandwidth, especially for large task descriptions."
- Alex: "What about ordering? If two updates arrive out of order..."
- Maria: "We include a version number on tasks. The client applies updates only if the version is newer than what it has. TanStack Query handles the cache update."

### Presence Indicators

(14:40) Sarah shared the user research finding that workspace-level presence feels like surveillance, but task-level presence is valued.

- Sarah: "Lisa's research was clear: show who's viewing a specific task, but don't show a general 'online' list."
- James: "How do we implement task-level presence? Heartbeat?"
- Maria: "Yes. When a user opens a task detail view, the client sends a `presence.join` event. The server broadcasts to other clients in that workspace. Heartbeat every 30 seconds. If no heartbeat for 60 seconds, the user is considered gone."
- Alex: "Do we need a dedicated data store for presence, or is Redis enough?"
- Maria: "Redis is perfect for this. Store presence as a sorted set per task, with the score being the last heartbeat timestamp. Redis automatically gives us efficient expiry checks."

## Decisions Made

1. **Use ws library (not Socket.IO)** for WebSocket server - Smaller bundle, we don't need Socket.IO's abstractions.
2. **Partial updates in events** - Send only changed fields, not full objects. Version number for ordering.
3. **Task-level presence only** - No workspace-level online status. Heartbeat-based with 30s interval and 60s timeout.
4. **Redis for presence state** - Sorted sets per task, timestamp as score.

## Action Items

- [ ] **Create WebSocket event schema document** - Assigned to: Maria Chen - Due: 2025-11-18
- [ ] **Implement WebSocket server in API** - Assigned to: Alex Torres - Due: 2025-11-22
- [ ] **Implement Redis pub/sub integration** - Assigned to: James Park - Due: 2025-11-22
- [ ] **Build presence heartbeat system** - Assigned to: Alex Torres - Due: 2025-11-25
- [ ] **Update system architecture doc with WS details** - Assigned to: Maria Chen - Due: 2025-11-18

## Blockers Identified

- None. Authentication system (prerequisite) is on track for completion this sprint.

## Next Steps

- Implementation starts next sprint (November 18)
- Maria updates the architecture document with the approved design
- Alex starts with a basic WebSocket echo server, then adds Redis pub/sub
- Target: Real-time task updates demo-able by November 25

## References

- [Real-Time Architecture Options Research](../../05-research/example-real-time-architecture-options.md)
- [Collaboration Patterns User Research](../../04-knowledge-base/business/user-research/example-team-collaboration-patterns-study.md)
