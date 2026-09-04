-- Panel Purexis — schema Postgres para Supabase
-- Pegar entero en: Supabase Studio -> SQL Editor -> New query -> Run

-- ============ TABLAS ============

create table if not exists contenido (
  id               text primary key,
  titulo           text not null default '',
  tipo             text not null default 'reel',
  canal            text not null default 'organico',
  pilar            text,
  estado           text not null default 'idea',
  fecha            date,
  vistas           integer default 0,
  alcance          integer default 0,
  likes            integer default 0,
  comentarios      integer default 0,
  guardados        integer default 0,
  compartidos      integer default 0,
  gasto_anuncio    integer default 0,
  v_sarro          integer default 0,
  v_moho           integer default 0,
  v_oxido          integer default 0,
  v_vidrios        integer default 0,
  metricas_cargadas boolean default false,
  notas            text default '',
  creado           timestamptz default now()
);

create table if not exists metas (
  id            text primary key,
  titulo        text not null default '',
  tipo          text,
  metrica       text,
  objetivo      numeric not null default 1,
  actual        numeric default 0,
  fecha_limite  date,
  unidad        text
);

create table if not exists config (
  id                  text primary key default 'app',
  seguidores_actual   integer default 0,
  seguidores_inicial  integer default 0,
  dias_metricas       integer default 4,
  precios             jsonb default '{}'::jsonb
);

create table if not exists precios_meli (
  producto_id  text primary key,
  precio       numeric,
  anterior     numeric,
  moneda       text default 'ARS',
  permalink    text,
  actualizado  timestamptz
);

create table if not exists meli_sync_status (
  id              text primary key default 'status',
  ultima_corrida  timestamptz,
  ok              text[] default '{}',
  fallidos        text[] default '{}'
);

-- ============ ROW LEVEL SECURITY ============
-- Acceso abierto: cualquiera con la URL/key pública lee y escribe (decisión tomada
-- explícitamente: panel sin login). Igual se habilita RLS con policies explícitas
-- en vez de dejarla desactivada, por prolijidad y para poder restringir después
-- sin cambiar de estrategia.

alter table contenido        enable row level security;
alter table metas            enable row level security;
alter table config           enable row level security;
alter table precios_meli     enable row level security;
alter table meli_sync_status enable row level security;

create policy "anon_all_contenido"        on contenido        for all using (true) with check (true);
create policy "anon_all_metas"            on metas            for all using (true) with check (true);
create policy "anon_all_config"           on config           for all using (true) with check (true);
create policy "anon_all_precios_meli"     on precios_meli     for all using (true) with check (true);
create policy "anon_all_meli_sync_status" on meli_sync_status for all using (true) with check (true);

-- ============ REALTIME ============
-- Para que todos los dispositivos abiertos vean los cambios en vivo.

alter publication supabase_realtime add table contenido;
alter publication supabase_realtime add table metas;
alter publication supabase_realtime add table config;
alter publication supabase_realtime add table precios_meli;

-- ============ SEED: catálogo de precios (valores de arranque) ============
-- Se van a pisar solos apenas corra la primera sincronización con Mercado Libre.

insert into precios_meli (producto_id, precio, moneda) values
  ('sarro', 7000, 'ARS'),
  ('moho', 7500, 'ARS'),
  ('oxido', 8000, 'ARS'),
  ('vidrios', 6500, 'ARS')
on conflict (producto_id) do nothing;

insert into config (id) values ('app') on conflict (id) do nothing;
