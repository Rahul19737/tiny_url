# Product Requirements Document (PRD)

# Tiny URL Service
**Sprint:** Sprint 1 (Core URL Shortening)

---

## Problem Statement

Users need a simple service that converts long URLs into short, reliable links that can be easily shared while always redirecting to the original destination.

---

## Goal

Build a Minimum Viable Product (MVP) that allows users to:

- Submit a long URL.
- Receive a shortened URL.
- Visit the shortened URL and be redirected to the original URL.

---

## Target Users

- General public users.
- Users who need a quick and easy way to share long URLs.

---

## Scope

### In Scope (Sprint 1)

- Create a short URL from a valid long URL.
- Redirect users from the short URL to the original URL.
- Validate user input.
- Ensure each generated short URL is unique.

---

## Out of Scope (Sprint 1)

The following features are intentionally excluded from the MVP:

- User accounts
- Authentication & Authorization
- Analytics / Click tracking
- Custom aliases
- QR Code generation
- URL expiration
- Admin dashboard
- Rate limiting
- API versioning
- Bulk URL shortening

These features will be considered in future sprints.

---

## Functional Requirements

### FR-1: Shorten URL

The system shall accept a valid URL and generate a unique shortened URL.

### FR-2: Redirect

The system shall redirect users visiting the shortened URL to the original destination.

### FR-3: URL Validation

The system shall reject malformed or invalid URLs.

### FR-4: Unique Short Codes

Each generated short URL shall have a unique identifier.

---

## Non-Functional Requirements

### Performance

- URL redirection should have minimal latency.

### Reliability

- URL mappings shall be persisted in PostgreSQL.
- Generated URLs shall remain functional after application restarts.

### Scalability

- The architecture should support future horizontal scaling.

### Maintainability

- The codebase should be modular, testable, and easy to extend.

### Security

- Only valid HTTP and HTTPS URLs shall be accepted.
- User input shall be validated before persistence.

---

## Acceptance Criteria

### AC-1

**Given** a valid URL

**When** the user submits it for shortening

**Then** the system returns a shortened URL.

---

### AC-2

**Given** an existing shortened URL

**When** a user visits it

**Then** the system redirects the user to the original URL.

---

### AC-3

**Given** an invalid URL

**When** the user attempts to shorten it

**Then** the system returns an appropriate validation error.

---

### AC-4

**Given** a valid URL

**When** it is shortened

**Then** the mapping between the short code and original URL is persisted in the database.

---

## Risks

- Short code collisions must be handled.
- Invalid URLs must not be persisted.
- Redirect performance should remain acceptable as the dataset grows.

---

## Data Model

### ShortUrl

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | bigint | Primary key | Record Identifier
| original_url | string | Not Null | Original destination URL |
| short_code | string | Unique, Not Null | Unique generated identifier |
| created_at | datetime | Not Null | Record creation timestamp |
| updated_at | datetime | Not Null | Record update timestamp |

---

## Deliverables (Sprint 1)

- Create the `ShortUrl` model
- Design the database schema
- Create database migrations
- Implement URL shortening endpoint
- Implement URL redirection endpoint
- Validate input URLs
- Generate unique short codes
- Add request specs
- Maintain passing CI pipeline

---

## API Endpoints

### POST /short_urls

Creates a new shortened URL.

#### Request

```json
{
  "url": "https://example.com/very/long/url"
}
```

#### Response

**201 Created**

```json
{
  "short_url": "http://localhost:3000/abc123"
}
```

#### Error Response

**422 Unprocessable Entity**

```json
{
  "errors": [
    "URL is invalid"
  ]
}
```

### GET /:short_code

Redirects to the original URL associated with the short code.

#### Response

- **302 Found** → Redirects to the original URL.
- **404 Not Found** → If the short code does not exist.

---

## Assumptions

- Short codes are generated automatically.
- Short codes are immutable.
- Duplicate long URLs may generate different short URLs.
- URLs are publicly accessible.

---

## Constraints

- Rails API only.
- PostgreSQL as the persistence layer.
- RSpec for testing.
- RuboCop for linting.

---

## Success Criteria

Sprint 1 is considered complete when:

- A valid URL can be shortened.
- Visiting the short URL redirects correctly.
- Invalid URLs are rejected.
- Automated tests pass.
- CI pipeline remains green.

---

## Future Work

The following enhancements are planned beyond Sprint 1:

- User authentication
- Analytics
- Custom aliases
- URL expiration
- QR code generation
- Rate limiting
- API versioning