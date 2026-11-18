# Use Case: Prepare a Quote Response

## Overview

**Use Case ID:** UC-006  
**Use Case Name:** Prepare a Quote Response  
**Primary Actor:** Sales Representative  
**Goal:** The Sales Representative prepares a priced response for a Buyer's Quote request.  
**Trigger:** The Sales Representative requests to prepare a response to a Quote request.  
**Status:** Draft  

**Requirements:** [FR-007](../requirements.md)

## Preconditions

- A Quote request is available for a Sales Representative to review.

## Main Success Scenario

1. The Sales Representative selects a Quote request.
2. The system displays the requested Products, quantities, and Business customer.
3. The Sales Representative enters a quoted quantity and price for each requested Product and provides any validity date that applies.
4. The Sales Representative submits the Quote response.
5. The system records the Quote and makes it available to the Buyer in the portal.
6. The system confirms that the Quote response is available.

## Alternative Flows

### A1: Quote Request Has Already Been Answered or Cancelled

**Trigger:** The selected Quote request is no longer available for a response (step 2)  
**Flow:**

1. The system informs the Sales Representative that the request cannot be answered.
2. Use case ends.

### A2: Quote Response Is Incomplete

**Trigger:** The Quote response is missing a quantity or price for a requested Product (step 4)  
**Flow:**

1. The system identifies the missing response details.
2. The Sales Representative completes the response.
3. Use case continues at step 4.

### A3: Sales Representative Cancels the Response

**Trigger:** The Sales Representative decides not to submit the Quote response (step 4)  
**Flow:**

1. The Sales Representative cancels the response.
2. Use case ends.

## Postconditions

### Success Postconditions

- One Quote response containing the Sales Representative's prices and quantities is available to the Buyer.

### Failure Postconditions

- An incomplete or cancelled Quote response is not presented to the Buyer as a completed Quote.
- An existing Quote response is not overwritten by an unsuccessful attempt.

## Business Rules

### BR-001: Quote Response Contents

A Quote response states a price for each Product and the quantity to which that price applies. A validity date is included only when one applies.

### BR-002: One Response Per Request

A Quote request receives no more than one completed Quote response.
