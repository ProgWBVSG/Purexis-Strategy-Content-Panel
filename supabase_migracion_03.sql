-- Panel Purexis — Migración 03
-- Link al video publicado, para poder abrirlo desde el panel.
-- Pegar entero en: Supabase Studio -> SQL Editor -> New query -> Run
-- Aditiva e idempotente: no toca ni borra datos existentes.

alter table contenido add column if not exists url text;
