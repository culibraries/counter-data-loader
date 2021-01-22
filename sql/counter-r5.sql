DROP DATABASE counter_dev;
CREATE DATABASE counter_dev DEFAULT CHARACTER SET latin1;
USE counter_dev;

-- create the tables
CREATE TABLE title_report (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(400) NOT NULL,
    title_type CHAR(1) NOT NULL,
    publisher VARCHAR(100) NOT NULL,
    publisher_id VARCHAR(50) NULL,
    platform_id INT NOT NULL,
    doi VARCHAR(100) NULL,
    proprietary_id VARCHAR(100) NULL,
    isbn VARCHAR(20) NULL,
    print_issn VARCHAR(15) NULL,
    online_issn VARCHAR(15) NULL,
    uri VARCHAR(200) NULL,
    yop VARCHAR(4) NULL,
    status CHAR(1) NULL,
    PRIMARY KEY (id));
  
CREATE TABLE metric (
    id INT NOT NULL AUTO_INCREMENT,
    title_report_id INT NOT NULL,
    access_type VARCHAR(20) NULL,
    metric_type_id INT NOT NULL,
    period DATE NOT NULL,
    period_total INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    INDEX TITLE_REPORT_ID_IDX (title_report_id ASC),
    CONSTRAINT TITLE_REPORT_ID_FK
        FOREIGN KEY (title_report_id)
        REFERENCES title_report (id));

CREATE TABLE filter (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(250) DEFAULT NULL,
  params VARCHAR(500) NOT NULL,
  created_date DATETIME NOT NULL,
  updated_date DATETIME NOT NULL,
  owner VARCHAR(10) NOT NULL,
  PRIMARY KEY (id));

CREATE TABLE platform_ref (
    id INT NOT NULL,
    alt_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    alias VARCHAR(100) NULL,
    preferred_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id));

CREATE TABLE metric_type_ref (
    id INT NOT NULL,
    metric_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (id));

CREATE VIEW title_report_view AS (
    SELECT
        (t.id + m.id) AS id,
        t.title AS title,
        t.title_type AS title_type,
        p.preferred_name AS platform,
        m.access_type AS access_type,
        c.metric_type AS metric_type,
        m.period as period,
        m.period_total AS period_total
    FROM
        title_report t
    JOIN
        metric m ON m.title_report_id = t.id
    JOIN
        platform_ref p ON p.id = t.platform_id
    JOIN
        metric_type_ref c ON c.id = m.metric_type_id
);
