# SQL Transactions and Account Management

## Overview
This SQL script demonstrates the implementation of database transactions using the `START TRANSACTION`, `COMMIT`, `ROLLBACK`, and `SAVEPOINT` commands. The script creates an `Account` table and a `TRANSACTIONS` table to manage account balances and financial transactions securely.

## Features
- **Account Table Management**: Creates an `Account` table to store account details such as `accountid`, `balance`, `credit`, and `temp`.
- **Transaction Handling**: Implements multiple schedules to modify account balances using transactions.
- **Savepoints & Rollback**: Demonstrates the use of `SAVEPOINT` and `ROLLBACK` to maintain data integrity.
- **Transaction Logging**: Implements a `TRANSACTIONS` table to log financial transactions between accounts.

## Schema Definition
```sql
CREATE TABLE Account(
    accountid int,
    balance int,
    credit int,
    temp int
);

CREATE TABLE TRANSACTIONS(
    TRANSACTIONID INT AUTO_INCREMENT PRIMARY KEY,
    accountid_from int,
    accountid_to int,
    amount int,
    currect_time timestamp
);
```

## Transaction Execution
### 1. Initial Setup
- Insert an initial account with a balance and credit limit.
- Execute scheduled transactions to update balances and credits based on predefined rules.

```sql
START TRANSACTION;
INSERT INTO Account(accountid ,balance ,credit,temp ) VALUE (1,1000,2000,0);
COMMIT;
```

### 2. Scheduled Transactions
The script executes multiple schedules (`Schedual 1, 2, 3`) that:
- Deduct credit
- Adjust balance
- Calculate temporary values based on credit
- Commit transactions

Example:
```sql
START TRANSACTION;
UPDATE Account set credit = credit - 50 where accountid=1;
UPDATE Account set balance = balance + 50 where accountid=1;
COMMIT;
```

### 3. Savepoints & Rollback
Demonstrates the rollback mechanism using `SAVEPOINT`.

```sql
START TRANSACTION;
UPDATE Account SET balance = 2000 WHERE accountid = 1;
SAVEPOINT my_trans;
UPDATE Account SET balance = 3000 WHERE accountid = 1;
ROLLBACK TO SAVEPOINT my_trans;
COMMIT;
```

### 4. Transaction Logging
Transfers funds between accounts and logs transactions into the `TRANSACTIONS` table.

```sql
UPDATE Account set balance = balance + 1000 where accountid=1;
UPDATE Account set balance = balance - 1000 where accountid=2;
INSERT INTO TRANSACTIONS(accountid_from, accountid_to, amount, currect_time) VALUE (2,1,1000,NOW());
COMMIT;
```

## Usage Instructions
1. Run the SQL script in a MySQL-compatible database.
2. Verify account balances after each transaction.
3. Use the `SELECT` statements to monitor changes in the `Account` and `TRANSACTIONS` tables.

## Notes
- Ensure that MySQL or an equivalent database system is installed and running.
- Modify table structures if needed to accommodate additional business logic.
- Use `ROLLBACK` cautiously to prevent unintended data loss.

## License
This project is open-source and can be modified as needed.

