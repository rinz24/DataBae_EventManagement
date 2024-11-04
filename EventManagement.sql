-- Create the database
CREATE DATABASE EventManagement;
USE EventManagement;

-- Creating Event Table
CREATE TABLE Event (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(100),
    Details TEXT
);

-- Creating Venue Table
CREATE TABLE Venue (
    VenueID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(255),
    Name VARCHAR(255),
    VenueType ENUM('Indoor', 'Outdoor'),
    PhoneNum VARCHAR(20),
    Email VARCHAR(100)
);

-- Creating Audience Table
CREATE TABLE Audience (
    AudienceID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    PhoneNum VARCHAR(20),
    Email VARCHAR(100)
);

-- Creating Organizer Table
CREATE TABLE Organizer (
    OrganizerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    Type VARCHAR(100),
    PhoneNum VARCHAR(20),
    Email VARCHAR(100)
);

-- Creating Transaction_Bill Table
CREATE TABLE Transaction_Bill (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    Price DECIMAL(10, 2) NOT NULL,
    Payment INT, -- This could reference a payment methods table if required
    EventID INT,
    PackageID INT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID)
);

-- Creating Invitation Table (renamed from Schedule)
CREATE TABLE Invitation (
    ScheduleID INT AUTO_INCREMENT PRIMARY KEY,
    EventID INT,
    StartDate TIME,
    EndDate TIME,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Creating Package Table
CREATE TABLE Package (
    PackageID INT AUTO_INCREMENT PRIMARY KEY,
    Type VARCHAR(100),
    EventID INT,
    VenueID INT,
    Price DECIMAL(10, 2),
    Capacity INT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);

-- Creating Calendar Table
CREATE TABLE Calendar (
    CalendarID INT AUTO_INCREMENT PRIMARY KEY,
    EventID INT,
    VenueID INT,
    Date DATE NOT NULL,
    StartTime TIME,
    EndTime TIME,
    PackageID INT,
    Description TEXT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID),
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID)
);

-- Add Constraints to Ensure No Overlapping Dates for the Same Venue and Package
ALTER TABLE Calendar
ADD CONSTRAINT unique_venue_date UNIQUE (VenueID, Date);

ALTER TABLE Calendar
ADD CONSTRAINT unique_package_date UNIQUE (PackageID, Date);

-- Insert data into Venue table
INSERT INTO Venue (Address, Name, VenueType, PhoneNum, Email) VALUES
('Jl. Sudirman No.1, Jakarta', 'Grand Jakarta Hall', 'Indoor', '021-1234567', 'contact@grandjakartahall.com'),
('Jl. Thamrin No.2, Jakarta', 'Jakarta Skyline Convention Center', 'Indoor', '021-2345678', 'info@jakartaskyline.com'),
('Jl. MH Thamrin No.3, Jakarta', 'Emerald Gardens Event Venue', 'Outdoor', '021-3456789', 'contact@emeraldgardens.com'),
('Jl. Rasuna Said No.4, Jakarta', 'The Jakarta Ballroom', 'Indoor', '021-4567890', 'info@jakartaballroom.com'),
('Jl. Gatot Subroto No.5, Jakarta', 'Royal Heritage Pavilion', 'Indoor', '021-5678901', 'contact@royalheritage.com'),
('Jl. Medan Merdeka No.6, Jakarta', 'Skyline Terrace Jakarta', 'Outdoor', '021-6789012', 'info@skylineterracejakarta.com'),
('Jl. Fatmawati No.7, Jakarta', 'Blue Lotus Event Space', 'Indoor', '021-7890123', 'contact@bluelotusevent.com'),
('Jl. Pluit No.8, Jakarta', 'Oasis Jakarta Banquet Hall', 'Indoor', '021-8901234', 'info@oasisjakarta.com'),
('Jl. Kuningan No.9, Jakarta', 'The Luxe Loft', 'Indoor', '021-9012345', 'contact@theluxeloft.com'),
('Jl. Tebet No.10, Jakarta', 'Crystal Waters Event Space', 'Outdoor', '021-0123456', 'info@crystalwaters.com'),
('Jl. Kemang No.11, Jakarta', 'Grandview Conference Center', 'Indoor', '021-1234560', 'contact@grandviewjakarta.com'),
('Jl. Senayan No.12, Jakarta', 'Jakarta Pearl Hall', 'Indoor', '021-2345671', 'info@jakartapearl.com'),
('Jl. PIK No.13, Jakarta', 'Orchid Gardens Pavilion', 'Outdoor', '021-3456782', 'contact@orchidgardens.com'),
('Jl. Menteng No.14, Jakarta', 'Pacific Convention Center', 'Indoor', '021-4567893', 'info@pacificconvention.com'),
('Jl. Daan Mogot No.15, Jakarta', 'The Heritage Atrium', 'Indoor', '021-5678904', 'contact@heritageatrium.com'),
('Jl. BSD No.16, Jakarta', 'Infinity Jakarta Hall', 'Indoor', '021-6789015', 'info@infinityhall.com'),
('Jl. Bintaro No.17, Jakarta', 'Eastwood Event Center', 'Outdoor', '021-7890126', 'contact@eastwoodjakarta.com'),
('Jl. Kelapa Gading No.18, Jakarta', 'The Riverside Pavilion', 'Outdoor', '021-8901237', 'info@riversidepavilion.com'),
('Jl. Pondok Indah No.19, Jakarta', 'Jakarta Bay Event Venue', 'Indoor', '021-9012348', 'contact@jakartabayvenue.com'),
('Jl. Casablanca No.20, Jakarta', 'Central Park Event Hall', 'Indoor', '021-0123459', 'info@centralparkevent.com');

-- Insert data into Package table with Different Types and Capacities
INSERT INTO Package (Type, EventID, VenueID, Price, Capacity) VALUES
('Standard', NULL, 1, 1000.00, 50),
('Premium', NULL, 2, 2000.00, 100),
('VIP', NULL, 3, 5000.00, 200),
('Corporate', NULL, 4, 3000.00, 150),
('Small Party', NULL, 1, 800.00, 30),
('Wedding', NULL, 5, 4000.00, 100),
('Conference', NULL, 2, 3500.00, 120),
('Standard', NULL, 3, 1000.00, 50),
('Premium', NULL, 4, 2000.00, 100),
('VIP', NULL, 5, 5000.00, 200);
