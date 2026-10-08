# Use Case: Search Products

## Overview

**Use Case ID:** UC-001  
**Use Case Name:** Search Products  
**Primary Actor:** Buyer  
**Secondary Actors:** PIM, ERP  
**Goal:** Find the Products the Buyer needs and see their details, the Contract Price of the Buyer's Business Customer, and their Stock before ordering  
**Trigger:** Buyer requests a Product search  
**Status:** Approved  

**Requirements:** [FR-001, FR-002, FR-003, FR-004, NFR-001, NFR-002, NFR-003, NFR-005, NFR-006, NFR-007, C-001, C-002](../requirements.md)

## Preconditions

- Buyer is signed in to the portal and belongs to an active Business Customer
- Portal Copy holds Product data, Contract Prices, and Stock from at least one Refresh

## Main Success Scenario

1. Buyer opens the Product search.
2. Buyer enters a search term.
3. System finds the Products in the Portal Copy that match the search term.
4. System displays the first page of matching Products, each with name, article number, the Contract Price of the Buyer's Business Customer, and Stock.
5. Buyer selects a Product from the results.
6. System displays the Product details with name, article number, description, images, the Contract Price of the Buyer's Business Customer, and Stock, and the Buyer has found the Product.

## Alternative Flows

### A1: Browse All Products

**Trigger:** Buyer starts the search without a search term (step 2)  
**Flow:**

1. System selects all Products in the Portal Copy.
2. Use case continues at step 4.

### A2: No Matching Product

**Trigger:** No Product in the Portal Copy matches the search term (step 3)  
**Flow:**

1. System informs the Buyer that no Product matches the search term.
2. Buyer enters a different search term.
3. Use case continues at step 3.

### A3: Page Through Results

**Trigger:** More Products match than fit on one page, and the Buyer moves to another page (step 4)  
**Flow:**

1. System displays the requested page of matching Products.
2. Use case continues at step 5.

### A4: Product Without Contract Price

**Trigger:** The Buyer's Business Customer has no Contract Price for a displayed Product (step 4)  
**Flow:**

1. System marks the Product as "no Contract Price" instead of showing a price, in the results and in the Product details.
2. System offers the Buyer to send a Quote Request for the Product instead of ordering it.
3. Use case continues at step 5.

### A5: Refine Search

**Trigger:** Buyer changes the search term instead of selecting a Product (step 5)  
**Flow:**

1. Buyer enters the new search term.
2. Use case continues at step 3.

### A6: Product No Longer Available

**Trigger:** The selected Product was removed from the Portal Copy by a Refresh after the results were displayed (step 5)  
**Flow:**

1. System informs the Buyer that the Product is no longer available.
2. System displays the results again without the removed Product.
3. Use case continues at step 5.

### A7: Buyer Leaves the Search

**Trigger:** Buyer finds no suitable Product and leaves the search (step 5)  
**Flow:**

1. Use case ends.

## Postconditions

### Success Postconditions

- Buyer sees the details of the selected Product with the Contract Price of the Buyer's Business Customer and the Stock as held in the Portal Copy
- Product data, Contract Prices, and Stock remain unchanged in the Portal Copy, the PIM, and the ERP

### Failure Postconditions

- Product data, Contract Prices, and Stock remain unchanged in the Portal Copy, the PIM, and the ERP
- No Contract Price of another Business Customer is shown to the Buyer

## Business Rules

### BR-001: Portal Copy as Data Source

Search results and Product details are read from the Portal Copy only, never directly from the PIM or the ERP. The search works with the same results while the PIM or the ERP is unavailable. The data is shown without a notice of when it was last refreshed, also when the PIM or the ERP is unavailable for longer than 60 minutes and the Portal Copy is older than 60 minutes.

### BR-002: Search Matching

A Product matches when its name, article number, or description contains the search term, regardless of upper and lower case. An empty search term matches all Products.

### BR-003: Result Order and Paging

Matching Products are sorted by name and shown in pages of 25 Products.

### BR-004: Own Contract Prices Only

The Buyer sees only the Contract Prices of the Buyer's own Business Customer, never the Contract Price of another Business Customer.

### BR-005: Product Without Contract Price

A Product without a Contract Price for the Buyer's Business Customer stays in the results, is marked "no Contract Price", and cannot be ordered. The Buyer can send a Quote Request for it (UC-004).

### BR-006: Stock Display

The Stock is shown as the quantity available for delivery held in the Portal Copy. A Product with a Stock of 0, or without any Stock in the Portal Copy, stays in the results and is shown as out of stock.
