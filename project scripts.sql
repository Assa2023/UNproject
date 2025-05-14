create database project1;
use project1;
CREATE TABLE project (
    ProjectID VARCHAR(255) PRIMARY KEY,
    ProjectTitle VARCHAR(255),
    PAASCode VARCHAR(100),
    ApprovalStatus VARCHAR(100),
    Fund VARCHAR(255),
    PAGValue DECIMAL(18, 2),
    StartDate DATE,
    EndDate DATE,
    Countries TEXT, -- Could be a list of countries, so TEXT is more flexible. Alternatively, a separate table for many-to-many relationship.
    LeadOrgUnit VARCHAR(255),
    Themes TEXT, -- Could be multiple themes, so TEXT is more flexible. Alternatively, a separate table.
    Donors TEXT, -- Could be multiple donors, so TEXT is more flexible. Alternatively, a separate table.
    TotalExpenditure DECIMAL(18, 2),
    TotalContribution DECIMAL(18, 2),
    TotalContributionMinusTotalExpenditure DECIMAL(18, 2), -- This can also be a calculated field in queries
    TotalPSC DECIMAL(18, 2)
);