DROP TABLE IF EXISTS metric;
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
        REFERENCES title_report (id))
SELECT
    NULL AS id,
    t.id AS title_report_id,
    'Controlled' AS access_type,
    2 AS metric_type_id,
    u.period AS period,
    u.requests AS period_total
FROM
    usage_stat u JOIN title_report t ON t.publication_id = u.publication_id;
