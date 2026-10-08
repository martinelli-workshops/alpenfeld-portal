# Requirements: Alpenfeld B2B Ordering Portal

Source: [vision.md](vision.md). Terms follow the [glossary](glossary.md).

## Functional Requirements

| ID     | Title                    | User Story                                                                                                                  | Priority | Status       |
|--------|--------------------------|-----------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| FR-001 | Search Products          | As a Buyer, I want to search and browse Products so that I can find the Products I need.                                    | High     | Open         |
| FR-002 | View Product Details     | As a Buyer, I want to see Product details and images so that I can confirm I have the right Product.                        | High     | Open         |
| FR-003 | View Contract Prices     | As a Buyer, I want to see the Contract Prices of my Business Customer so that I know what I pay before I order.             | High     | Open         |
| FR-004 | View Stock               | As a Buyer, I want to see the Stock of each Product so that I know whether it can be delivered.                             | High     | Open         |
| FR-005 | Place Order              | As a Buyer, I want to place an Order online so that I no longer need to order by phone or email.                            | High     | Open         |
| FR-006 | Hold Orders Above Limit  | As a Purchasing Manager, I want Orders above the Order Limit to wait for my Approval so that I control what Buyers spend.   | High     | Needs review |
| FR-007 | Approve or Reject Order  | As a Purchasing Manager, I want to approve or reject pending Orders so that only approved Orders reach the ERP.             | High     | Open         |
| FR-008 | Manage Buyers            | As a Purchasing Manager, I want to add and deactivate the Buyers of my Business Customer so that I choose who can order.    | High     | Open         |
| FR-009 | Request Quote            | As a Buyer, I want to send a Quote Request for a large quantity so that I get a price for a big order.                      | Medium   | Open         |
| FR-010 | Answer Quote Request     | As a Sales Representative, I want to answer Quote Requests in the portal so that large-quantity requests no longer go by email. | Medium | Open       |
| FR-011 | View Key Accounts        | As a Sales Representative, I want to see the Business Customers I look after so that I can serve key accounts.             | Medium   | Open         |
| FR-012 | Request Return           | As a Buyer, I want to request a Return online so that I no longer need a phone call.                                        | High     | Open         |
| FR-013 | Process Return           | As a Customer Service agent, I want to process Return requests in the portal so that Returns no longer need a phone call.   | High     | Open         |
| FR-014 | View Order Status        | As a Buyer, I want to see my Orders and their status so that I can follow them.                                             | High     | Open         |
| FR-015 | Look Up Orders           | As a Customer Service agent, I want to look up the Orders of any Business Customer so that I can help with questions.       | Medium   | Open         |
| FR-016 | Order Without ERP        | As a Buyer, I want to place Orders while the ERP is unavailable so that ordering never stops.                               | High     | Open         |

## Non-Functional Requirements

| ID      | Title                    | Requirement                                                                                                                  | Category     | Priority | Status       |
|---------|--------------------------|------------------------------------------------------------------------------------------------------------------------------|--------------|----------|--------------|
| NFR-001 | Response Time            | Product search and Product detail pages must respond within 2 seconds for 95% of requests.                                    | Performance  | High     | Needs review |
| NFR-002 | Outage Tolerance         | Search, Product details, Contract Prices, Stock, and Order placement must succeed for 100% of requests while the PIM or the ERP is unreachable. | Availability | High | Open |
| NFR-003 | Data Freshness           | The Portal Copy must be no older than 60 minutes for Product data, Contract Prices, and Stock while the PIM and the ERP are reachable. | Availability | High | Open |
| NFR-004 | Order Transfer Integrity | Every accepted Order must reach the ERP exactly once: 0 lost and 0 duplicate Orders in ERP outage tests.                     | Availability | High     | Open         |
| NFR-005 | Concurrent Customers     | The portal must serve 1,200 Business Customers with their Buyers while keeping the NFR-001 response times.                   | Scalability  | Medium   | Open         |
| NFR-006 | Data Isolation           | Buyers and Purchasing Managers must see only the Orders, Buyers, and Contract Prices of their own Business Customer; 0 cross-customer data exposures in access tests. | Security | High | Open |
| NFR-007 | Authentication           | 100% of pages except sign-in must require an authenticated session.                                                          | Security     | High     | Needs review |
| NFR-008 | Transport Encryption     | All traffic between the browser and the portal must use TLS 1.2 or higher.                                                  | Security     | High     | Needs review |

## Constraints

| ID    | Title                    | Constraint                                                                                                     | Category  | Priority | Status |
|-------|--------------------------|----------------------------------------------------------------------------------------------------------------|-----------|----------|--------|
| C-001 | Product Master Data      | The PIM is the master for Product data and images. The portal must only read them.                             | Technical | High     | Open   |
| C-002 | Contract Price and Stock Master | The ERP is the master for Contract Prices and Stock. The portal changes them only through Order Transfer.  | Technical | High     | Open   |
| C-003 | Invoicing                | The ERP owns invoices. The portal does not issue invoices.                                                     | Business  | Medium   | Open   |
