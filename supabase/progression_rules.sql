-- Progression rules for AliciaFitX, shared so other apps (e.g. North Star) can
-- predict loads exactly as the app's "Today's Target" does.
-- Run once in the Supabase dashboard → SQL Editor.
-- The app fills and updates this table itself from PROGRESSION_RULES in
-- index.html every time it opens; PROGRESSION_RULES stays the source of truth,
-- so never edit these rows by hand.
--
-- mode:       'weight'            add `inc` kg every session
--             'weight-after-reps' add `inc` kg once every working set hits `rep_target`
--             'reps'              add `inc` reps every session
create table if not exists public.progression_rules (
  exercise   text primary key,
  mode       text not null,
  inc        numeric not null,
  rep_target int,
  updated_at timestamptz not null default now()
);

-- Same access model as the app's other tables (the app uses the anon key).
alter table public.progression_rules enable row level security;

drop policy if exists "progression_rules anon access" on public.progression_rules;
create policy "progression_rules anon access" on public.progression_rules
  for all to anon using (true) with check (true);
