# Tiny URL

A URL shortener application that takes a long URL and generates a shortened URL. The shortened URL can then be used to redirect users to the original page.

## Goal

Build a scalable, production-ready URL shortener application while following modern software engineering practices.

**Current Status:** Sprint 0 Completed ✅

## Tech Stack

- **Ruby:** 3.4.10
- **Rails:** 8.1.3 (API Mode)
- **Database:** PostgreSQL 18.4
- **Testing:** RSpec
- **Linting:** RuboCop (Rails Omakase)
- **CI/CD:** GitHub Actions

## Setup

### Prerequisites

- Ruby 3.4.10
- PostgreSQL 18.4
- Bundler

### Installation

```bash
git clone <repository-url>
cd tiny_url

bundle install

bin/rails db:create
bin/rails db:migrate
```

### Running the application

```bash
bin/rails server
```

The application will be available at:

```
http://localhost:3000
```

## Running Tests

```bash
bundle exec rspec
```

## Running RuboCop

```bash
bundle exec rubocop
```

## Project Workflow

- Create a feature branch for every new feature.
- Open a Pull Request before merging.
- Ensure all GitHub Actions checks pass.
- Squash merge into `main`.

## Project Status

- ✅ Sprint 0 – Project Initialization
- ⏳ Sprint 1 – URL Shortening
- ⏳ Sprint 2 – URL Redirection
- ⏳ Sprint 3 – Analytics (Planned)
