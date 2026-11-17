# Requirements: Alpenfeld B2B Ordering Portal

Source: [vision.md](vision.md). Domain terms follow the [glossary](glossary.md).

## Functional Requirements

### Buyer

| ID     | Title                    | User Story                                                                                                                                                         | Priority | Status |
|--------|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------|
| FR-001 | Search Products          | As a Buyer, I want to search products by name, Article Number, or keyword so that I find what I need without calling Alpenfeld.                                    | High     | Open   |
| FR-002 | Browse Categories        | As a Buyer, I want to browse products by Category so that I can find products when I do not know their exact name.                                                 | Medium   | Open   |
| FR-003 | View Product Details     | As a Buyer, I want to see the description, technical data, and images of a product so that I can choose the right product.                                        | High     | Open   |
| FR-004 | View Contract Prices     | As a Buyer, I want to see the Contract Price of my Business Customer for every product so that I know what I will actually pay instead of the List Price.         | High     | Open   |
| FR-005 | View Stock               | As a Buyer, I want to see the Stock of a product so that I know whether it can be delivered.                                                                       | High     | Open   |
| FR-006 | Add Product to Cart      | As a Buyer, I want to add a product with a quantity to my Cart so that I can collect the products I want to order.                                                | High     | Open   |
| FR-007 | Edit Cart                | As a Buyer, I want to change the quantity of an Order Line or remove it from my Cart so that my Cart contains exactly what I want to order.                       | High     | Open   |
| FR-008 | Place Order              | As a Buyer, I want to place an Order from my Cart so that Alpenfeld delivers the products at my Contract Prices.                                                  | High     | Open   |
| FR-009 | Submit Order for Approval | As a Buyer, I want an Order whose total exceeds my Order Limit to be sent to my Purchasing Manager for Approval so that I can still order what my work requires. | High     | Open   |
| FR-010 | Place Order During ERP Outage | As a Buyer, I want to place an Order while the ERP is unavailable so that I can order at any time.                                                           | High     | Open   |
| FR-011 | View Order History       | As a Buyer, I want to see my Orders with their Order Status so that I know whether an Order is Pending Approval, Rejected, Placed, or Transferred.              | High     | Open   |
| FR-012 | Request Quote            | As a Buyer, I want to send a Quote Request for the content of my Cart so that I can get a better price for large quantities.                                       | High     | Open   |
| FR-013 | Accept Quote             | As a Buyer, I want to accept a valid Quote and order at the quoted prices so that I get the negotiated price without re-entering the products.                     | High     | Open   |
| FR-014 | Request Return           | As a Buyer, I want to request a Return for Order Lines of a delivered Order so that I can send back products without a phone call.                                | High     | Open   |
| FR-015 | Track Return             | As a Buyer, I want to see the Return Status of my Returns so that I know whether a Return was accepted.                                                            | Medium   | Open   |

### Purchasing Manager

| ID     | Title           | User Story                                                                                                                                                      | Priority | Status |
|--------|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------|
| FR-016 | Approve Order   | As a Purchasing Manager, I want to approve an Order that exceeds the Order Limit of a Buyer of my Business Customer so that the Order is processed.             | High     | Open   |
| FR-017 | Reject Order    | As a Purchasing Manager, I want to reject an Order that exceeds the Order Limit with a reason so that my Business Customer does not pay for Products it does not need. | High     | Open   |
| FR-018 | Add Buyer       | As a Purchasing Manager, I want to add a Buyer to my Business Customer so that a new employee can order in the portal.                                          | High     | Open   |
| FR-019 | Deactivate Buyer | As a Purchasing Manager, I want to deactivate a Buyer of my Business Customer so that a former employee can no longer order.                                  | High     | Open   |
| FR-020 | Set Order Limit | As a Purchasing Manager, I want to set the Order Limit of each Buyer of my Business Customer so that I control what each Buyer can order without Approval.      | High     | Open   |

### Sales Representative

| ID     | Title                  | User Story                                                                                                                                                  | Priority | Status |
|--------|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------|
| FR-021 | View Quote Requests    | As a Sales Representative, I want to see the open Quote Requests so that I can answer them in time.                                                         | High     | Open   |
| FR-022 | Answer Quote Request   | As a Sales Representative, I want to answer a Quote Request with a Quote that states a price per Order Line and a validity date so that the Buyer can order. | High     | Open   |
| FR-023 | Decline Quote Request  | As a Sales Representative, I want to decline a Quote Request with a reason so that the Buyer knows that no Quote will follow.                             | Medium   | Open   |
| FR-024 | View Key Account Activity | As a Sales Representative, I want to see the Orders and Quote Requests of my Key Accounts so that I can look after them.                                 | Medium   | Open   |

### Customer Service

| ID     | Title                 | User Story                                                                                                                                  | Priority | Status |
|--------|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------|----------|--------|
| FR-025 | Process Return        | As a member of Customer Service, I want to accept or reject a Return with a reason so that returned products are handled without a phone call.          | High     | Open   |
| FR-026 | Look Up Customer Orders | As a member of Customer Service, I want to find the Orders of any Business Customer with their Order Status so that I can help customers with their Orders. | High     | Open   |

### Integration with PIM and ERP

| ID     | Title                     | User Story                                                                                                                                                                                       | Priority | Status |
|--------|---------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------|
| FR-027 | Synchronize Product Data  | As a Buyer, I want the portal to copy the Product Data and images from the PIM every hour so that I can search and view products even when the PIM is unavailable.                             | High     | Open   |
| FR-028 | Synchronize Prices and Stock | As a Buyer, I want the portal to copy the Contract Prices and Stock from the ERP every hour so that I see my prices and the Stock even when the ERP is unavailable.                         | High     | Open   |
| FR-029 | Transfer Order to ERP     | As a Buyer, I want every placed or approved Order to be transferred to the ERP exactly once, also after an ERP outage, so that my Order is processed without getting lost or delivered twice. | High     | Open   |

## Non-Functional Requirements

| ID      | Title                     | Requirement                                                                                                                                                         | Category     | Priority | Status |
|---------|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|----------|--------|
| NFR-001 | Response Time             | 99.9% of page loads and product searches must complete within 2 seconds under the load of NFR-002. ¹                                                                  | Performance  | High     | Open   |
| NFR-002 | Concurrent Users          | The portal must serve 300 concurrent users while meeting NFR-001. ¹                                                                                               | Scalability  | High     | Open   |
| NFR-003 | Portal Availability       | The portal must be available 99.5% of each calendar month.                                                                                                          | Availability | High     | Open   |
| NFR-004 | Independence from PIM     | Product search, product details, and ordering must work while the PIM is unavailable.                                                                              | Availability | High     | Open   |
| NFR-005 | Independence from ERP     | Product search, Contract Prices, Stock, and ordering must work while the ERP is unavailable.                                                                       | Availability | High     | Open   |
| NFR-006 | Data Freshness            | While the PIM and the ERP are available, the copied Product Data, Contract Prices, and Stock must be no more than 60 minutes older than in the source system.     | Availability | High     | Open   |
| NFR-007 | Order Transfer Delay      | An Order held during an ERP outage must be transferred within 15 minutes after the ERP is available again. ¹                                                       | Availability | High     | Open   |
| NFR-008 | Exactly-Once Transfer     | Each Order must reach the ERP exactly once: an outage or failure test with repeated transfer attempts must show zero lost and zero duplicate Orders in the ERP. | Availability | High     | Open   |
| NFR-009 | Authentication            | Every page except the sign-in page must require an authenticated user.                                                                                              | Security     | High     | Open   |
| NFR-010 | Business Customer Isolation | A Buyer or Purchasing Manager must only see the Contract Prices, Orders, Quotes, and Returns of their own Business Customer.                                     | Security     | High     | Open   |
| NFR-011 | Role-Based Access         | Approval and Buyer administration must be restricted to Purchasing Managers, answering Quote Requests to Sales Representatives, and processing Returns to Customer Service. | Security | High | Open   |
| NFR-012 | Encryption in Transit     | All connections to the portal and to the PIM and ERP must use TLS 1.2 or higher.                                                                                    | Security     | High     | Open   |
| NFR-013 | User Interface Languages  | The user interface must be available in German, French, and English, selectable by each user.                                                                      | Usability    | High     | Open   |

¹ Threshold proposed by the analyst; to be confirmed by Alpenfeld.

## Constraints

| ID    | Title                 | Constraint                                                                                                                                                  | Category   | Source               | Priority | Status |
|-------|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|------------|----------------------|----------|--------|
| C-001 | PIM as Master         | The PIM is the master of Product Data and images; the portal must not change them.                                                                          | Technical  |                      | High     | Open   |
| C-002 | ERP as Master         | The ERP is the master of Contract Prices, Stock, order processing, and invoices; the portal must not change them.                                          | Technical  |                      | High     | Open   |
| C-003 | Commerce Platform     | In production, products, Carts, Orders, and Business Customers must be stored in commercetools.                                                            | Technical  |                      | High     | Open   |
| C-004 | Currency              | All prices and Order totals must be in Swiss francs (CHF).                                                                                                  | Business   |                      | High     | Open   |
| C-005 | Return Window         | A Return may only be requested within 30 days after delivery of the Order. ¹                                                                                | Business   |                      | High     | Open   |
| C-006 | Data Residency        | Personal data of portal users must only be stored in Switzerland or in a country the Federal Council lists as providing adequate data protection.          | Regulatory | revFADP Art. 16(1)   | High     | Open   |
