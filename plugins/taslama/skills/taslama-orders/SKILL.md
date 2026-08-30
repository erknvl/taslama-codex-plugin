---
name: taslama-orders
description: Review and operate orders, payments, refunds, discounts, promotions, and inventory in one commerce-enabled Taslama project through admin WebMCP or available remote MCP reads.
---

# Taslama Orders

Work only in the project already selected by the authenticated Taslama session. Start with `taslama_admin_context` when browser WebMCP is available. Commerce tools must be absent unless project commerce mode is `order-request`; absence is a stop condition, not permission to bypass the feature gate.

## Read before changing

1. Find the exact order and read its order, fulfillment, payment, item, stock, delivery-fee, and TMT total state.
2. Use an order ID returned by the selected project. Never infer an ID from another project or from an order number without resolving it first.
3. Show the current state and exact proposed action. Confirmation is required unless the user's current instruction already unambiguously confirms the same order, action, amounts, and reasons.

## Guarded operations

- Use `taslama_transition_order` for status changes. Never patch status fields directly.
- `reject` and `cancel` require a meaningful reason. Confirming delivery may require final `deliveryFeeMinorTMT`.
- Completing an order requires collected payment according to server rules. Do not invent state transitions when the server rejects one.
- Use payment and refund tools only for cash or a physical terminal. Amounts are integer TMT minor units; there is no online card processing.
- A refund requires a reason and cannot exceed net collected value. Payments and refunds are append-only ledger records with server-side idempotency.
- Use `taslama_set_order_discount` only on an active order with a reason, then read the recalculated total.
- Use `taslama_adjust_inventory` only for an explicit non-zero delta and reason. Never adjust stock merely to make an invalid confirmation pass.

After every write, re-read the order or product and report resulting statuses, TMT amounts, and stock. Stop on permission, tenant, feature, invalid-state, insufficient-stock, or fee-confirmation errors; do not retry through broader tools or direct REST.
