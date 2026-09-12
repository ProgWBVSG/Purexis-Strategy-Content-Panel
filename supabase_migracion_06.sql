-- Panel Purexis — Migración 06
-- La Guía: capítulos editables con archivos adjuntos (fotos, videos, anuncios de
-- la competencia, referencias). Pegar en: Supabase Studio -> SQL Editor -> Run.

create table if not exists guia (
  id           text primary key,
  capitulo     text not null,
  orden        integer default 0,
  titulo       text not null default '',
  contenido    text default '',
  adjuntos     jsonb default '[]'::jsonb,   -- [{url, nombre, tipo, nota}]
  actualizado  timestamptz default now()
);

alter table guia enable row level security;
create policy "anon_all_guia" on guia for all using (true) with check (true);
alter publication supabase_realtime add table guia;

-- Bucket público para los archivos de la guía (fotos, videos, PDFs).
insert into storage.buckets (id, name, public)
values ('guia', 'guia', true)
on conflict (id) do nothing;

create policy "guia_leer"   on storage.objects for select using (bucket_id = 'guia');
create policy "guia_subir"  on storage.objects for insert with check (bucket_id = 'guia');
create policy "guia_borrar" on storage.objects for delete using (bucket_id = 'guia');
