# Panel Purexis

Portal de control interno de Purexis: organización de contenido, metas financieras y de contenido, ventas por producto (Quita Sarro, Quita Moho, Quita Óxido, Limpia Vidrios), métricas orgánico vs. anuncios, y reportes rodantes de 4 semanas.

## Stack

- HTML/CSS/JS puro, un solo archivo (`index.html`).
- Motor de datos: [sql.js](https://sql.js.org/) (SQLite compilado a WebAssembly), corre 100% en el navegador — no requiere backend para funcionar.
- Tipografía: Montserrat.

## Deploy

Sitio estático, sin build. En Vercel: importar este repo, sin configuración adicional (framework preset "Other").

## Base de datos

Postgres real en [Supabase](https://supabase.com), consultado directo desde el navegador con la key `publishable` (segura para exponer client-side — la protección la da Row Level Security en Postgres, no ocultar la key). Sin login: cualquiera con el link lee y escribe (decisión tomada a propósito para simplificar). Sincroniza entre todos los dispositivos en vivo vía Supabase Realtime.

**Setup inicial (una sola vez):** pegar el contenido de [`supabase_schema.sql`](supabase_schema.sql) en el SQL Editor del proyecto de Supabase y ejecutarlo. Crea las tablas (`contenido`, `metas`, `config`, `precios_meli`), las policies de RLS y habilita Realtime.

## Precios sincronizados con Mercado Libre

Una tarea programada de Claude lee el precio vigente de las 4 publicaciones (Mercado Libre bloquea cualquier fetch automatizado que no venga de un navegador real, así que hace falta ese paso) y lo escribe en la tabla `precios_meli` de Supabase. El panel se suscribe en vivo a esa tabla — el precio de Mercado Libre siempre pisa al manual.
