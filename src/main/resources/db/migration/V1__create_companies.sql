CREATE TABLE companies (
  id         BIGSERIAL PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  industry   VARCHAR(50),
  phone      VARCHAR(20),
  address    VARCHAR(255),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
