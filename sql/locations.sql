-- https://stackoverflow.com/questions/18106947/cte-recursion-to-get-tree-hierarchy

CREATE TABLE tblLocations (ID INT IDENTITY(1,1), Code VARCHAR(1), ParentID INT, Name VARCHAR(20));

INSERT INTO tblLocations (Code, ParentID, Name) VALUES
('A', NULL, 'West'),
('A', 1, 'WA'),
('A', 2, 'Seattle'),
('A', NULL, 'East'),
('A', 4, 'NY'),
('A', 5, 'New York'),
('A', 1, 'NV'),
('A', 7, 'Las Vegas'),
('A', 2, 'Vancouver'),
('A', 4, 'FL'),
('A', 5, 'Buffalo'),
('A', 1, 'CA'),
('A', 10, 'Miami'),
('A', 12, 'Los Angeles'),
('A', 7, 'Reno'),
('A', 12, 'San Francisco'),
('A', 10, 'Orlando'),
('A', 12, 'Sacramento');

