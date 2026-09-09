-- Panel Purexis — Migración 04
-- Las cuatro señales que Instagram usa para rankear y que no estábamos midiendo.
-- Pegar entero en: Supabase Studio -> SQL Editor -> New query -> Run
-- Aditiva e idempotente: no toca ni borra nada de lo que ya hay.

-- Impresiones: el denominador de la tasa de gancho (vistas ÷ impresiones).
alter table contenido add column if not exists impresiones integer default 0;

-- Duración del reel en segundos: sin esto no se puede calcular retención.
alter table contenido add column if not exists duracion_seg integer default 0;

-- Tiempo medio de visualización en segundos. Es el factor N.º 1 de ranking.
alter table contenido add column if not exists tiempo_medio_seg numeric default 0;

-- Envíos por mensaje directo, separados de compartidos.
-- Instagram los pesa entre 3 y 5 veces más que un like.
alter table contenido add column if not exists envios integer default 0;
