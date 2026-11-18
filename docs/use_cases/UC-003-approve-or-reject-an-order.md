# Use Case: Approve or Reject an Order

## Overview

**Use Case ID:** UC-003  
**Use Case Name:** Approve or Reject an Order  
**Primary Actor:** Purchasing Manager  
**Goal:** The Purchasing Manager decides whether an order that requires approval may proceed.  
**Trigger:** The Purchasing Manager requests to review an order awaiting approval.  
**Status:** Draft  

**Requirements:** [FR-004](../requirements.md)

## Preconditions

- The Purchasing Manager has an active portal account associated with a Business customer.
- An order for that Business customer is awaiting approval.

## Main Success Scenario

1. The Purchasing Manager selects an order awaiting approval.
2. The system displays the order details, total, and Buyer who submitted it.
3. The Purchasing Manager approves or rejects the order.
4. The system records the decision and updates the order status.
5. The system confirms the decision to the Purchasing Manager.

## Alternative Flows

### A1: Order Is No Longer Awaiting Approval

**Trigger:** The selected order is no longer awaiting approval (step 2)  
**Flow:**

1. The system informs the Purchasing Manager that no decision can be recorded for the order.
2. Use case ends.

### A2: Purchasing Manager Cancels the Review

**Trigger:** The Purchasing Manager decides not to make a decision (step 3)  
**Flow:**

1. The Purchasing Manager leaves the order without approving or rejecting it.
2. Use case ends.

## Postconditions

### Success Postconditions

- The order has one recorded decision by a Purchasing Manager of the same Business customer.
- An approved order may proceed to ERP transfer; a rejected order does not proceed to ERP transfer.

### Failure Postconditions

- No approval decision is recorded when the use case ends without a decision.
- The order's existing decision and status are not overwritten.

## Business Rules

### BR-001: Customer-Specific Decision Authority

Only a Purchasing Manager associated with the Business customer that placed the order may decide on that order.

### BR-002: One Decision Per Order

An order awaiting approval may receive one decision. Once approved or rejected, it is no longer available for another decision.
