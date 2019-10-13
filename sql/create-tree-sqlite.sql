--  sqlite3 < create-tree.sql

-- This is code copied from
-- https://explainextended.com/2009/09/24/adjacency-list-vs-nested-sets-postgresql/
--
-- Modified to run in sqlite3

DROP TABLE IF EXISTS t_hierarchy;


CREATE TABLE t_hierarchy (
        id INT NOT NULL,
        parent INT NOT NULL,
        lft INT NOT NULL,
        rgt INT NOT NULL,
        data VARCHAR(100) NOT NULL,
        stuffing VARCHAR(100) NOT NULL
);

INSERT
INTO    t_hierarchy
WITH RECURSIVE ini AS (
          SELECT  8 AS level, 5 AS children
        ),
        range AS (
          SELECT  level, children, (
            -- Breaking down the following statement for postgres:
            -- select (2 < 8) => t
            -- select (2 < 8)::INTEGER => 1
            -- select (2 < 8)::INTEGER + 1 => 2
            -- Then the construction (n < level)::INTEGER + 1) assumes the values
            -- of 2 when n < level, and 1 when n >= level.
            -- How to do this in sqlite3? Turns out there is no need to cast:
            -- 2.1. Boolean Datatype
            --      SQLite does not have a separate Boolean storage class.
            --      Instead, Boolean values are stored as integers 0 (false) and 1 (true).

              SELECT SUM(POW(children, n)::INTEGER * ((n < level) + 1))
              -- Counts down from level to 0: (8, 7, 6, 5, 4, 3, 2, 1, 0)
              -- This works well in postgres, won't work for me at the sqlite3 prompt
              -- as generate_series is a loadable extension for sqlite3.
              FROM   generate_series(level, 0, -1) n
          ) width
        FROM    ini
        ), q AS (
          SELECT  s AS id, 0 AS parent, level, children,
                1 + width * (s - 1) AS lft,
                1 + width * s - 1 AS rgt,
                width / children AS width
          FROM (
                SELECT r.*, generate_series(1, children) s
                FROM   range r
          ) q2
          UNION ALL
          SELECT  id * children + position, id, level - 1, children,
                  1 + lft + width * (position - 1),
                  1 + lft + width * position - 1,
                  width / children
          FROM (
                SELECT  generate_series(1, children) AS position, q.*
                FROM    q
          ) q2
          WHERE   level > 0
        )
SELECT  id, parent, lft, rgt, 'Value ' || id, RPAD('', 100, '*')
FROM    q;

ALTER TABLE t_hierarchy ADD CONSTRAINT pk_hierarchy_id PRIMARY KEY (id);
CREATE INDEX ix_hierarchy_lft ON t_hierarchy (lft);
CREATE INDEX ix_hierarchy_rgt ON t_hierarchy (rgt);
CREATE INDEX ix_hierarchy_parent ON t_hierarchy (parent);

ANALYZE t_hierarchy;
