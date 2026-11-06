# Use Case: View Product Details

## Overview

**Use Case ID:** UC-002  
**Use Case Name:** View Product Details  
**Primary Actor:** Buyer  
**Goal:** See the details, images, Contract Price, and Stock of a Product so that the Buyer can decide whether to order it  
**Trigger:** Buyer requests the details of a Product  
**Status:** Approved  

**Requirements:** [FR-002, FR-003, FR-012, C-001, C-002, C-003, C-004](../requirements.md)

## Preconditions

- Buyer is signed in to the portal as an active Buyer of a Business Customer
- The portal holds a copy of the Product data, Contract Prices, and Stock

## Main Success Scenario

1. Buyer selects a Product, for example from the result list of the product search (UC-001).
2. System retrieves the Product from the portal's copy (BR-001).
3. System displays the Product's name, product number, and description.
4. System displays the Product's images in the order given by the PIM (BR-002).
5. System displays the Contract Price of the Buyer's Business Customer and the Stock of the Product, each with the time of the portal's latest copy (BR-004).
6. Buyer reviews the details to decide whether to order the Product.

## Alternative Flows

### A1: Product No Longer Available

**Trigger:** The selected Product is no longer in the portal's copy (step 2)  
**Flow:**

1. System informs the Buyer that the Product is no longer available.
2. Use case ends.

### A2: Product Without Description

**Trigger:** The Product has no description (step 3)  
**Flow:**

1. System displays the Product without a description.
2. Use case continues at step 4.

### A3: Product Without Image

**Trigger:** The Product has no image (step 4)  
**Flow:**

1. System displays the Product without an image (BR-003).
2. Use case continues at step 5.

### A4: Product Without Contract Price

**Trigger:** The Product has no Contract Price for the Buyer's Business Customer and its Stock is not zero (step 5)

**Flow:**

1. System marks the Product as having no Contract Price and offers the Buyer to request a quote (UC-006) (BR-005).
2. System displays the Stock of the Product with the time of the portal's latest copy.
3. Use case continues at step 6.

### A5: Product Out of Stock

**Trigger:** The Stock of the Product is zero and it has a Contract Price for the Buyer's Business Customer (step 5)

**Flow:**

1. System displays the Product as out of stock with its Contract Price, each with the time of the portal's latest copy (BR-006).
2. Use case continues at step 6.

### A6: Product Without Contract Price and Out of Stock

**Trigger:** The Product has no Contract Price for the Buyer's Business Customer and its Stock is zero (step 5)

**Flow:**

1. System marks the Product as having no Contract Price and offers the Buyer to request a quote (UC-006) (BR-005).
2. System displays the Product as out of stock with the time of the portal's latest Stock copy (BR-006).
3. Use case continues at step 6.

## Postconditions

### Success Postconditions

- Buyer has seen the details, images, Contract Price, and Stock of the selected Product
- The Contract Price and Stock shown are those of the portal's latest copy for the Buyer's Business Customer, together with the time of that copy

### Failure Postconditions

- No Product data, Contract Price, or Stock is changed by viewing the Product
- No Contract Price of another Business Customer is shown to the Buyer

## Business Rules

### BR-001: Details Use the Portal's Copy

The details, images, Contract Price, and Stock are taken from the portal's hourly copy of Product data, Contract Prices, and Stock; the details can be viewed when the PIM or the ERP is unavailable.

### BR-002: Image Order

The images of a Product are shown in the order given by the PIM; the first image is the one the product search shows (UC-001 BR-007).

### BR-003: Products Without Image

A Product without an image is shown without an image.

### BR-004: Own Contract Price Only

The details show only the Contract Price of the Buyer's own Business Customer, together with the time the Contract Price and the Stock were last copied from the ERP.

### BR-005: Products Without Contract Price

A Product without a Contract Price for the Buyer's Business Customer is shown marked as having no Contract Price, and the Buyer is offered to request a quote for it (UC-006).

### BR-006: Out of Stock

A Product whose Stock is zero is shown as out of stock. Whether such a Product can be ordered is decided in Place Order (UC-003).
