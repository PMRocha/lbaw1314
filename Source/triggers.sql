/* Verifies if in the new inserted/updated product the expiration date is superior to the system date */
CREATE FUNCTION product_expiration_date() RETURNS trigger AS $$
BEGIN
	IF new.expirationDate > CURRENT_TIMESTAMP THEN
  		RETURN NEW;
	ELSE 
  		RETURN NULL; /* OR RAISE EXCEPTION 'Invalid Expiration Date' */
END IF;
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER verify_expiration_date BEFORE INSERT OR UPDATE ON Product 
FOR EACH ROW EXECUTE PROCEDURE product_expiration_date();


/* Verifies if in the new inserted/updated report the completion date is inferior to the system date */
CREATE FUNCTION report_completion_date() RETURNS trigger AS $$
BEGIN
	IF new.completionDate <= CURRENT_TIMESTAMP THEN
  		RETURN NEW;
	ELSE 
  		RETURN NULL; /* OR RAISE EXCEPTION 'Invalid Completion Date' */
END IF;
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER verify_expiration_date BEFORE INSERT OR UPDATE ON Report 
FOR EACH ROW EXECUTE PROCEDURE report_completion_date();