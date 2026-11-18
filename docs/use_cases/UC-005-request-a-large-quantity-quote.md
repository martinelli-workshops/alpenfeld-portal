# Use Case: Request a Large-Quantity Quote

## Overview

**Use Case ID:** UC-005  
**Use Case Name:** Request a Large-Quantity Quote  
**Primary Actor:** Buyer  
**Secondary Actors:** Sales Representative  
**Goal:** The Buyer submits a request for pricing on one or more large-quantity Product purchases.  
**Trigger:** The Buyer requests pricing for a large quantity of Products.  
**Status:** Draft  

**Requirements:** [FR-006](../requirements.md)

## Preconditions

- The Buyer has an active portal account associated with a Business customer.

## Main Success Scenario

1. The Buyer selects one or more Products and specifies the quantity for each.
2. The system displays the selected Products and requested quantities.
3. The Buyer submits the quote request.
4. The system records the Quote request for the Buyer's Business customer.
5. The system makes the Quote request available to a Sales Representative and confirms submission to the Buyer.

## Alternative Flows

### A1: Buyer Cancels the Quote Request

**Trigger:** The Buyer decides not to submit the Quote request (step 3)  
**Flow:**

1. The Buyer cancels the request.
2. Use case ends.

### A2: Quote Request Has No Products or Valid Quantities

**Trigger:** The request does not contain at least one Product with a positive quantity (step 3)  
**Flow:**

1. The system identifies the missing or invalid request details.
2. The Buyer corrects the Product selection or quantities.
3. Use case continues at step 2.

## Postconditions

### Success Postconditions

- A Quote request containing the requested Products and quantities is recorded for the Buyer's Business customer and is available for a Sales Representative to review.

### Failure Postconditions

- No incomplete Quote request is recorded as submitted.

## Business Rules

### BR-001: Quote Request Ownership

A Quote request is associated with the Business customer of the Buyer who submits it.

### BR-002: No Unspecified Quantity Threshold

The requirements do not define a numeric threshold for a large quantity. This use case records the quantities supplied by the Buyer without applying an undisclosed threshold.
