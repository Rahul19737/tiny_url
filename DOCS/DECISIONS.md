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