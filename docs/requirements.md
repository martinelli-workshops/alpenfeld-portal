# Requirements

This provisional catalog is derived from `docs/vision.md` because no requirements catalog was present. The vision does not define measurable quality targets or an approval threshold; those details remain open and are not assumed here.

## Functional Requirements

| ID | Title | User Story | Priority | Status |
|----|-------|------------|----------|--------|
| FR-001 | Browse Products | As a Buyer, I want to find products and view their details so that I can choose what to purchase. | High | Open |
| FR-002 | View Customer Prices and Stock | As a Buyer, I want to see my business customer's applicable contract prices and the latest available stock quantity so that I can make an informed purchase. | High | Open |
| FR-003 | Place an Order | As a Buyer, I want to place an order online so that I can purchase products without calling or emailing Alpenfeld Supply. | High | Open |
| FR-004 | Approve an Order | As a Purchasing Manager, I want to approve or reject orders above my business customer's approval limit so that purchases follow the customer's spending policy. | High | Open |
| FR-005 | Manage Buyers | As a Purchasing Manager, I want to manage the buyers for my business customer so that only authorized employees can place orders. | High | Open |
| FR-006 | Request a Quote | As a Buyer, I want to request a quote for a large quantity of products so that I can receive pricing for a larger purchase. | Medium | Open |
| FR-007 | Respond to a Quote Request | As a Sales Representative, I want to prepare a response to a quote request so that the customer can review pricing for a large purchase. | Medium | Open |
| FR-008 | Request a Return | As a Buyer, I want to submit a return request for ordered products so that I can return products without calling customer service. | Medium | Open |
| FR-009 | Handle a Return Request | As a member of Customer Service, I want to handle a business customer's return request so that the return can be resolved through the portal. | Medium | Open |
| FR-010 | Check Data Freshness | As a Buyer, I want to see when product details, contract prices, and stock were last synchronized so that I can judge how current the information is. | High | Open |
| FR-011 | View Data During Source Outages | As a Buyer, I want to search products and view prices and stock when the PIM or ERP is unavailable so that I can continue using the portal. | High | Open |
| FR-012 | Preserve Orders During ERP Outages | As a Buyer, I want an order placed while the ERP is unavailable to be retained and transferred once the ERP is available so that my order is not lost or transferred twice. | High | Open |

## Non-Functional Requirements

The vision does not specify other measurable quality targets.

| ID | Title | Requirement | Category | Priority | Status |
|----|-------|-------------|----------|----------|--------|
| NFR-001 | Catalog Data Freshness | When the PIM or ERP is available, the portal must synchronize the corresponding product data, contract prices, and stock at least once every 60 minutes. | Performance | High | Open |

## Constraints

| ID | Title | Constraint | Category | Source | Priority | Status |
|----|-------|------------|----------|--------|----------|--------|
| C-001 | Product Data Source | Product data and images originate from the PIM. | Technical | docs/vision.md | High | Open |
| C-002 | Commercial Data Source | Contract prices, stock, order processing, and invoices originate from the ERP. | Technical | docs/vision.md | High | Open |
| C-003 | Independent Portal Data | The portal keeps its own copy of product data, contract prices, and stock rather than requiring the PIM or ERP to be available for customer access. | Technical | docs/vision.md | High | Open |
| C-004 | Contract Price Display | The portal does not display a list price as a substitute when no current contract price applies to a Product and Business customer. | Business | | High | Open |
