# Architecture Decisions

This document records important technical decisions made throughout the project.

The purpose of this document is to:

- Explain why a decision was made.
- Document alternatives that were considered.
- Help future contributors understand the reasoning.
- Provide historical context as the project evolves.

---

# ADR-001: Choose PostgreSQL as the Primary Database

**Date:** 17 July 2026

**Status:** Accepted

## Context

The Tiny URL service requires persistent storage for URL mappings.

Each shortened URL must be associated with its original URL and remain available even after the application restarts.

Since this project is also intended to teach production-grade backend engineering and system design concepts, the choice of database should reflect real-world usage.

---

## Decision

We will use **PostgreSQL** as the primary relational database.

---

## Alternatives Considered

### SQLite

**Pros**

- Extremely simple setup
- Zero configuration
- Great for prototypes

**Cons**

- Not representative of most production Rails applications
- Limited concurrency
- Less suitable for learning production database concepts

---

### MySQL

**Pros**

- Mature and widely adopted
- Excellent performance
- Large ecosystem

**Cons**

- Our team's existing experience is stronger with PostgreSQL
- PostgreSQL offers features that are commonly used in modern Rails applications

---

## Why PostgreSQL?

We selected PostgreSQL because it:

- Is widely used in production Rails applications.
- Provides excellent support for indexing and query optimization.
- Handles concurrent workloads effectively.
- Offers advanced features that will become valuable as the project grows.
- Aligns well with future system design topics such as replication, partitioning, and scaling.

---

## Consequences

### Positive

- Production-relevant learning experience.
- Easier to explore advanced database concepts later.
- Strong Rails ecosystem support.

### Negative

- Slightly more setup compared to SQLite.
- Requires a running database service during development.

---

## Revisit

This decision should be revisited only if future project requirements significantly change.

---

# ADR-002: Use 6-Character Base62 Short Codes

**Date:** 13 August 2026

**Status:** Accepted

## Context

The Tiny URL service needs a short identifier for each shortened URL.

The identifier should be:

* Short enough to keep generated URLs compact.
* Large enough to support a substantial number of URL mappings.
* Simple to generate and use as a URL-safe identifier.

We considered different code lengths and character sets.

A Base62 character set consists of:

* `a-z`
* `A-Z`
* `0-9`

With 6 Base62 characters, the system has:

**62⁶ = 56,800,235,584 possible combinations.**

This provides a large namespace while keeping the generated short code compact.

## Decision

We will generate **6-character Base62 short codes** for shortened URLs.

The `short_code` must:

* Contain exactly 6 characters.
* Use only Base62 characters.
* Be unique.
* Be generated automatically when a `ShortUrl` is created.

The database will enforce uniqueness on `short_code` in addition to the Active Record uniqueness validation.

## Alternatives Considered

### Fewer Characters

Shorter codes reduce URL length but provide a smaller namespace and increase the probability of collisions as the number of stored URLs grows.

### More Characters

Longer codes provide a larger namespace but make the resulting URLs less compact than necessary for the expected scope of this project.

### Sequential Numeric IDs

Using encoded database IDs could avoid random-generation collisions, but sequential identifiers can make URL enumeration easier and introduce different design considerations around predictability.

### Random Base62 Codes

Random Base62 codes provide a large namespace while keeping URLs compact and making identifiers less predictable than sequential IDs.

## Why 6 Characters?

Six characters provide a practical balance between URL length and namespace size for the scope of this project.

The 6-character Base62 namespace contains approximately **56.8 billion** possible codes, which is substantially larger than the expected number of URLs for this project.

Random generation can still produce collisions, so collision handling and database-level uniqueness enforcement are required.

## Consequences

### Positive

* Short and readable URLs.
* Large namespace of possible codes.
* URL-safe character set.
* Less predictable than sequential identifiers.
* Provides an opportunity to explore collision handling and database constraints.

### Negative

* Random generation can produce collisions.
* Collision handling is required.
* The chosen length may need to be revisited if the expected scale changes significantly.

## Revisit

This decision should be revisited if the expected number of stored URLs, traffic patterns, security requirements, or identifier-generation strategy changes significantly.
