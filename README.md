# SET09107: Advanced Database Systems Coursework

## Overview

This repository contains the coursework for the Advanced Database Systems module for the 2022/2023 Trimester 2. The coursework involves designing and implementing a database for a bank, focusing on capturing and utilizing object-relational features.

## Scenario

A bank with branches across the UK needs a comprehensive database system to manage its branches, customer accounts, employees, and related information. The system should handle data related to branches, accounts, employees, and customers with specific requirements and relationships.

### Database Schema

The database is designed with the following relations:

- **Branch** (`bID`, `street`, `city`, `p_code`, `bPhone`)
- **Account** (`accNum`, `accType`, `balance`, `bID`, `inRate`, `limitOfFreeOD`, `openDate`)
- **Employee** (`empID`, `street`, `city`, `postCode`, `title`, `firstName`, `surName`, `empHomePhone`, `empMobile1`, `empMobile2`, `supervisorID`, `position`, `salary`, `niNum`, `bID`, `joinDate`)
- **Customer** (`custID`, `street`, `city`, `postCode`, `title`, `firstName`, `surName`, `custHomePhone`, `custMobile1`, `custMobile2`, `niNum`)
- **CustomerAccount** (`custID`, `accNum`)

## Tasks

### Task 1: ER Diagram
- **Objective**: Draw an ER diagram corresponding to the relational database schema and scenario.
- **Deliverable**: ER diagram image.

### Task 2: Object-Relational Design
- **Objective**: Re-design the database using object-relational features such as Structured Types, Inheritance, References, Methods, Constraints, and Collections. Provide a critical discussion on your design choices.
- **Deliverable**: Detailed design description and rationale.

### Task 3: Implementation
- **Objective**: Implement the database according to the redesign and populate the tables with at least 15 rows of test data.
- **Deliverables**:
  - `DBCreating.sql`: SQL script for creating types and tables.
  - `DBPopulating.sql`: SQL script for inserting data.
  - Test data examples.

### Task 4: SQL Queries
- **Objective**: Provide SQL statements and answers to specific queries. Output should be formatted and data should be displayed in values, not types.
- **Deliverables**:
  - SQL scripts for each query.
  - Output results.

### Task 5: Discussion
- **Objective**: Critically discuss the advantages and disadvantages of the object-relational model compared to the relational model based on your designs and implementations.
- **Deliverable**: Critical discussion.

### Task 6: Drop Statements
- **Objective**: Write a sequence of drop statements to remove all tables and types.
- **Deliverable**: `droppingTypesTables.sql`.

## Demonstration

- **Details**: Demonstrate your implementation of Task 4.

## Submission Instructions

1. **File Format**: Zip file in `.zip` or `.rar` format.
2. **File Name**: `set09107cw_<your_matric_number>.zip` or `set09107cw_<your_matric_number>.rar`.
3. **Contents**:
   - Report (Markdown or PDF)
   - `DBCreating.sql`
   - `DBPopulating.sql`
   - `answersToTask4.sql`
   - `droppingTypesTables.sql`
   - Test data files

**Example Filename**: `set09107cw_40012345.zip`



## Marking Scheme

- **Task 1**: 5%
- **Task 2**: 40%
  - Design: 27%
  - Rationale: 8%
  - Alternatives: 5%
- **Task 3**: 10%
  - Consistency: 5%
  - Data: 3%
  - Format: 2%
- **Task 4**: 35%
  - Query a: 3%
  - Query b: 3%
  - Query c: 3%
  - Query d: 3%
  - Query e: 5%
  - Query f: 5%
  - Query g: 5%
  - Query h: 8%
- **Task 5**: 8%
- **Task 6**: 2%
