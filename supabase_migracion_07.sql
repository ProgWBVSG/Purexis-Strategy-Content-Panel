-- Panel Purexis — Migración 07
-- Producción: la reserva de superficies sucias (el cuello de botella real) y
-- las metas semanales de ritmo. Pegar en Supabase Studio -> SQL Editor -> Run.

create table if not exists backlog (
  id         text primary key,
  titulo     text not null default '',        -- la superficie o la idea
  clase      text default 'superficie',       -- superficie | idea
  producto   text default 'general',
  pieza      text default 'venta',            -- venta | valor | carrusel | historia
  origen     text default 'casa',             -- casa | familiar | cliente | comercio
  estado     text default 'disponible',       -- disponible | reservada | usada | descartada
  prioridad  integer default 2,               -- 1 alta · 2 media · 3 baja
  nota       text default '',
  sesion     date,                            -- para qué sesión quedó reservada
  creado     timestamptz default now()
);

alter table backlog enable row level security;
create policy "anon_all_backlog" on backlog for all using (true) with check (true);
alter publication supabase_realtime add table backlog;

-- Metas de ritmo semanal, editables desde el panel.
alter table config add column if not exists produccion jsonb default '{}'::jsonb;
