# Use Case: Place an Order

## Overview

**Use Case ID:** UC-002  
**Use Case Name:** Place an Order  
**Primary Actor:** Buyer  
**Secondary Actors:** ERP  
**Goal:** The Buyer submits a purchase order for products and receives confirmation of its status.  
**Trigger:** The Buyer requests to place an order.  
**Status:** Draft  

**Requirements:** [FR-002, FR-003, FR-004, FR-012, C-002, C-003](../requirements.md)

## Preconditions

- The Buyer has an active portal account associated with a Business customer.
- An Approval limit is configured for the Business customer when its orders require approval.

## Main Success Scenario

1. The Buyer selects one or more Products and specifies a quantity for each.
2. The system displays the selected Products, their applicable Contract prices, the latest available Stock quantities, and the order total.
3. The Buyer reviews the order and submits it.
4. The system determines whether the order total is above the Business customer's Approval limit.
5. The system records the order as submitted.
6. The ERP accepts the order.
7. The system confirms the order and its status to the Buyer.

## Alternative Flows

### A1: Order Requires Approval

**Trigger:** The order total is above the Business customer's Approval limit (step 4)  
**Flow:**

1. The system records the order as awaiting approval and does not send it to the ERP.
2. The system informs the Buyer that approval is required.
3. Use case continues at step 7.

### A2: ERP Is Unavailable

**Trigger:** The ERP cannot accept the submitted order (step 6)  
**Flow:**

1. The system retains the submitted order for transfer when the ERP is available.
2. The system informs the Buyer that the order is queued for transfer.
3. Use case continues at step 7.

### A3: Buyer Cancels Before Submission

**Trigger:** The Buyer decides not to submit the order (step 3)  
**Flow:**

1. The Buyer cancels the order.
2. Use case ends.

## Postconditions

### Success Postconditions

- The submitted order and its status are recorded for the Business customer.
- An order above the Approval limit awaits a Purchasing Manager's decision; an order not requiring approval is either accepted by the ERP or retained for transfer.

### Failure Postconditions

- No partially submitted order is presented as successfully placed.
- No order is transferred to the ERP more than once.

## Business Rules

### BR-001: Approval Requirement

An order whose total is above the Business customer's Approval limit requires a Purchasing Manager's approval before it is sent to the ERP. An order equal to the Approval limit does not exceed it.

If no Approval limit is configured, this use case does not infer an approval requirement.

### BR-002: Retain Orders During ERP Outages

The portal retains an order that is ready for ERP transfer when the ERP is unavailable and transfers it when the ERP becomes available, without losing or transferring the order more than once, as required by FR-012.

### BR-003: Use the Portal's Available Commercial Data

The system uses the latest Contract price and Stock information available in the portal when the Buyer submits the order. The displayed Stock quantity is informational and does not guarantee that the ERP will fulfill the order.
