# Use Case: Request a Product Return

## Overview

**Use Case ID:** UC-007  
**Use Case Name:** Request a Product Return  
**Primary Actor:** Buyer  
**Secondary Actors:** Customer Service  
**Goal:** The Buyer submits a request to return quantities of Products from an order.  
**Trigger:** The Buyer requests to return Products from an order.  
**Status:** Draft  

**Requirements:** [FR-008](../requirements.md)

## Preconditions

- The Buyer has an active portal account associated with a Business customer.
- The Business customer has an order containing at least one Product.

## Main Success Scenario

1. The Buyer selects an order from their Business customer's order history.
2. The system displays the Products and ordered quantities.
3. The Buyer selects one or more order lines and specifies a return quantity for each.
4. The Buyer submits the Return request.
5. The system records the Return request and makes it available to Customer Service.
6. The system confirms submission to the Buyer.

## Alternative Flows

### A1: Order Does Not Belong to the Buyer's Business Customer

**Trigger:** The selected order is not associated with the Buyer's Business customer (step 2)  
**Flow:**

1. The system does not display the order details and informs the Buyer that the order is unavailable.
2. Use case ends.

### A2: Return Quantity Exceeds the Remaining Ordered Quantity

**Trigger:** A requested return quantity exceeds the quantity that may still be returned for an order line (step 4)  
**Flow:**

1. The system identifies the order line and quantity that must be corrected.
2. The Buyer changes the return quantities.
3. Use case continues at step 3.

### A3: Buyer Cancels the Return Request

**Trigger:** The Buyer decides not to submit the Return request (step 4)  
**Flow:**

1. The Buyer cancels the request.
2. Use case ends.

## Postconditions

### Success Postconditions

- A Return request for the selected order lines and quantities is recorded for Customer Service to review.

### Failure Postconditions

- No incomplete Return request is recorded as submitted.
- The total quantity requested for return does not exceed the quantity ordered for any order line.

## Business Rules

### BR-001: Return Request Ownership

A Buyer may request a return only for an order belonging to the Buyer's Business customer.

### BR-002: Return Quantity Limit

The sum of quantities in Requested, Approved, or Completed Return requests for an order line must not exceed the quantity ordered on that line. Rejected or Cancelled requests do not count toward this limit.

### BR-003: Return Eligibility Is Not Otherwise Defined

The requirements do not define a return window or Product eligibility policy. This use case enforces the cumulative quantity limit but does not infer additional eligibility rules.
