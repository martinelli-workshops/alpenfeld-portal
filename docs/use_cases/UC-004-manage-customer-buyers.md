# Use Case: Manage Customer Buyers

## Overview

**Use Case ID:** UC-004  
**Use Case Name:** Manage Customer Buyers  
**Primary Actor:** Purchasing Manager  
**Goal:** The Purchasing Manager creates, updates, or deactivates Buyer accounts for their Business customer.  
**Trigger:** The Purchasing Manager requests to manage a Buyer account.  
**Status:** Draft  

**Requirements:** [FR-005](../requirements.md)

## Preconditions

- The Purchasing Manager has an active portal account associated with a Business customer.

## Main Success Scenario

1. The Purchasing Manager chooses to create, update, or deactivate a Buyer account.
2. The system presents the information needed for the selected action.
3. The Purchasing Manager enters or changes the Buyer's account information, or confirms the deactivation.
4. The system applies the requested change to a Buyer account associated with the Purchasing Manager's Business customer.
5. The system confirms the result to the Purchasing Manager.

## Alternative Flows

### A1: Purchasing Manager Cancels the Change

**Trigger:** The Purchasing Manager decides not to apply the change (step 3)  
**Flow:**

1. The Purchasing Manager cancels the change.
2. Use case ends.

### A2: Buyer Information Is Incomplete or Invalid

**Trigger:** The system cannot accept the provided Buyer information (step 4)  
**Flow:**

1. The system identifies the information that must be corrected.
2. The Purchasing Manager corrects the information.
3. Use case continues at step 4.

### A3: Buyer Account Does Not Belong to This Business Customer

**Trigger:** The selected Buyer account is not associated with the Purchasing Manager's Business customer (step 4)  
**Flow:**

1. The system does not apply the change and informs the Purchasing Manager that the account is unavailable.
2. Use case ends.

## Postconditions

### Success Postconditions

- The requested Buyer account change has been applied only to a Buyer account belonging to the Purchasing Manager's Business customer.

### Failure Postconditions

- No Buyer account belonging to another Business customer is changed.
- A cancelled or unsuccessful change does not leave a partially updated Buyer account.

## Business Rules

### BR-001: Customer-Specific Buyer Management

A Purchasing Manager may create, update, or deactivate Buyer accounts only for their own Business customer.

### BR-002: Deactivation Preserves Order History

Deactivating a Buyer account prevents the account from being used as an active Buyer but does not remove existing orders or their history.
