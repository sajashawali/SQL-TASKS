CREATE TABLE Managers (
    manager_id INT IDENTITY(1,1) PRIMARY KEY,
    manager_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE Departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birthdate DATE NOT NULL,
    phone_number VARCHAR(20),
    national_id VARCHAR(20) UNIQUE,
    nationality VARCHAR(50),
    marital_status VARCHAR(20),
    personal_photo VARBINARY(MAX),  
    entry_date DATE NOT NULL,
    password VARCHAR(100) NOT NULL,
    department_id INT,  -- Foreign key to Departments table
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);


CREATE TABLE Tasks (
    task_id INT IDENTITY(1,1) PRIMARY KEY,
    task_title VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    due_date DATE NOT NULL,
    task_description TEXT,
    importance_level VARCHAR(50),
    assigned_employee_id INT,  -- Foreign key to Employees table
    FOREIGN KEY (assigned_employee_id) REFERENCES Employees(employee_id)
);


CREATE TABLE Feedback (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    feedback_message TEXT NOT NULL,
    email_address VARCHAR(100) NOT NULL,
    submission_date DATE DEFAULT GETDATE()
);


