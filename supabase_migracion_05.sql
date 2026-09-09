-- Panel Purexis — Migración 05
-- Posibles clientes: los que preguntaron por ese reel y no compraron.
-- Separa "el reel no generó interés" de "el reel funcionó y se cayó el cierre",
-- que son dos problemas distintos y se arreglan en lugares distintos.
-- Pegar en: Supabase Studio -> SQL Editor -> New query -> Run

alter table contenido add column if not exists posibles_clientes integer default 0;
