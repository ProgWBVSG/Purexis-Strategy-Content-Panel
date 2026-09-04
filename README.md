# Panel Purexis

Portal de control interno de Purexis: organización de contenido, metas financieras y de contenido, ventas por producto (Quita Sarro, Quita Moho, Quita Óxido, Limpia Vidrios), métricas orgánico vs. anuncios, y reportes rodantes de 4 semanas.

## Stack

- HTML/CSS/JS puro, un solo archivo (`index.html`).
- Motor de datos: [sql.js](https://sql.js.org/) (SQLite compilado a WebAssembly), corre 100% en el navegador — no requiere backend para funcionar.
- Tipografía: Montserrat.

## Deploy

Sitio estático, sin build. En Vercel: importar este repo, sin configuración adicional (framework preset "Other").

## Estado de la sincronización entre dispositivos y con Mercado Libre

Esta versión guarda los datos en el `localStorage` de cada navegador — **no sincroniza entre dispositivos todavía**. Esa función (junto con la actualización automática de precios desde Mercado Libre) se está migrando desde la versión anterior, que usaba una base de datos exclusiva del entorno de Claude, a una base real (Supabase) compatible con este deploy.
