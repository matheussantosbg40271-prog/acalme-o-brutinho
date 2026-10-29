-- Execute no SQL Editor do seu projeto Supabase.
create table if not exists public.game_analytics (
  id bigint generated always as identity primary key,
  event_name text not null check (event_name in ('page_view','screen_view','game_start','game_session_end','session_pause','session_end','game_heartbeat')),
  visitor_id text not null,
  session_id text not null,
  properties jsonb not null default '{}'::jsonb,
  occurred_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);
create index if not exists game_analytics_occurred_at_idx on public.game_analytics (occurred_at desc);
create index if not exists game_analytics_event_idx on public.game_analytics (event_name);
create index if not exists game_analytics_session_idx on public.game_analytics (session_id);
alter table public.game_analytics enable row level security;
-- Não crie políticas públicas de leitura/escrita. A API Vercel usa a service role key apenas no servidor.
revoke all on public.game_analytics from anon, authenticated;
