# Requirements Catalog

Source: [Vision](vision.md)

## Functional Requirements

| ID | Title | User Story | Priority | Status |
|---|---|---|---|---|
| FR-001 | Search Products | As a Buyer, I want to search the product catalog so that I can find products to order. | High | Open |
| FR-002 | View Product Details | As a Buyer, I want to view product details and images so that I can choose the right product. | High | Open |
| FR-003 | View Contract Prices and Stock | As a Buyer, I want to see the Contract Price and Stock for my Business Customer so that I can make an informed order. | High | Open |
| FR-004 | Place an Order | As a Buyer, I want to submit an Order online so that I can purchase products without calling or emailing Alpenfeld. | High | Open |
| FR-005 | Approve Orders Above a Limit | As a Purchasing Manager, I want to approve Orders that exceed my company's configured limit so that I can control employee purchasing. | High | Open |
| FR-006 | Manage Buyers | As a Purchasing Manager, I want to manage the Buyers for my Business Customer so that only authorized employees can purchase on its behalf. | Medium | Open |
| FR-007 | Request a Quote | As a Buyer, I want to request a quote for a large quantity so that I can get pricing for a purchase that needs a direct sales response. | Medium | Open |
| FR-008 | Respond to Quote Requests | As a Sales Representative, I want to respond to quote requests so that Buyers can receive pricing for large-quantity purchases. | Medium | Open |
| FR-009 | Submit a Return Request | As a Buyer, I want to submit a Return Request online so that I can begin the process without calling Alpenfeld. | High | Open |
| FR-010 | Handle Return Requests | As a Customer Service, I want to handle Return Requests so that customers receive support with returned purchases. | High | Open |
| FR-011 | Support Orders | As a Customer Service, I want to access order information so that I can help customers with their Orders. | Medium | Open |
| FR-012 | Operate During External-System Outages | As a Buyer, I want to search products, see the latest copied Contract Prices and Stock, and submit Orders when the PIM or ERP is unavailable so that an upstream outage does not prevent portal use. | High | Open |
| FR-013 | Transfer Queued Orders | As a Buyer, I want Orders submitted during an ERP outage to be transferred when the ERP becomes available, without loss or duplicate transfer, so that my purchase is reliably processed. | High | Open |

## Non-Functional Requirements

The vision does not define measurable performance, capacity, security, accessibility, or service-availability targets. The stated 1,200 Business Customers is an account count, not a concurrent-user target. These targets require stakeholder decisions before NFRs can be specified.

| ID | Title | Requirement | Category | Priority | Status |
|---|---|---|---|---|---|

## Constraints

| ID | Title | Constraint | Category | Priority | Status |
|---|---|---|---|---|---|
| C-001 | Product Data Source | Product data and images must be sourced from the PIM. | Technical | High | Open |
| C-002 | Commercial Data Source | Contract Prices and Stock must be sourced from the ERP; order processing and invoice data remain in the ERP. | Technical | High | Open |
| C-003 | Local Data Copies | The portal must maintain its own copies of PIM product data and ERP Contract Prices and Stock, rather than requiring either external system to be available for portal use. | Technical | High | Open |
| C-004 | Data Refresh Cadence | The portal's copies of product data, Contract Prices, and Stock must be refreshed every hour. | Operational | High | Open |