# Use Case: Browse Products and Prices

## Overview

**Use Case ID:** UC-001  
**Use Case Name:** Browse Products and Prices  
**Primary Actor:** Buyer  
**Secondary Actors:** PIM, ERP  
**Goal:** The Buyer finds Products of interest and reviews their available details, the business customer's applicable Contract prices, and Stock to decide what to purchase.  
**Trigger:** The Buyer requests to browse the product catalog.  
**Status:** Draft  

**Requirements:** [FR-001, FR-002, FR-010, FR-011, NFR-001, C-001, C-002, C-003, C-004](../requirements.md)

## Preconditions

- The Buyer has an active portal account associated with a Business customer.

## Main Success Scenario

1. The Buyer opens the product catalog or enters search terms.
2. The system displays Products matching the Buyer's search criteria.
3. The Buyer selects a Product to review.
4. The system displays the Product's available details, the applicable Contract price for the Buyer's Business customer, the latest available Stock quantity, and the recorded synchronization time for each available item of data.
5. The Buyer reviews the Product information and identifies Products of interest.

## Alternative Flows

### A1: No Matching Products

**Trigger:** No Products match the Buyer's search criteria (step 2)  
**Flow:**

1. The system informs the Buyer that no Products match the search.
2. The Buyer changes the search criteria.
3. Use case continues at step 1.

### A2: No Applicable Contract Price

**Trigger:** No Contract price is effective for the Product and the Buyer's Business customer (step 4)  
**Flow:**

1. The system indicates that no Contract price is available for the Product.
2. The Buyer reviews the other available Product information.
3. Use case continues at step 5.

### A3: Stock Information Unavailable

**Trigger:** No Stock quantity is available in the portal's copy (step 4)  
**Flow:**

1. The system indicates that Stock information is unavailable.
2. The Buyer reviews the other available Product information.
3. Use case continues at step 5.

### A4: Product Catalog Unavailable

**Trigger:** No Product catalog data is available in the portal (step 2)  
**Flow:**

1. The system informs the Buyer that the catalog is unavailable.
2. Use case ends.

### A5: No Product Meets the Buyer's Need

**Trigger:** The Buyer finds no Product of interest in the displayed information (step 5)  
**Flow:**

1. The Buyer decides not to continue browsing.
2. Use case ends.

### A6: A Data Item Is Updated While the Buyer Is Browsing

**Trigger:** A portal copy is updated while the system is preparing the Product details (step 4)  
**Flow:**

1. The system displays each value with the synchronization time belonging to that value.
2. Use case continues at step 5.

## Postconditions

### Success Postconditions

- The Buyer has reviewed available Product details, any available Contract price and Stock information for Products of interest, and the recorded synchronization times. The Buyer is told when a Contract price or Stock value is unavailable.
- No Order or Quote request is created by browsing.

### Failure Postconditions

- No Order or Quote request is created by browsing.
- Existing Product, Contract price, and Stock information is not changed by browsing.

## Business Rules

### BR-001: Customer-Specific Effective Contract Price

The system displays only a Contract price belonging to the Buyer's Business customer that is effective on the current date. The effective start and end dates are inclusive. If no Contract price is effective, the system indicates that no price is available and does not substitute a list price, as required by C-004.

### BR-002: Show the Portal's Latest Available Data and Its Age

Product details, Contract prices, and Stock are shown from the latest available copies held by the portal. Each displayed value is accompanied by the synchronization time belonging to that value; a refresh in progress does not cause a value to be shown with another value's timestamp. The portal synchronizes data at least once every 60 minutes while the corresponding source system is available, as required by NFR-001. Browsing remains available when the PIM or ERP is unavailable, as required by C-003.
