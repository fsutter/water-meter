CREATE TABLE IF NOT EXISTS measure
  (
     measure_id INTEGER PRIMARY KEY,
     meter_id   TEXT,
     volume     REAL,
     timestamp  INTEGER,
     hour       INTEGER,
     day        INTEGER,
     month      INTEGER,
     year       INTEGER
  );

CREATE INDEX idx_measure_meter_id ON measure (meter_id); 

CREATE INDEX idx_measure_day ON measure (day); 

CREATE INDEX idx_measure_month ON measure (month); 

CREATE INDEX idx_measure_year ON measure (year); 

CREATE VIEW consumption AS
    SELECT
        timestamp,
        hour,
        day,
        month,
        year,
        ifnull(CAST(1000 * volume - 1000 *(LAG(volume)
                                           OVER(
            ORDER BY
                measure_id
                                           )) AS INT),
               0) AS volume
    FROM
        measure
    ORDER BY
        measure_id;
