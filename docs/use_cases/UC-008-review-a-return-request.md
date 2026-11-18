# Use Case: Review a Return Request

## Overview

**Use Case ID:** UC-008  
**Use Case Name:** Review a Return Request  
**Primary Actor:** Customer Service  
**Goal:** Customer Service decides whether a Buyer's Return request is approved or rejected.  
**Trigger:** A Customer Service representative requests to review a Return request.  
**Status:** Draft  

**Requirements:** [FR-009](../requirements.md)

## Preconditions

- A Return request is awaiting review.

## Main Success Scenario

1. Customer Service selects a Return request awaiting review.
2. The system displays the related order, requested Products and quantities, and Buyer.
3. Customer Service approves or rejects the Return request.
4. The system records the decision and updates the Return request status.
5. The system confirms the decision to Customer Service.

## Alternative Flows

### A1: Return Request Is No Longer Awaiting Review

**Trigger:** The selected Return request is no longer awaiting review (step 2)  
**Flow:**

1. The system informs Customer Service that no decision can be recorded for the request.
2. Use case ends.

### A2: Customer Service Cancels the Review

**Trigger:** Customer Service decides not to make a decision (step 3)  
**Flow:**

1. Customer Service leaves the request without approving or rejecting it.
2. Use case ends.

## Postconditions

### Success Postconditions

- The Return request has one recorded decision and its status reflects that decision.

### Failure Postconditions

- No decision is recorded when the use case ends without a decision.
- An existing decision is not overwritten.

## Business Rules

### BR-001: One Decision Per Return Request

A Return request awaiting review may receive one decision. Once approved or rejected, it is no longer available for another decision.

### BR-002: Approval Does Not Complete a Physical Return

Approving a Return request records the decision; it does not by itself record receipt of returned Products or completion of any refund.
