---
title: Authentication Service Architecture
type: technical-doc
date: 2025-11-10
last-updated: 2025-11-10
status: active
owner: James Park
stakeholders: [Engineering Team, Security]
tags: [architecture, authentication, oauth, jwt, security]
summary: |
  Detailed architecture of the TaskFlow authentication service covering
  JWT-based sessions, OAuth integration, password management, and
  the security model for token lifecycle.
related-docs:
  - example-system-architecture-overview.md
  - ../../../02-decisions/2025-11-10-implement-rbac-with-casbin.md
  - ../../business/requirements/example-user-authentication-requirement.md
  - ../apis-and-integrations/example-rest-api-documentation.md
---

# Authentication Service Architecture

## Overview

**Purpose:**
Manages user identity, authentication flows, and session lifecycle for TaskFlow. This is not a standalone microservice - it's a module within the API server that handles all auth-related routes and middleware.

**Scope:**
Covers email/password auth, OAuth (Google, GitHub), JWT lifecycle, and session management. Authorization (RBAC via Casbin) is documented in ADR-002.

**Key Design Principles:**
- Defense in depth: Multiple security layers (rate limiting, input validation, token rotation)
- Stateless sessions: JWTs for API authentication, with refresh tokens stored in database
- Fail closed: Any auth error results in 401, never a default-allow

---

## System Context

**External Dependencies:**
- Google OAuth 2.0 API - Social login provider
- GitHub OAuth API - Social login provider
- SendGrid API - Password reset and verification emails

**Internal Dependencies:**
- PostgreSQL - User records, refresh tokens, OAuth accounts
- Redis - Rate limiting counters, short-lived token blocklist

**Consumers:**
- React SPA (login/register forms, token management)
- All API routes (via auth middleware)
- WebSocket service (JWT validation during handshake)

---

## High-Level Architecture

```
┌───────────────────────────────────────────────────┐
│                   API Server                       │
│                                                   │
│  ┌─────────────┐  ┌─────────────┐  ┌──────────┐ │
│  │ Auth Routes  │  │ Auth        │  │ Casbin   │ │
│  │ /api/auth/*  │  │ Middleware  │  │ RBAC     │ │
│  └──────┬──────┘  └──────┬──────┘  └────┬─────┘ │
│         │                │               │       │
│         v                v               v       │
│  ┌─────────────────────────────────────────────┐ │
│  │           Auth Service Module               │ │
│  │  - JWT generation/validation (RS256)        │ │
│  │  - Password hashing (bcrypt)                │ │
│  │  - OAuth flow orchestration                 │ │
│  │  - Rate limiting (Redis)                    │ │
│  └─────────────────────────────────────────────┘ │
└───────────────────────────────────────────────────┘
         │                    │
         v                    v
  ┌──────────────┐    ┌──────────────┐
  │  PostgreSQL  │    │    Redis     │
  │  - users     │    │  - rate      │
  │  - tokens    │    │    limits    │
  │  - oauth     │    │  - blocklist │
  └──────────────┘    └──────────────┘
```

---

## Detailed Design

### Token Lifecycle

**Access Token (JWT):**
- Algorithm: RS256 (asymmetric, allows public key verification)
- Expiry: 15 minutes
- Payload: `{ sub: userId, workspace: workspaceId, role: "member", iat, exp }`
- Stored: Client-side only (memory or httpOnly cookie)

**Refresh Token:**
- Opaque random string (64 bytes, base64url encoded)
- Expiry: 30 days (or 7 days without "remember me")
- Stored: PostgreSQL `sessions` table (hashed with SHA-256)
- Rotation: New refresh token issued on each use; old token invalidated

**Token Refresh Flow:**
1. Client detects 401 response or access token approaching expiry
2. Client sends refresh token to `POST /api/auth/refresh`
3. Server validates refresh token against database hash
4. Server issues new access token + new refresh token
5. Old refresh token is invalidated (one-time use)
6. If refresh token is already used (replay attack), all user sessions are invalidated

### OAuth Flow

1. Client redirects to `GET /api/auth/oauth/google` (or github)
2. Server generates state parameter (CSRF protection), stores in Redis (5 min TTL)
3. Server redirects to provider's authorization URL
4. User grants consent, provider redirects to `GET /api/auth/oauth/callback`
5. Server validates state parameter, exchanges code for tokens
6. Server fetches user profile from provider API
7. If email exists in database: link OAuth account, issue tokens
8. If email new: create user account + OAuth account, issue tokens

### Password Security

- Hashing: bcrypt with cost factor 12
- Minimum requirements: 8 characters, at least 1 number
- Reset flow: Time-limited token (1 hour), single-use, sent via email
- Breach detection: Future consideration (HaveIBeenPwned API)

---

## Security Measures

| Measure | Implementation | Target |
|---------|---------------|--------|
| Rate limiting | Redis sliding window | 5 login attempts/minute/IP |
| CSRF protection | Double-submit cookie + OAuth state param | All state-changing routes |
| Token rotation | Refresh tokens are single-use | Limit replay attack window |
| Input validation | Zod schemas on all auth endpoints | Reject malformed requests |
| Secure headers | Helmet.js middleware | HSTS, X-Frame-Options, CSP |

---

## Revision History

| Date | Author | Changes |
|------|--------|---------|
| 2025-11-10 | James Park | Initial architecture document |
