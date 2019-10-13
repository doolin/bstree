--  psql -U postgres < create-tree.sql

-- This is code copied from
-- https://explainextended.com/2009/09/24/adjacency-list-vs-nested-sets-postgresql/
--
-- It only runs in postgres, so a good exercise would be to get it running in sqlite3,
-- or something equivalent in sqlite3.

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
WITH RECURSIVE
        ini AS
        (
        SELECT  8 AS level, 5 AS children
        ),
        range AS
        (
        SELECT  level, children,
                (
                SELECT  SUM(POW(children, n)::INTEGER * ((n < level)::INTEGER + 1)) -- postgres
                FROM    generate_series(level, 0, -1) n
                ) width
        FROM    ini
        ),
        q AS
        (
        SELECT  s AS id, 0 AS parent, level, children,
                1 + width * (s - 1) AS lft,
                1 + width * s - 1 AS rgt,
                width / children AS width
        FROM    (
                SELECT  r.*, generate_series(1, children) s
                FROM    range r
                ) q2
        UNION ALL
        SELECT  id * children + position, id, level - 1, children,
                1 + lft + width * (position - 1),
                1 + lft + width * position - 1,
                width / children
        FROM    (
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
