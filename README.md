# salon.sql Explained

This `salon.sql` file is a critical component of the Salon Appointment Scheduler project from freeCodeCamp. It contains the SQL commands needed to create and populate the database that powers the appointment scheduling application. Here's a breakdown of what it does:

## Database Creation:

- **`CREATE DATABASE salon;`:**  This line creates the actual database named "salon" where all the information will be stored.

## Table Structure:

The file then defines the structure of three essential tables:

- **`customers`:**
    - `customer_id SERIAL PRIMARY KEY`:  A unique ID for each customer, automatically generated and incremented.
    - `name VARCHAR(255)`: Stores the customer's name.
    - `phone VARCHAR(255) UNIQUE`: Stores the customer's phone number, which must be unique.

- **`services`:**
    - `service_id SERIAL PRIMARY KEY`: A unique ID for each service offered.
    - `name VARCHAR(255)`: Stores the name of the service (e.g., "cut", "color", "perm").

- **`appointments`:**
    - `appointment_id SERIAL PRIMARY KEY`: A unique ID for each appointment.
    - `customer_id INT`:  Stores the ID of the customer associated with the appointment, referencing the `customers` table.
    - `service_id INT`: Stores the ID of the service booked, referencing the `services` table.
    - `time VARCHAR(255)`: Stores the time of the appointment.

## Foreign Keys:

- In the `appointments` table, `customer_id` and `service_id` act as foreign keys. This ensures that every appointment is linked to a valid customer and a valid service offered by the salon.

## Data Population:

- The script includes `INSERT INTO services` statements. This pre-populates the `services` table with a few example services, including one with a `service_id` of 1 as required by the project instructions.

## Why This File is Important:

- **Reproducibility:** It allows you to easily recreate the database structure and initial data, which is crucial for development, testing, and sharing your project.
- **Backup:** You can use this file to create a backup of your database in case you need to restore it later.
- **Submission:** freeCodeCamp requires you to submit this file as part of your project completion.

## How to Use It:

1.  **Save the file:** Save the `salon.sql` file to your local machine.
2.  **Connect to PostgreSQL:** Open a terminal and connect to your PostgreSQL server.
3.  **Create the database:** Run the command `psql -U postgres < salon.sql` to execute the SQL commands in the file and create the database.

This will set up your database with the necessary tables and data, allowing you to run the `salon.sh` script and interact with the Salon Appointment Scheduler application.
