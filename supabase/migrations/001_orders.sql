-- Maple South OMS — run once in Supabase SQL Editor (Dashboard → SQL → New query)

-- Orders table (matches index.html insert + dashboard.html select/update/realtime)
create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  customer_name text not null,
  items jsonb not null default '[]'::jsonb,
  notes text,
  total numeric not null,
  status text not null default 'pending',
  constraint orders_status_check check (status in ('pending', 'done'))
);

create index if not exists orders_created_at_idx on public.orders (created_at);

-- Row Level Security (anon key = customer + barista dashboard)
alter table public.orders enable row level security;

drop policy if exists "orders_select_anon" on public.orders;
drop policy if exists "orders_insert_anon" on public.orders;
drop policy if exists "orders_update_anon" on public.orders;

create policy "orders_select_anon"
  on public.orders for select
  to anon
  using (true);

create policy "orders_insert_anon"
  on public.orders for insert
  to anon
  with check (true);

create policy "orders_update_anon"
  on public.orders for update
  to anon
  using (true)
  with check (true);

-- Realtime: dashboard subscribes to postgres_changes on public.orders
-- (If this errors with "already member", the table is already in the publication — skip.)
alter publication supabase_realtime add table public.orders;
