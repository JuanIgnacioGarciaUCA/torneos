-- Desactivar revisión de llaves foráneas para poder borrar en cualquier orden
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS lista_partidos;
DROP TABLE IF EXISTS jugadores;
DROP TABLE IF EXISTS listatorneos;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Tabla de Torneos
CREATE TABLE listatorneos (
  id_torneo VARCHAR(100) NOT NULL,
  nombre_torneo VARCHAR(255) NOT NULL,
  fechahora_inicio_torneo TIMESTAMP NULL,
  fechahora_fin_torneo TIMESTAMP NULL,

  tipo_torneo VARCHAR(50) NULL DEFAULT 'PENDIENTE',
  max_num_grupos INTEGER NULL DEFAULT 0,
  max_num_juegos_por_partido INTEGER NULL DEFAULT 0,
    
  url_inscripcion_publica TEXT NOT NULL,
  url_inscripcion_admin TEXT NOT NULL,
  url_resultados_publica TEXT NOT NULL,
  url_resultados_admin TEXT NOT NULL,
  url_cerrar TEXT NOT NULL,
  url_revision_publica TEXT NOT NULL,
  url_revision_admin TEXT NOT NULL,
  url_qrs TEXT NOT NULL,

  log TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_torneo)
) ENGINE=InnoDB;

-- 2. Tabla de Jugadores (Debe ir antes que lista_partidos)
CREATE TABLE jugadores (
  id_torneo VARCHAR(100) NOT NULL,
  id_jugador INTEGER NOT NULL,
  nombre_jugador VARCHAR(255) NOT NULL,
  nivel VARCHAR(100) NULL,
  log TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_torneo, id_jugador),
  CONSTRAINT jugadores_id_torneo_fkey 
    FOREIGN KEY (id_torneo) REFERENCES listatorneos (id_torneo) 
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. Tabla de Partidos
CREATE TABLE lista_partidos (
  id_torneo VARCHAR(100) NOT NULL,
  id_partido VARCHAR(100) NOT NULL,
  tipo_partido VARCHAR(100) NULL,
  id_jugador1 INTEGER NOT NULL,
  id_jugador2 INTEGER NOT NULL,
  g1 VARCHAR(20) NULL DEFAULT '0-0',
  g2 VARCHAR(20) NULL DEFAULT '0-0',
  g3 VARCHAR(20) NULL DEFAULT '0-0',
  g4 VARCHAR(20) NULL DEFAULT '0-0',
  g5 VARCHAR(20) NULL DEFAULT '0-0',
  g6 VARCHAR(20) NULL DEFAULT '0-0',
  g7 VARCHAR(20) NULL DEFAULT '0-0',
  fechahora_inicio_partido TIMESTAMP NULL,
  mesa INTEGER NOT NULL,
  log TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_torneo, id_partido),
  CONSTRAINT lista_partidos_id_torneo_id_jugador1_fkey 
    FOREIGN KEY (id_torneo, id_jugador1) REFERENCES jugadores (id_torneo, id_jugador) 
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT lista_partidos_id_torneo_id_jugador2_fkey 
    FOREIGN KEY (id_torneo, id_jugador2) REFERENCES jugadores (id_torneo, id_jugador) 
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;