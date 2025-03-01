CREATE TABLE Account(
    accountid int,
    balance int,
    credit int,
    temp int
);

START TRANSACTION;


INSERT INTO Account(accountid ,balance ,credit,temp ) VALUE (1,1000,2000,0);

-- Schedual 1
UPDATE Account set credit = credit - 50 where accountid=1;

UPDATE Account set balance = balance + 50 where accountid=1;

UPDATE Account set temp = credit*0.1 where accountid=1;

UPDATE Account set credit = credit - temp where accountid=1;

UPDATE Account set balance = balance + temp where accountid=1;

SELECT * FROM `account` WHERE accountid = 1;

COMMIT;

UPDATE Account set credit = 1000 where accountid=1;

UPDATE Account set balance = 2000 where accountid=1;

-- Schedual 2

UPDATE Account set temp = credit*0.1 where accountid=1;

UPDATE Account set credit = credit - temp where accountid=1;

UPDATE Account set balance = balance + temp where accountid=1;

UPDATE Account set credit = credit - 50 where accountid=1;

UPDATE Account set balance = balance + 50 where accountid=1;

SELECT * FROM `account` WHERE accountid = 1;

COMMIT;

-- Schedual 3

UPDATE Account set credit = credit - 50 where accountid=1;

UPDATE Account set temp = credit*0.1 where accountid=1;

UPDATE Account set credit = credit - temp where accountid=1;

UPDATE Account set balance = balance + 50 where accountid=1;

UPDATE Account set balance = balance + temp where accountid=1;

SELECT * FROM `account` WHERE accountid = 1;

COMMIT;

-- Schedual 3

UPDATE Account set temp = credit*0.1 where accountid=1;

UPDATE Account set credit = credit - temp where accountid=1;

UPDATE Account set credit = credit - 50 where accountid=1;

UPDATE Account set balance = balance + temp where accountid=1;

UPDATE Account set balance = balance + 50 where accountid=1;

SELECT * FROM `account` WHERE accountid = 1;

COMMIT;

--savepoint

UPDATE Account set credit = 1000 where accountid=1;

UPDATE Account set balance = 2000 where accountid=1;

START TRANSACTION;

UPDATE Account SET balance = 2000 WHERE accountid = 1;

SAVEPOINT my_trans;

UPDATE Account SET balance = 3000 WHERE accountid = 1;

ROLLBACK TO SAVEPOINT my_trans;

COMMIT;


CREATE TABLE TRANSACTIONS(
    TRANSACTIONID INT AUTO_INCREMENT PRIMARY KEY,
    accountid_from int,
    accountid_to int,
    amount int,
    currect_time timestamp
);

INSERT INTO account VALUE (2,0,0,0);

SELECT * FROM account;

UPDATE Account set balance = balance + 1000 where accountid=1;

UPDATE Account set balance = balance - 1000 where accountid=2;

INSERT INTO TRANSACTIONS(accountid_from,accountid_to,amount,currect_time) VALUE (2,1,1000,NOW());

SELECT * FROM account;

SELECT * FROM TRANSACTIONS;

COMMIT;