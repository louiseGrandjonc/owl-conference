-- Sequential scan
EXPLAIN ANALYZE SELECT * FROM owl WHERE employer_name='Ulule';

-- Create index

CREATE INDEX ON owl (employer_name);

-- Index scan

EXPLAIN ANALYZE SELECT * FROM owl WHERE employer_name='Ulule';

-- Still a sequential scan

EXPLAIN SELECT * FROM owl WHERE employer_name = 'post office';

-- Bitmap Heap scan

EXPLAIN ANALYZE SELECT * FROM owl WHERE owl.employer_name = 'Hogwarts';


-- JOINS

-- Nested loops

EXPLAIN ANALYZE SELECT * FROM owl JOIN job ON (job.id = owl.job_id) WHERE job.id=1;

-- Hash join

EXPLAIN ANALYZE SELECT * FROM owl JOIN job ON (job.id = owl.job_id) WHERE job.id > 1;

-- Merge Join

EXPLAIN ANALYZE SELECT * FROM letters JOIN human ON (receiver_id = human.id) ORDER BY letters.receiver_id;


-- ORDER BY

-- quicksort

EXPLAIN ANALYZE SELECT * FROM human ORDER BY last_name;

-- Top-N Heapsort

EXPLAIN ANALYZE SELECT * FROM human ORDER BY last_name LIMIT 3;

-- Create index
CREATE INDEX ON human (last_name);

-- Order using index

EXPLAIN ANALYZE SELECT * FROM human ORDER BY last_name LIMIT 5;


-- Letters from voldemort with the answer

EXPLAIN ANALYZE (
SELECT human.first_name, human.last_name,
  receiver_id, letter_id,
  sent_at,
  answer_id,
  answer_sent_at
FROM (
  SELECT
    id as letter_id,
    receiver_id,
    sent_at,
    sender_id
  FROM letters
  WHERE
        sender_id=3267
  GROUP BY receiver_id, id ORDER BY sent_at LIMIT 20
) e1 LEFT JOIN LATERAL (
  SELECT
    id as answer_id,
    sent_at as answer_sent_at
  FROM letters
  WHERE
    sender_id = e1.receiver_id
    AND sent_at > e1.sent_at
    AND receiver_id = e1.sender_id
  LIMIT 1
) e2 ON true JOIN human ON (human.id=receiver_id));


-- Create index

CREATE INDEX ON letters (sender_id, sent_at, receiver_id);
