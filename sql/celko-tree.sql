-- http://www.ibase.ru/files/articles/programming/dbmstrees/sqltrees.html

-- sqlite3 celko.db < celko-tree.sql

drop table if exists personnel1;
CREATE TABLE personnel1 (
  emp CHAR(10) NOT NULL PRIMARY KEY,
  boss CHAR(10) DEFAULT NULL REFERENCES personnel1(emp),
  salary DECIMAL(6,2) NOT NULL DEFAULT 100.00
);

insert into personnel1 (emp, boss, salary) values
  ("albert",null,1000.00),
  ("chuck", "albert", 900.00),
  ("bert", "albert", 900.00),
  ("donna", "chuck", 800.00),
  ("eddie", "chuck", 700.00),
  ("fred", "chuck", 600.00);

drop table if exists personnel2;
CREATE TABLE personnel2 (
  emp CHAR(10) NOT NULL PRIMARY KEY,
  lft INTEGER NOT NULL UNIQUE CHECK (lft > 0),
  rgt INTEGER NOT NULL UNIQUE CHECK (rgt > 1),
  CONSTRAINT order_okay CHECK (lft < rgt)
);

insert into personnel2 (emp, lft, rgt) values
  ("albert", 1, 12),
  ("bert", 2, 3),
  ("chuck", 4, 11),
  ("donna", 5, 6),
  ("eddie", 7, 8),
  ("fred", 9, 10);

SELECT P2.*
   FROM personnel2 AS P1, personnel2 AS P2
    WHERE P1.lft BETWEEN P2.lft AND P2.rgt
        AND P1.emp = :myemployee; -- e.g., "donna"
