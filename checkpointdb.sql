-- Database: MC1

-- DROP DATABASE IF EXISTS "MC1";

-- CREATE DATABASE "MC1"
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     LC_COLLATE = 'English_Finland.1252'
--     LC_CTYPE = 'English_Finland.1252'
--     LOCALE_PROVIDER = 'libc'
--     TABLESPACE = pg_default
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

DROP TABLE IF EXISTS contact_categories;
DROP TABLE IF EXISTS contact_types;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS items;

CREATE TABLE IF NOT EXISTS contact_categories (
	id SERIAL PRIMARY KEY,
	contact_category VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS contact_types (
	id SERIAL PRIMARY KEY,
	contact_type VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS contacts (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(20),
	organization VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS items (
	contact VARCHAR(50) NOT NULL,
	contact_id INTEGER REFERENCES contacts(id),
	contact_type_id INTEGER REFERENCES contact_types(id),
	contact_category_id INTEGER REFERENCES contact_categories(id)
);

SELECT * FROM contact_categories;
SELECT * FROM contact_types;
SELECT * FROM contacts;
SELECT * FROM items;

INSERT INTO contact_categories(contact_category) VALUES
	('Home'),
	('Work'),
	('Fax');

INSERT INTO contact_types(contact_type) VALUES
	('Email'),
	('Phone'),
	('Skype'),
	('Instagram');

INSERT INTO contacts(first_name, last_name, title, organization) VALUES
	('Erik', 'Eriksson', 'Teacher', 'Utbildning AB'),
	('Anna', 'Sundh', null, null),
	('Goran', 'Bragovic', 'Coach', 'Dalens IK'),
	('Ann-Marie', 'Bergqvist', 'Cousin', null),
	('Herman', 'Appelkvist', null, null);

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id) VALUES
	('011-12 33 45',3,2,1),
	('goran@infoab.se',3,1,2),
	('010-88 55 44',4,2,2),
	('erik57@hotmail.com',1,1,1),
	('@annapanna99',2,4,1),
	('077-563578',2,2,1),
	('070-156 22 78',3,2,2);

INSERT INTO contacts(first_name, last_name, title, organization) VALUES
	('Lara', 'Teivainen-Hippi', 'Student', 'Brights');

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id) VALUES
	('laranemail@email.com', 6,1,2);


SELECT contact_type FROM contact_types
WHERE id NOT IN
(SELECT contact_type_id FROM items);

CREATE VIEW view_contacts AS
SELECT first_name, last_name, contact, contact_type, contact_category
FROM contacts c
JOIN items i ON c.id = i.contact_id
JOIN contact_types ct ON i.contact_type_id = ct.id
JOIN contact_categories cc ON i.contact_category_id = cc.id;

SELECT * FROM view_contacts;

SELECT c.id, c.first_name, c.last_name, c.title, c.organization, i.contact, i.contact_id,
i.contact_type_id, i.contact_category_id, ct.id, ct.contact_type, cc.id, cc.contact_category
FROM contacts c
JOIN items i ON c.id = i.contact_id
JOIN contact_types ct ON i.contact_type_id = ct.id
JOIN contact_categories cc ON i.contact_category_id = cc.id;

-- items table could also be constructed by using composition of all foreign keys as a primary key in items table