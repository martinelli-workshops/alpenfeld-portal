# Vision: Alpenfeld B2B Ordering Portal

Alpenfeld Supply is a mid-sized distributor of tools, fasteners and workshop supplies.
About 1,200 business customers order from us: craft businesses, industrial workshops
and facility managers. Today they order by phone, email and an old web shop that only
shows list prices.

We want a new B2B ordering portal. Customers find products, see their own contract prices,
and order online. Larger customers want control over what their employees buy, so orders 
above a limit need the approval of a purchasing manager of the customer. Our sales team 
wants to answer quote requests for large quantities directly in the portal. 
Returns should no longer need a phone call.

Product data comes from our PIM. Contract prices, stock and order processing stay in
our ERP. The portal must not depend on these systems being available: it keeps its own
copy of the product data from the PIM and of the contract prices and stock from the ERP,
so customers can search, see their prices and order even when the PIM or the ERP is down.
This data does not change often, so updating the copy every hour is enough. Orders placed
while the ERP is down are kept in the portal and transferred to the ERP as soon as it is
available again, without getting lost or transferred twice.

## Actors

- Buyer (an employee of a business customer who places orders)
- Purchasing Manager (approves orders and manages the buyers of their company)
- Sales Representative (answers quote requests and looks after key accounts)
- Customer Service (handles returns and helps customers with their orders)

## External Systems

- ERP (contract prices, stock, order processing, invoices)
- PIM (product data and images)
