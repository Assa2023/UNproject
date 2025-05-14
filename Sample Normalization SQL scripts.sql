SELECT * FROM project.project;
CREATE TABLE approval_statuses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE funds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE org_units (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE projects (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    paas_code VARCHAR(50),
    approval_status_id INT,
    fund_id INT,
    pag_value DECIMAL(18,2),
    start_date DATE,
    end_date DATE,
    org_unit_id INT,
    expenditure DECIMAL(18,2),
    contribution DECIMAL(18,2),
    balance DECIMAL(18,2),
    psc DECIMAL(18,2),

    FOREIGN KEY (approval_status_id) REFERENCES approval_statuses(id),
    FOREIGN KEY (fund_id) REFERENCES funds(id),
    FOREIGN KEY (org_unit_id) REFERENCES org_units(id)
);
CREATE TABLE countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE project_countries (
    project_id INT,
    country_id INT,
    PRIMARY KEY (project_id, country_id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (country_id) REFERENCES countries(id)
);
CREATE TABLE themes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE project_themes (
    project_id INT,
    theme_id INT,
    PRIMARY KEY (project_id, theme_id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (theme_id) REFERENCES themes(id)
);
CREATE TABLE donors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE project_donors (
    project_id INT,
    donor_id INT,
    PRIMARY KEY (project_id, donor_id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (donor_id) REFERENCES donors(id)
);
INSERT IGNORE INTO approval_statuses (label)
SELECT DISTINCT `Approval Status` FROM project WHERE `Approval Status` IS NOT NULL;

INSERT IGNORE INTO funds (name)
SELECT DISTINCT `Fund` FROM project WHERE `Fund` IS NOT NULL;

INSERT IGNORE INTO org_units (name)
SELECT DISTINCT `Lead Org Unit` FROM project WHERE `Lead Org Unit` IS NOT NULL;
ALTER TABLE project
ADD COLUMN approval_status_id INT,
ADD COLUMN fund_id INT,
ADD COLUMN org_unit_id INT;
show tables;
UPDATE `project` AS p
JOIN `approval_statuses` AS a ON p.`Approval Status` = a.label
SET p.approval_status_id = a.id;

UPDATE `project` AS p
JOIN `funds` AS f ON p.`Fund` = f.name
SET p.fund_id = f.id;

UPDATE `project` AS p
JOIN `org_units` AS o ON p.`Lead Org Unit` = o.name
SET p.org_unit_id = o.id;


