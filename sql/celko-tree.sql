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

drop table if exists salaries;
CREATE TABLE salaries (
  emp CHAR(10) NOT NULL PRIMARY KEY,
  boss CHAR(10) DEFAULT NULL REFERENCES salaries(emp),
  salary DECIMAL(6,2) NOT NULL DEFAULT 100.00
);

insert into salaries (emp, boss, salary) values
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

SELECT P2.* FROM personnel2 AS P1, personnel2 AS P2
    WHERE P1.lft BETWEEN P2.lft AND P2.rgt
    AND P1.emp = :myemployee; -- e.g., "donna"

-- apparently a type in the article, as it states to select
-- from P2, but P1 provides the information described.
SELECT P1.* FROM personnel2 AS P1, personnel2 AS P2
    WHERE P1.lft BETWEEN P2.lft AND P2.rgt
    AND P2.emp = :myemployee;

-- Salaries by control
SELECT P2.emp, SUM(S1.salary) FROM personnel2 AS P1, personnel2 AS P2, Salaries AS S1
   WHERE P1.lft BETWEEN P2.lft AND P2.rgt AND P1.emp = S1.emp GROUP BY P2.emp;

-- This one works
SELECT COUNT(P2.emp) AS indentation, P1.emp FROM personnel2 AS P1, personnel2 AS P2
    WHERE P1.lft BETWEEN P2.lft AND P2.rgt GROUP BY P1.emp ORDER BY P1.lft;

-- insertion of new rightmost
