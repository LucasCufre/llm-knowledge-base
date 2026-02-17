---
title: Real-Time Architecture Options
type: research
date: 2025-11-12
status: completed
researcher: Maria Chen
tags: [technical-research, real-time, websockets, sse, polling, architecture]
summary: |
  Evaluated three approaches for real-time updates in TaskFlow:
  WebSockets, Server-Sent Events, and long polling. WebSockets
  recommended for bidirectional communication needs and broad
  browser support.
related-docs:
  - ../04-knowledge-base/business/requirements/example-real-time-task-collaboration-requirement.md
  - ../04-knowledge-base/technical/architecture/example-system-architecture-overview.md
---

# Research: Real-Time Architecture Options

## Research Question

What is the best approach for delivering real-time task updates to connected TaskFlow clients, considering our requirements for < 500ms delivery, presence indicators, and multi-server deployment?

## Methodology

- Evaluated three approaches: WebSockets, Server-Sent Events (SSE), and long polling
- Built lightweight prototypes for each approach
- Load tested with simulated 500 concurrent connections
- Evaluated on: latency, scalability, browser support, and bidirectional communication needs
- Consulted industry benchmarks and case studies from Linear, Figma, and Notion

## Key Findings

### Finding 1: WebSockets provide the best latency and bidirectional support

- Average message delivery: 45ms (prototype, single server)
- Supports bidirectional communication (needed for presence: "user started typing")
- Native browser support in all modern browsers (> 97% global coverage)
- Established patterns for scaling with Redis pub/sub across multiple servers
- Trade-off: Slightly more complex server-side than SSE

### Finding 2: SSE is simpler but limited to server-to-client

- Average message delivery: 50ms (comparable to WebSockets)
- Server-to-client only - would need separate mechanism for client-to-server events
- Simpler server implementation (just HTTP streaming)
- Auto-reconnection built into the browser API
- Limitation: Presence indicators (typing, viewing) require bidirectional communication, making SSE insufficient as the sole solution

### Finding 3: Long polling is outdated for our use case

- Average message delivery: 200-500ms (significant overhead from HTTP request/response cycle)
- Simple to implement but creates unnecessary server load
- Every client makes a new HTTP request every few seconds
- At 500 concurrent users with 5-second polling: 100 requests/second just for polling
- Not suitable for < 500ms delivery target at scale

## Performance Comparison

| Metric | WebSockets | SSE | Long Polling |
|--------|-----------|-----|-------------|
| Avg delivery latency | 45ms | 50ms | 200-500ms |
| Server connections per client | 1 | 1 | 1 (recycled) |
| Bidirectional | Yes | No | No |
| Server load (500 clients) | Low (persistent) | Low (persistent) | High (100 req/s) |
| Reconnection | Manual (library) | Automatic | Automatic |
| Browser support | 97%+ | 96%+ | 100% |
| Proxy/CDN compatibility | Good (with path config) | Excellent | Excellent |

## Scaling Approach for WebSockets

For multi-server deployments (our production setup with auto-scaling ECS):

1. Each API server instance maintains its own WebSocket connections
2. When a task is updated, the API server publishes an event to a Redis pub/sub channel
3. All API server instances are subscribed to Redis channels for their connected workspaces
4. Each instance forwards relevant events to its local WebSocket connections

This pattern is well-proven (used by Slack, Discord, and Linear) and adds only Redis as a dependency (which we already have for caching).

## Recommendations

1. **Use WebSockets** for the real-time communication layer
2. Use the `ws` library (lightweight, no Socket.IO overhead)
3. Implement Redis pub/sub for multi-server message broadcasting
4. Add a reconnection strategy with exponential backoff on the client
5. Fall back to polling only for clients behind restrictive corporate proxies (< 3% of users based on industry data)

## Next Steps

- Integrate WebSocket server into the existing Express.js API server (same process, shared port)
- Define event schema for task updates, presence, and notifications
- Implement Redis pub/sub integration for workspace channels
- Client-side: Build WebSocket provider in React with TanStack Query cache invalidation

## Raw Data & Sources

- Prototype code: `experiments/realtime-poc/` branch
- Load test results: k6 scripts targeting 500 concurrent connections
- [Linear's engineering blog on real-time sync](https://linear.app/blog)
- [Figma's multiplayer technology overview](https://www.figma.com/blog/how-figmas-multiplayer-technology-works/)
- MDN WebSocket documentation

## Related Documents

- [Real-Time Task Collaboration Requirement](../04-knowledge-base/business/requirements/example-real-time-task-collaboration-requirement.md)
- [System Architecture Overview](../04-knowledge-base/technical/architecture/example-system-architecture-overview.md)
