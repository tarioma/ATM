CREATE TABLE bank
(
    id     INT PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL UNIQUE CHECK (LENGTH(Name) BETWEEN 2 AND 255)
);

CREATE TABLE atm
(
    number             INT PRIMARY KEY,
    address            VARCHAR(255) NOT NULL CHECK (LENGTH(Address) BETWEEN 2 AND 255),
    remaining_currency MONEY        NOT NULL,
    bank_id            INT          NOT NULL REFERENCES bank (id)
);

CREATE TABLE client
(
    passport_id INT PRIMARY KEY,
    first_name  VARCHAR(20)  NOT NULL CHECK (LENGTH(first_name) BETWEEN 2 AND 20),
    last_name   VARCHAR(20)  NOT NULL CHECK (LENGTH(last_name) BETWEEN 2 AND 20),
    patronymic  VARCHAR(20) CHECK (LENGTH(last_name) BETWEEN 2 AND 20 or last_name IS NULL),
    balance     MONEY        NOT NULL CHECK (balance >= '0'::MONEY),
    phone       VARCHAR(14) CHECK (LENGTH(phone) BETWEEN 5 AND 20 or phone IS NULL),
    address     VARCHAR(255) NOT NULL CHECK (LENGTH(Address) BETWEEN 8 AND 255),
    bank_id     INT          NOT NULL REFERENCES bank (id)
);

CREATE TABLE credit_card
(
    number             VARCHAR(16) PRIMARY KEY,
    validity_person    DATE     NOT NULL,
    cvv                SMALLINT NOT NULL CHECK (cvv BETWEEN 1 AND 999),
    fee                DECIMAL  NOT NULL CHECK (fee BETWEEN 1 AND 100),
    client_passport_id INT REFERENCES client (passport_id)
);

CREATE TABLE operation
(
    id                 INT PRIMARY KEY,
    "date"             DATE NOT NULL,
    amount             MONEY NOT NULL CHECK (amount > '0'::MONEY),
    atm_number         INT   NOT NULL REFERENCES atm (number),
    credit_card_number VARCHAR(16) REFERENCES credit_card (number)
);
