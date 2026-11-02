-- Weekly programme for AliciaFitX, shared so other apps (e.g. North Star) can read it.
-- Run once in the Supabase dashboard → SQL Editor.
-- The app fills and updates this table itself from PROGRAM in index.html every time
-- it opens; PROGRAM stays the source of truth, so never edit these rows by hand.
--
-- One row per day, Monday first (position 0 = mon … 6 = sun).
-- exercises: [{ name, type, equipment, sets, reps, rest, metric, key, note, interval }]
-- warmup:    [{ name, reps }]

create table if not exists public.program_days (
  day_key    text primary key,          -- mon … sun
  position   int  not null,
  day_name   text not null,
  focus      text not null,
  is_rest    boolean not null default false,
  warmup     jsonb not null default '[]',
  exercises  jsonb not null default '[]',
  updated_at timestamptz not null default now()
);

-- Same access model as the app's other tables (the app uses the anon key).
alter table public.program_days enable row level security;

drop policy if exists "program_days anon access" on public.program_days;
create policy "program_days anon access" on public.program_days
  for all to anon using (true) with check (true);
