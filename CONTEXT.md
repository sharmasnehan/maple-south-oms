# Maple South — Coffee Popup Order System

## What this is
Two-page static site for a coffee/bakery popup. No build step, no framework, no npm.

## Files
- `index.html` — customer-facing order form (mobile)
- `dashboard.html` — barista iPad dashboard with live orders + analytics
- `config.js` — Supabase URL + anon key (shared by both pages)

## Stack
- Vanilla HTML/CSS/JS (plus `config.js` for Supabase credentials)
- Supabase for database + real-time subscriptions via CDN
- Google Fonts via CDN (Yellowtail + Nunito + DM Mono)
- GitHub Pages for hosting

## Supabase
- Credentials: edit `config.js` (Project Settings → API in [Supabase dashboard](https://supabase.com/dashboard))
- SQL bootstrap: `supabase/migrations/001_orders.sql` (run in SQL Editor)
- Table: `orders`
  - `id` uuid, `created_at` timestamptz, `customer_name` text
  - `items` jsonb — array of `{ name, qty, price }`
  - `notes` text (nullable), `total` numeric, `status` text (`pending` | `done`)
- Real-time enabled on the orders table

## Design
- Colors: cream background (#FAF7F2), forest green (#1D7A2F), yellow (#F5C800)
- Fonts: Yellowtail (display/headings), Nunito (body), DM Mono (numbers)
- Customer page: playful, chunky offset shadows, card-based menu grid
- Dashboard: clean light theme, tab-based (Active / Done / Analytics)

## Dashboard features
- Active tab: incoming orders with "Mark Done ✓" button
- Done tab: completed orders with Undo
- Analytics tab: completed order stats — items sold, revenue, per-item breakdown
- Persistent bottom bar chart (canvas): live item counts across all orders, animated
- Real-time updates via Supabase channel subscription

## Menu
Defined in the `MENU` object near the top of `index.html`.
Each item: `{ id, name, desc, price, emoji }`
Two categories: `drinks` and `food`.

## Important: keep in sync
`DRINK_NAMES` set in `dashboard.html` must match drink names in `index.html` MENU.
Used to categorize items in analytics and the bar chart.
