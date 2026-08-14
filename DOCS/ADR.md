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

# ADR-007: Use 6-Character Base62 Short Codes

**Status:** Accepted

## Context

The Tiny URL Service needs a short identifier for each shortened URL.

The identifier should be compact enough to keep shortened URLs short while providing a sufficiently large namespace for the expected number of URLs.

We considered different code lengths and character sets, as well as sequential identifiers.

## Decision

Use **6-character Base62 short codes** for shortened URLs.

Base62 consists of:

* `a-z`
* `A-Z`
* `0-9`

Six Base62 characters provide:

**62⁶ = 56,800,235,584 possible combinations.**

Each generated short code must:

* Contain exactly 6 characters.
* Use only Base62 characters.
* Be unique.
* Be generated automatically when a `ShortUrl` is created.

Uniqueness will be enforced both at the application level and at the database level.

## Generation Strategy

Short codes will be generated using Ruby's `SecureRandom` module.

`SecureRandom` is preferred over general-purpose pseudo-random generation because
the short codes should be difficult to predict.

The generated characters will be selected from the Base62 alphabet:

`a-z`, `A-Z`, and `0-9`.

The application will generate six characters for each new `ShortUrl`.

## Rationale

Six characters provide a practical balance between URL length and the size of the available namespace.

Random Base62 codes also make identifiers less predictable than sequential identifiers, making simple enumeration more difficult.

However, randomness is not considered an authorization or privacy mechanism.

* Uses a cryptographically secure random source.
* Makes generated short codes less predictable.
* Uses Ruby's standard library rather than introducing an additional dependency.

## Alternatives Considered

### Shorter Codes

Shorter codes produce smaller URLs but reduce the available namespace and increase the likelihood of collisions as the number of URLs grows.

### Longer Codes

Longer codes provide a larger namespace but make shortened URLs unnecessarily long for the expected scope of the project.

### Sequential IDs

Sequential IDs are simple and can avoid random-generation collisions, but they are predictable and make enumeration of other shortened URLs easier.

### Random Base62 Codes

Random Base62 codes provide a large namespace, compact URLs, and less predictable identifiers.

## Consequences

### Positive

* Compact shortened URLs.
* Large namespace of possible codes.
* URL-safe character set.
* Less predictable than sequential identifiers.
* Provides a straightforward foundation for the URL-shortening service.

### Negative

* Random generation can produce collisions.
* Collision handling is required.
* The database must enforce uniqueness.
* The decision may need to be revisited if the system's scale or requirements change significantly.

## Revisit

Revisit this decision if the expected number of URLs, security requirements, traffic patterns, or identifier-generation strategy changes significantly.

# ADR-008: Handle Short Code Collisions with Bounded Retries

**Date:** 14 August 2026

**Status:** Accepted

## Context

Short codes are generated randomly from a 6-character Base62 namespace.

Although the namespace contains approximately 56.8 billion possible combinations, random generation can still produce a short code that already exists in the database.

The database enforces uniqueness on `short_code`, so a collision results in an `ActiveRecord::RecordNotUnique` exception.

## Decision

When a short code collision occurs during creation, the application will generate a new short code and retry the creation.

The system will allow a maximum of **3 total creation attempts**.

If all 3 attempts result in a uniqueness collision, the operation will fail with `ActiveRecord::RecordNotUnique`.

The database unique constraint remains the final authority for enforcing uniqueness.

## Rationale

- Random collisions are possible even with a large namespace.
- Retrying allows the application to recover from occasional collisions automatically.
- A bounded retry limit prevents infinite retry loops.
- Database-level uniqueness provides the final guarantee against duplicate short codes.

## Consequences

### Positive

- Automatically recovers from rare short code collisions.
- Keeps collision handling transparent to callers.
- Prevents unbounded retries.
- Preserves database-level uniqueness enforcement.

### Negative

- A collision requires another database creation attempt.
- Extremely rare repeated collisions will cause creation to fail.
- Retry behavior adds some complexity to the creation workflow.

## Revisit

This decision should be revisited if the short code generation strategy, expected scale, or persistence architecture changes significantly.

---

## Future ADRs

Future architectural decisions may include:

* URL validation strategy.
* Database indexing.
* Caching strategy.
* Analytics architecture.
* Rate limiting.
* Deployment architecture.
* Horizontal scaling approach.
* Monitoring and logging.
