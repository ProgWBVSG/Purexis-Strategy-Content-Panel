-- Panel Purexis — Migración 02
-- Carpetas por producto, tipos de reel, seguidores ganados, precio histórico
-- congelado y estado de Meta Ads.
-- Pegar entero en: Supabase Studio -> SQL Editor -> New query -> Run
-- Es aditiva e idempotente: no toca ni borra datos existentes.

-- Carpeta / producto del que habla la pieza. Un guion, un eje, un producto.
-- Valores: sarro | moho | oxido | vidrios | combo | general
alter table contenido add column if not exists producto text default 'general';

-- Framework narrativo usado (el sistema de guiones de Purexis).
-- Valores: pas | before_after | tres_razones | desmitificando | fundador
alter table contenido add column if not exists framework text;

-- Intención comercial de la pieza. Se pueden combinar.
-- Valores dentro del array: tendencia | venta | valor
alter table contenido add column if not exists tipos text[] default '{}';

-- Seguidores que trajo esa pieza.
alter table contenido add column if not exists seguidores_ganados integer default 0;

-- PRECIO HISTÓRICO CONGELADO: precio unitario de cada producto en el momento
-- en que se registró la venta. Si el precio de lista cambia después, los
-- ingresos históricos NO se recalculan. Forma: {"sarro": 38901, "moho": 43223}
alter table contenido add column if not exists precios_snapshot jsonb default '{}'::jsonb;

-- Estado manual en el flujo de Meta Ads (pisa la recomendación automática).
-- Valores: null (automático) | anunciando | anunciado | descartado
alter table contenido add column if not exists ads_estado text;

-- Índices para las vistas de carpetas y del sistema de anuncios.
create index if not exists contenido_producto_idx on contenido (producto);
create index if not exists contenido_estado_idx   on contenido (estado);
