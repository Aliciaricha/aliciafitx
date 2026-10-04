-- Per-exercise notes and gym settings for AliciaFitX.
-- Run once in the Supabase dashboard → SQL Editor.
-- Until it exists, the app keeps notes on the device (localStorage) only;
-- after it exists, notes sync across devices and anything saved locally is uploaded.

create table if not exists public.exercise_notes (
  exercise    text primary key,
  notes       text not null default '',
  settings    text not null default '',
  updated_at  timestamptz not null default now()
);

-- Same access model as the app's other tables (the app uses the anon key).
alter table public.exercise_notes enable row level security;

drop policy if exists "exercise_notes anon access" on public.exercise_notes;
create policy "exercise_notes anon access" on public.exercise_notes
  for all to anon using (true) with check (true);
