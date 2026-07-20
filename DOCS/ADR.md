# Architecture Decision Records (ADR)

## Purpose

This document captures the significant architectural and technical decisions made throughout the development of the Tiny URL Service.

Each ADR answers four questions:

1. What problem were we trying to solve?
2. What options did we consider?
3. What decision did we make?
4. What are the consequences of that decision?

Once an ADR is accepted, it serves as historical documentation. Future changes should be recorded by creating new ADRs rather than modifying existing ones.

---

# ADR-001: Use Rails API Mode

**Status:** Accepted

## Context

The Tiny URL Service is intended to expose a REST API rather than render server-side HTML pages.

## Decision

Use Rails API mode instead of the default full-stack Rails application.

## Rationale

* Smaller middleware stack.
* Better performance for API workloads.
* Removes unnecessary view-related components.
* Aligns with modern backend service architecture.

## Consequences

### Positive

* Lightweight application.
* Faster boot time.
* Easier API development.
* Less maintenance overhead.

### Negative

* No built-in server-rendered views.
* Additional work required if a web interface is introduced later.

---

# ADR-002: Use PostgreSQL as the Database

**Status:** Accepted

## Context

The application requires persistent storage for URL mappings and should be capable of scaling beyond local development.

## Decision

Use PostgreSQL as the primary database.

## Rationale

* Production-ready relational database.
* Excellent Rails support.
* Strong indexing capabilities.
* Reliable transactions.
* Widely adopted in industry.

## Consequences

### Positive

* Reliable persistence.
* Better scalability than SQLite.
* Suitable for production deployment.

### Negative

* Requires local installation and configuration.
* Slightly more complex development setup.

---

# ADR-003: Use RSpec for Testing

**Status:** Accepted

## Context

The project requires automated testing to ensure correctness while features evolve.

## Decision

Use RSpec instead of Rails' default Minitest framework.

## Rationale

* Widely used in professional Rails projects.
* Expressive testing syntax.
* Rich ecosystem.
* Strong community support.

## Consequences

### Positive

* Readable tests.
* Better alignment with many production Rails codebases.
* Easy integration with request, model, and service specs.

### Negative

* Additional dependency.
* Slight learning curve for newcomers.

---

# ADR-004: Use RuboCop (Rails Omakase)

**Status:** Accepted

## Context

The project requires a consistent coding style and automated linting.

## Decision

Use RuboCop with the Rails Omakase configuration.

## Rationale

* Rails-maintained default style guide.
* Reduces style-related discussions.
* Encourages consistent code quality.

## Consequences

### Positive

* Consistent formatting.
* Early detection of code smells.
* Easy CI integration.

### Negative

* Developers must occasionally adapt to enforced conventions.

---

# ADR-005: Use GitHub Actions for Continuous Integration

**Status:** Accepted

## Context

Every code change should be automatically validated before merging.

## Decision

Use GitHub Actions to execute the CI pipeline.

## Rationale

The pipeline automatically:

* Builds the application.
* Runs RuboCop.
* Runs the RSpec test suite.
* Performs Ruby security analysis.

## Consequences

### Positive

* Prevents broken code from reaching the main branch.
* Encourages frequent testing.
* Provides fast developer feedback.

### Negative

* Slightly longer feedback cycle for each pull request.

---

# ADR-006: Use Feature Branches with Pull Requests

**Status:** Accepted

## Context

A structured Git workflow improves code quality and keeps the `main` branch stable.

## Decision

Adopt a feature-branch workflow with Pull Requests and squash merges.

## Workflow

```
main
   ▲
Pull Request
   ▲
feature/<feature-name>
```

## Rationale

* Isolates feature development.
* Encourages code review.
* Keeps commit history clean.
* Works well with CI.

## Consequences

### Positive

* Stable `main` branch.
* Easier collaboration.
* Clear project history.

### Negative

* Slightly more process than committing directly to `main`.

---

## Future ADRs

Future architectural decisions may include:

* Short code generation strategy.
* Collision handling algorithm.
* URL validation strategy.
* Database indexing.
* Caching strategy.
* Analytics architecture.
* Rate limiting.
* Deployment architecture.
* Horizontal scaling approach.
* Monitoring and logging.
