# Use Case: Find Product

## Overview

**Use Case ID:** UC-001  
**Use Case Name:** Find Product  
**Primary Actor:** Buyer  
**Goal:** Find the Products that match a search so that the Buyer can choose one to view or order  
**Trigger:** Buyer requests a product search  
**Status:** Approved  

**Requirements:** [FR-001, FR-003, FR-012, C-001, C-002, C-003, C-004](../requirements.md)

## Preconditions

- Buyer is signed in to the portal as an active Buyer of a Business Customer
- The portal holds a copy of the Product data, Contract Prices, and Stock

## Main Success Scenario

1. Buyer opens the product search.
2. Buyer enters a search term.
3. System finds the Products that match the search term according to BR-002.
4. System displays the matching Products ordered according to BR-006, each with name, product number, first image (BR-007), the Contract Price of the Buyer's Business Customer, and Stock.
5. Buyer selects a Product from the result list to view its details (UC-002).

## Alternative Flows

### A1: Search Term Too Short

**Trigger:** The search term has fewer characters than BR-001 requires (step 2)  
**Flow:**

1. System informs the Buyer of the minimum length of the search term.
2. Use case continues at step 2.

### A2: No Matching Products

**Trigger:** No Product matches the search term (step 3)  
**Flow:**

1. System informs the Buyer that no Product matches the search term.
2. Buyer enters a different search term or leaves the search.
3. Use case continues at step 2, or Use case ends.

### A3: Product Without Contract Price

**Trigger:** A matching Product has no Contract Price for the Buyer's Business Customer (step 4)  
**Flow:**

1. System displays the Product in the result list marked as having no Contract Price.
2. Use case continues at step 5.

### A4: Buyer Does Not Select a Product

**Trigger:** None of the displayed Products is what the Buyer needs (step 5)  
**Flow:**

1. Buyer refines the search term or leaves the search.
2. Use case continues at step 2, or Use case ends.

## Postconditions

### Success Postconditions

- Buyer has selected a Product that matches the search term
- The Contract Price and Stock shown are those of the portal's latest copy for the Buyer's Business Customer

### Failure Postconditions

- No Product data, Contract Price, or Stock is changed by the search
- No Contract Price of another Business Customer is shown to the Buyer

## Business Rules

### BR-001: Minimum Search Term Length

A search term must contain at least 2 characters.

### BR-002: Search Fields

The search term is split into words at spaces. A Product matches when every word of the search term occurs, ignoring upper and lower case, in its name, its description, or its product number; the words may occur in any order and each word in a different one of these fields.

### BR-003: Own Contract Prices Only

The result list shows only the Contract Price of the Buyer's own Business Customer.

### BR-004: Products Without Contract Price Remain Visible

A Product without a Contract Price for the Buyer's Business Customer is listed and marked as having no Contract Price, so that the Buyer can request a quote for it (UC-006).

### BR-005: Search Uses the Portal's Copy

The search and the result list use the portal's hourly copy of Product data, Contract Prices, and Stock; the search works when the PIM or the ERP is unavailable.

### BR-006: Result Order

The result list is ordered by product name in ascending alphabetical order.

### BR-007: Products Without Image

A Product without an image is listed without an image.
