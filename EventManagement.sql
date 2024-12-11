-- Create the database
DROP DATABASE IF EXISTS EventManagement;
CREATE DATABASE EventManagement;
USE EventManagement;

-- Creating Event Table
CREATE TABLE Event (
    EventID     INT AUTO_INCREMENT  PRIMARY KEY,
    EventName     VARCHAR(255)     NOT NULL,
    EventType     ENUM('Wedding', 'Birthday Party', 'Conference', 'Seminar', 'Other')  NOT NULL,
    EventDetails   TEXT        ,
    EventDate    DATE         NOT NULL,
    EventCapacity  INT          NOT NULL,
    VenueID      INT         NOT NULL,
    CateringTypeID  INT         NOT NULL,
    UserID      INT         NOT NULL,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (CateringTypeID) REFERENCES CateringType(CateringTypeID) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Creating Venue Table
CREATE TABLE Venue (
    VenueID     INT AUTO_INCREMENT   PRIMARY KEY,
    VenueAddress   VARCHAR(255)    NOT NULL,
    VenueName     VARCHAR(255)    NOT NULL,
    VenueType     ENUM('Indoor', 'Outdoor')  ,
    VenuePhone     VARCHAR(20)      NOT NULL,
    VenueEmail     VARCHAR(100)    ,
    VenueCapacity   INT          NOT NULL,
    VenuePrice     DECIMAL(10, 2)    NOT NULL
);

-- Creating User Table
CREATE TABLE User (
    UserID       INT AUTO_INCREMENT   PRIMARY KEY,
    UserName     VARCHAR(255)    NOT NULL,
    UserLName     VARCHAR(255)    NOT NULL,
    UserPhone     VARCHAR(20)      NOT NULL,
    UserEmail     VARCHAR(100)
);

-- Creating Organizer Table
CREATE TABLE Organizer (
    OrganizerID   INT AUTO_INCREMENT   PRIMARY KEY,
    OrganizerName   VARCHAR(255)    NOT NULL,
    OrganizerLName   VARCHAR(255)    NOT NULL,
    OrganizerPhone   VARCHAR(20)      NOT NULL,
    OrganizerEmail   VARCHAR(100)    NOT NULL
);

-- Creating Invitation Table
CREATE TABLE Invitation (
    InvitationID   INT AUTO_INCREMENT   PRIMARY KEY,
    Attend      BOOLEAN        NOT NULL,
    EventID      INT         NOT NULL,
    UserID      INT         NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)  ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES User(UserID)    ON UPDATE CASCADE ON DELETE CASCADE
);

-- Creating CateringType Table
CREATE TABLE CateringType(
  CateringTypeID    INT AUTO_INCREMENT       PRIMARY KEY,
    CateringType    VARCHAR(50)          NOT NULL,
    CateringStandard  ENUM('Standard', 'Premium')  DEFAULT 'Standard',
    CateringDesc    VARCHAR(250)        NOT NULL,
    ContainAllergens  BOOLEAN            NOT NULL,
    CateringPrice    DECIMAL(10,2)        NOT NULL
);

-- Creating OrganizerAssignment Table
CREATE TABLE OrganizerAssignment(
  OrganizerAssignmentID  INT AUTO_INCREMENT     PRIMARY KEY,
    EventID          INT           NOT NULL,
    OrganizerID        INT           NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (OrganizerID) REFERENCES Organizer(OrganizerID)  ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Creating Transaction_Bill Table
CREATE TABLE Transaction_Bill (
    BillID       INT AUTO_INCREMENT     PRIMARY KEY,
    BillPrice     DECIMAL(10, 2)       NOT NULL,
    BillStatus     ENUM('Paid', 'Unpaid')   DEFAULT 'Unpaid',
    EventID      INT           NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)  ON UPDATE CASCADE ON DELETE CASCADE
);

-- Add Constraints to Ensure No Overlapping Dates for the Same Venue and Package
ALTER TABLE Event
ADD CONSTRAINT unique_venue_date UNIQUE (VenueID, EventDate);
