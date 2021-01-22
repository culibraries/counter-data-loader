-- Start with a clean slate
DROP TABLE IF EXISTS metric;
DROP TABLE IF EXISTS title_report;

-- Create the title_report table as it exists in the R5 schema
-- and populate it with some data
CREATE TABLE title_report (
    id INT NOT NULL AUTO_INCREMENT,
    publication_id INT NOT NULL,
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
    PRIMARY KEY (id))
SELECT
    NULL AS id,
    p.id AS publication_id,
    p.title AS title,
    'J' AS title_type,
    r.name AS publisher,
    '' AS publisher_id,
    (SELECT id FROM platform_ref WHERE alt_id = r.platform_id) AS platform_id,
    journal_doi AS doi,
    p.proprietary_id,
    '' AS isbn,
    p.print_issn AS print_issn,
    p.online_issn AS online_issn,
    '' AS uri,
    '' AS yop,
    'A' AS status
FROM
    publication p JOIN publisher r ON r.id = p.publisher_id
ORDER BY
    platform_id, title;
