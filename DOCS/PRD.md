# Product Requirements Document (PRD)

# Tiny URL Service
**Version:** 0.1  
**Sprint:** Sprint 0 (Project Initialization)

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

- URL redirection should be fast.

### Reliability

- Generated URLs should continue to work after application restarts.

### Scalability

- The architecture should support future horizontal scaling.

### Maintainability

- The codebase should be modular, testable, and easy to extend.

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

## Deliverables (Sprint 0)

- Initialize Git repository
- Create project documentation
- Generate Rails API application
- Configure PostgreSQL
- Configure RSpec
- Configure RuboCop
- Verify the application boots successfully
- Ensure at least one passing test

---

## Success Criteria

Sprint 0 is considered complete when:

- The development environment is fully operational.
- Documentation has been created.
- The project is under version control.
- Automated tests can be executed successfully.
- The team is ready to begin implementing Sprint 1 features.