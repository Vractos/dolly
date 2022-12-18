CREATE DATABASE dolly;

\c dolly

-- SETING TIMEZONE TO UTC
SET timezone = 'UTC';

-- CREATING STORE TABLE
CREATE TABLE IF NOT EXISTS store(
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  email VARCHAR(80) NOT NULL,
  UNIQUE (email)
);

-- CREATING A TABLE FOR Mercado Livre CREDENTIALS
CREATE TABLE IF NOT EXISTS mercadolivre_credentials(
  owner_id UUID REFERENCES store(id) NOT NULL,
  access_token VARCHAR(80) NOT NULL,
  expires_in  INTEGER NOT NULL,
  user_id VARCHAR(80) NOT NULL,
  refresh_token VARCHAR(80) NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (owner_id)
);

-- CREATING ORDER TABLE
CREATE TABLE IF NOT EXISTS orders(
  id UUID NOT NULL PRIMARY KEY,
  store_id UUID REFERENCES store(id) NOT NULL,
  marketplace_id VARCHAR(80) NOT NULL,
  date_created TIMESTAMPTZ,
  status VARCHAR(80),
  UNIQUE (marketplace_id)
);

-- CREATING ORDER ITEMS TABLE
CREATE TABLE IF NOT EXISTS order_items(
  id UUID NOT NULL PRIMARY KEY,
  title VARCHAR(70),
  sku VARCHAR(80) NOT NULL,
  quantiy SMALLINT NOT NULL,
  order_id UUID REFERENCES orders(id) NOT NULL
);

-- -- FUNCTION TO ADD updated_at (last update) IN Mercado Livre CREDENTIALS
-- CREATE OR REPLACE FUNCTION trigger_set_updated_timestamp()
-- RETURNS TRIGGER AS $$
-- BEGIN
--   NEW.updated_at = NOW();
--   RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- CREATING TRIGGER TO ADD updated_at (last update) IN Mercado Livre CREDENTIALS
-- CREATE TRIGGER set_updated_timestamp
-- BEFORE UPDATE ON mercadolivre_credentials
-- FOR EACH ROW
-- EXECUTE PROCEDURE trigger_set_update_timestamp();