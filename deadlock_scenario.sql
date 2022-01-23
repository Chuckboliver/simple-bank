-- Deadlock
-- Tx1 transfer $10 from accoun 1 to account 2
BEGIN;

UPDATE accounts
SET balance = balance - 10
WHERE id = 1
RETURNING *;

UPDATE accounts
SET balance = balance + 10
WHERE id = 2
RETURNING *;

ROLLBACK;

-- Tx2 transfer $10 from accoun 2 to account 1
BEGIN;

UPDATE accounts
SET balance = balance - 10
WHERE id = 2
RETURNING *;

UPDATE accounts
SET balance = balance + 10
WHERE id = 1
RETURNING *;

ROLLBACK;


-- No Deadlock
-- Tx1 transfer $10 from accoun 1 to account 2
BEGIN;

UPDATE accounts
SET balance = balance - 10
WHERE id = 1
RETURNING *;

UPDATE accounts
SET balance = balance + 10
WHERE id = 2
RETURNING *;

ROLLBACK;

-- Tx2 transfer $10 from accoun 2 to account 1
BEGIN;

UPDATE accounts
SET balance = balance + 10
WHERE id = 1
RETURNING *;

UPDATE accounts
SET balance = balance - 10
WHERE id = 2
RETURNING *;

ROLLBACK;