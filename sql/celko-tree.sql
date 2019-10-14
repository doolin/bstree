-- http://www.ibase.ru/files/articles/programming/dbmstrees/sqltrees.html

drop table if exists Personnel1;
CREATE TABLE Personnel1
(emp CHAR(10) NOT NULL PRIMARY KEY,
boss CHAR(10) DEFAULT NULL REFERENCES Personnel1(emp),
salary DECIMAL(6,2) NOT NULL DEFAULT 100.00);

drop table if exists Personnel2;
CREATE TABLE Personnel2
(emp CHAR(10) NOT NULL PRIMARY KEY,
  lft INTEGER NOT NULL UNIQUE CHECK (lft > 0),
  rgt INTEGER NOT NULL UNIQUE CHECK (rgt > 1),
  CONSTRAINT order_okay CHECK (lft < rgt) );
