# Use Case: Find Product

## Overview

**Use Case ID:** UC-001  
**Use Case Name:** Find Product  
**Primary Actor:** Buyer  
**Goal:** Find a Product and see its Product Data, the price the Buyer's Business Customer pays, and its Stock, so the Buyer can decide what to order  
**Trigger:** Buyer looks for a Product to order  
**Status:** Draft  

**Requirements:** [FR-001, FR-002, FR-003, FR-004, FR-005, NFR-001, NFR-004, NFR-005, NFR-009, NFR-010, C-001, C-002, C-004](../requirements.md)

## Preconditions

- Buyer is authenticated and belongs to a Business Customer
- Product Data has been copied into the portal by at least one Synchronization (UC-017)

## Main Success Scenario

1. Buyer enters a search term: a Product name, an Article Number, or a keyword.
2. System displays the Products matching the search term, each with its name, Article Number, price, and Stock.
3. Buyer selects a Product from the result.
4. System displays the Product's description, technical data, images, Category, price, and Stock; the Buyer has found the Product.

## Alternative Flows

### A1: Browse by Category

**Trigger:** Buyer does not know the Product's name and chooses to browse the Categories instead of searching (step 1)  
**Flow:**

1. System displays the top-level Categories.
2. Buyer selects a Category.
3. System displays the sub-Categories of the selected Category and the Products it contains, each with its name, Article Number, price, and Stock.
4. Buyer selects a sub-Category, and the System repeats step 3 of this flow, until the Buyer sees the Product.
5. Use case continues at step 3.

### A2: No Matching Product

**Trigger:** No Product matches the search term (step 2)  
**Flow:**

1. System informs the Buyer that no Product matches the search term.
2. Buyer enters a different search term or chooses to browse the Categories.
3. Use case continues at step 1.

### A3: Product No Longer Offered

**Trigger:** The selected Product was removed by a Synchronization after the result was displayed (step 3)  
**Flow:**

1. System informs the Buyer that the Product is no longer offered.
2. System displays the result again without the removed Product.
3. Use case continues at step 3.

## Postconditions

### Success Postconditions

- Buyer sees the Product's Product Data, the price that applies to the Buyer's Business Customer, and its Stock
- No Product Data, Contract Price, List Price, or Stock is changed

### Failure Postconditions

- No Product Data, Contract Price, List Price, or Stock is changed
- No Contract Price of another Business Customer is shown to the Buyer

## Business Rules

### BR-001: Search Matching

A Product matches the search term when its name, its Article Number, or one of its keywords contains the search term, regardless of upper and lower case.

### BR-002: Price Shown

The price shown for a Product is the Contract Price agreed for the Buyer's own Business Customer. When the Business Customer has no Contract Price for the Product, the List Price is shown and labelled as List Price. All prices are shown in CHF.

### BR-003: Stock Shown

The Stock is shown as the quantity available for delivery. A Stock of 0 means the Product is currently not available for delivery.

### BR-004: Data from the Last Synchronization

Product Data, prices, and Stock are shown as copied by the last Synchronization (UC-017, UC-018), so that finding Products works while the PIM or the ERP is unavailable. The time of the last Synchronization is not shown to the Buyer.

### BR-005: Products of a Category

The Products of a Category include the Products of all its sub-Categories.
