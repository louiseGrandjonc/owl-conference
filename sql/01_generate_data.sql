INSERT INTO human (first_name, last_name)

SELECT
  name_first,
  name_last
FROM (
   -- name_first
  SELECT(
        SELECT initcap(string_agg(x,''))  as name_first
               FROM (
                    select start_arr[ 1 + ( (random() * 25)::int) % 5 ]
                    FROM (
                         select '{alfred,harry,lisa,louise,mary}'::text[] as start_arr
                    ) syllarr,
                    generate_series(1, 1 + (generator*0))
               ) AS con_name_first(x)
    ),
    -- name_last
    (
        SELECT initcap(string_agg(x,''))  as name_last
               FROM (
                    select start_arr[ 1 + ( (random() * 25)::int) % 10 ]
                    FROM (
                         select '{fon,gra,le,rou,du,pont,pa,ris,mo,ra}'::text[] as start_arr) syllarr,
                   generate_series(1, 4 + (generator*0))
              ) AS con_name_last(x)
    ),
    generator as id
  FROM generate_series(1,10) as generator
 ) main_sub;



WITH dates AS (
     SELECT
   row_number() OVER () as rownum,
   day_with_hour_decay as base_date
  FROM (
      SELECT *

         FROM (
            select  base_day_dates + concat( ceil(random()*1440 )::text,' minutes')::interval as day_with_hour_decay
            FROM (
                        (
                           select
                              generate_series(current_timestamp - interval '8 years', current_timestamp - interval '3 day', '1 day') as base_day_dates
                         )
                 ) sub1
        ) sub2
    ) sub3
)

INSERT INTO letters (sender_id, receiver_id, delivered_by, sent_at)
SELECT
  receiver_id,
  sender_id,
  delivered_by,
  dates.base_date as sent_at
FROM (

     SELECT(
        SELECT x::int  as receiver_id
               FROM (
                    select id
                    FROM ( SELECT id FROM human order by random() LIMIT 1
                         ) randomid,
                   generate_series(1, 1 + (generator*0))
              ) AS y(x)
     ),
     (
        SELECT x::int  as sender_id
               FROM (
                    select id
                    FROM ( SELECT id FROM human order by random() LIMIT 1
                         ) randomid,
                   generate_series(1, 1 + (generator*0))
              ) AS y(x)
     ),
     (
        SELECT x::int  as delivered_by
               FROM (
                    select id
                    FROM ( SELECT id FROM owl order by random() LIMIT 1
                         ) randomid,
                   generate_series(1, 1 + (generator*0))
              ) AS y(x)
     ),
     (
        select  (generator % 2920) as base_date_num
     ),
     generator as id

     FROM generate_series(1,1000) as generator
) main_sub
INNER JOIN dates ON dates.rownum = main_sub.base_date_num;
