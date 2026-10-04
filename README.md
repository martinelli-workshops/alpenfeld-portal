# Alpenfeld B2B Ordering Portal - Spec-Driven Development Workshop

This is the companion application for the **Spec-Driven Development (SDD) Workshop** (commercetools cohort).<br>
It serves as a hands-on project where participants learn to build applications by driving implementation from
specifications.

## The Case: Alpenfeld Supply

Alpenfeld Supply is a fictitious mid-sized distributor of tools, fasteners and workshop supplies. About 1,200
business customers (craft businesses, industrial workshops and facility managers) order today by phone, email and
an old web shop that only shows list prices.

The new B2B ordering portal on commercetools lets customers find products, see their own contract prices and order
online. Orders above a limit need the approval of the customer's purchasing manager, sales answers quote requests
for large quantities in the portal, and returns no longer need a phone call.

The full input is [docs/vision.md](docs/vision.md).

### Actors

- **Buyer** - an employee of a business customer who places orders
- **Purchasing Manager** - approves orders and manages the buyers of their company
- **Sales Representative** - answers quote requests and looks after key accounts
- **Customer Service** - handles returns and helps customers with their orders

### External Systems

- **ERP** - contract prices, stock, order processing, invoices
- **PIM** - product data and images

## The Lab Setup

In production, products, carts, orders and customers live in commercetools. In the lab, a **local H2 database
stands in for commercetools**. This is a stack decision, not a spec decision: the specifications stay the same
whichever stack implements them.

The ERP is simulated as well: contract prices and stock come from a seeded table, and the order transfer is
written to the log. The specifications still document the real interface.

## Tech Stack

- **Java 25** with **Spring Boot 4.1**
- **Vaadin 25** for the UI (Java-based views)
- **jOOQ** for type-safe SQL and data access
- **Flyway** for database migrations
- **H2** as the database (embedded, no external setup required)
- **Vaadin Browserless Testing** for server-side UI unit tests
- **Playwright** for browser-based integration tests

## Prerequisites

- **Java 25** (or later)
- **Maven** (or use the included `mvnw` wrapper)

Alternatively, open the repository in **GitHub Codespaces**. The `.devcontainer` sets up Java, Maven and Node and
creates a personal `workshop/<github-user>` branch.

## Running the Application

The application uses an embedded H2 database — no Docker or external database setup required.

```bash
./mvnw spring-boot:run
```

Or run `AlpenfeldApplication.main()` directly from your IDE.

## Build and Code Generation

The Maven build uses a two-step pipeline during `generate-sources`:

1. **Flyway** runs database migrations against a file-based H2 database
2. **jOOQ** generates type-safe Java code from the H2 schema

```bash
./mvnw compile
```

## Running Tests

Unit tests (Browserless) are run by **Surefire** with `mvnw test`. Integration tests (Playwright) use the `*IT`
suffix and are run by the **Failsafe** plugin, which is bound to the `integration-test` and `verify` phases.

**Unit tests only:**

```bash
./mvnw test
```

**All tests (unit + integration):**

```bash
./mvnw verify
```

The `verify` phase ensures that the Failsafe plugin picks up all `*IT` classes (e.g. `PlaywrightIT` subclasses)
and reports their results correctly. Always use `verify` instead of `integration-test` directly, so that test
failures are properly detected.
