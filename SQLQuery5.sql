CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1), -- Use IDENTITY for auto-increment
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    profile_pic VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE() -- Use GETDATE for default timestamps in SQL Server
);

CREATE TABLE Messages (
    message_id INT PRIMARY KEY IDENTITY(1,1),
    sender_id INT,
    receiver_id INT,
    message_text TEXT NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);

CREATE TABLE Services (
    service_id INT PRIMARY KEY IDENTITY(1,1),
    service_name VARCHAR(100) NOT NULL,
    service_description VARCHAR(255), -- Changed to VARCHAR for consistency
    service_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE User_Services (
    user_service_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    service_id INT,
    purchase_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    user_service_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method VARCHAR(50),
    FOREIGN KEY (user_service_id) REFERENCES User_Services(user_service_id)
);

INSERT INTO Users (username, email, password, date_of_birth, profile_pic)
VALUES 
('saja', 'saja@gmail.com', 'password123', '1990-05-15', 'saja_pic.jpg'),
('mohammad', 'mohammad@gmail.com', 'password456', '1985-09-12', 'mohammad_pic.jpg'),
('leen', 'leen@gmail.com', 'password789', '1992-08-21', 'leen_pic.jpg'),
('kalid', 'kalid@gmail.com', 'password001', '1987-07-02', 'kalid_pic.jpg'),
('jana', 'jana@gmail.com', 'password202', '1991-01-11', 'jana_pic.jpg'),
('lana', 'lana@gmail.com', 'password303', '1993-02-23', 'lana_pic.jpg');

INSERT INTO Messages (sender_id, receiver_id, message_text)
VALUES 
(1, 2, 'Hey, how are you?'),
(2, 1, 'I am doing well, thanks! How about you?'),
(3, 4, 'Let’s catch up this weekend!'),
(4, 3, 'Sounds good! See you soon.'),
(5, 6, 'Can you help me with the project?'),
(6, 5, 'Sure, I’ll send you the files.');


INSERT INTO Services (service_name, service_description, service_price)
VALUES 
('Premium Messaging', 'Unlock premium messaging features', 9.99),
('Ad-Free Experience', 'Remove all ads from the app', 4.99),
('Cloud Backup', 'Save message history in the cloud', 2.99),
('Extra Emojis', 'Access exclusive emoji pack', 1.99),
('Priority Support', 'Get priority customer support', 7.99),
('Custom Themes', 'Customize app themes', 3.99);

INSERT INTO User_Services (user_id, service_id)
VALUES 
(1, 1), (1, 2), (2, 1), (3, 3), (4, 4), (5, 5);


INSERT INTO Payments (user_service_id, amount, payment_method)
VALUES 
(1, 9.99, 'Credit Card'), 
(2, 4.99, 'PayPal'), 
(3, 9.99, 'Credit Card'), 
(4, 2.99, 'Debit Card'), 
(5, 1.99, 'PayPal'), 
(6, 7.99, 'Credit Card');

-- Update the email of the user with user_id = 1
UPDATE Users 
SET email = 'saja_updated@gmail.com' 
WHERE user_id = 1;

-- Update the profile picture of the user with user_id = 2
UPDATE Users 
SET profile_pic = 'sami_new_pic.jpg' 
WHERE user_id = 2;


-- Update the message_text for the message with message_id = 1
UPDATE Messages 
SET message_text = 'Hey, what’s up?'
WHERE message_id = 1;



-- Update the receiver of the message with message_id = 4
UPDATE Messages 
SET receiver_id = 6 
WHERE message_id = 4;



-- Update the service price of the service with service_id = 1
UPDATE Services 
SET service_price = 8.99 
WHERE service_id = 1;



-- Update the service description of the service with service_id = 3
UPDATE Services 
SET service_description = 'Enhanced cloud backup service'
WHERE service_id = 3;



-- Update the service_id for the record with user_service_id = 1
UPDATE User_Services 
SET service_id = 3 
WHERE user_service_id = 1;



-- Update the purchase_date for the record with user_service_id = 2
UPDATE User_Services 
SET purchase_date = '2024-05-15 12:00:00' 
WHERE user_service_id = 2;




-- Update the payment amount for the payment with payment_id = 1
UPDATE Payments 
SET amount = 10.99 
WHERE payment_id = 1;

-- Update the payment method for the payment with payment_id = 3
UPDATE Payments 
SET payment_method = 'Debit Card' 
WHERE payment_id = 3;


DELETE FROM Payments WHERE user_service_id IN (
    SELECT user_service_id FROM User_Services ORDER BY user_service_id OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY
);

DELETE FROM User_Services WHERE user_service_id IN (
    SELECT user_service_id FROM User_Services ORDER BY user_service_id OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY
);

DELETE FROM Messages WHERE message_id IN (
    SELECT message_id FROM Messages ORDER BY message_id OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY
);
--DELETE FROM User_Services WHERE service_id IN (
  --  SELECT service_id FROM Services ORDER BY service_id OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY
--);

-- Rename Users table to AppUsers
EXEC sp_rename 'Users', 'AppUsers';

-- Rename Messages table to UserMessages
EXEC sp_rename 'Messages', 'UserMessages';



-- Rename and change datatype for a column in AppUsers table
EXEC sp_rename 'AppUsers.username', 'user_name', 'COLUMN';
ALTER TABLE AppUsers ALTER COLUMN user_name NVARCHAR(100) NOT NULL;

-- Rename and change datatype for a column in UserMessages table
EXEC sp_rename 'UserMessages.message_text', 'content', 'COLUMN';
ALTER TABLE UserMessages ALTER COLUMN content NVARCHAR(MAX) NOT NULL;