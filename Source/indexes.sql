CREATE INDEX price_indx ON Product(price);

CLUSTER Product USING price_indx;

CREATE INDEX trans_indx ON Transaction(Value);

CLUSTER Transaction USING trans_indx;

CREATE INDEX enc_data_indx ON Orderino(orderDate);

CLUSTER Orderino USING trans_indx;

CREATE INDEX id_indx ON Person(idPerson);
CLUSTER Person USING id_indx;

CREATE INDEX address_indx ON Building(address);

CREATE INDEX type_indx ON Report(reportType);