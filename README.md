## About this project

Hello !

You may be on this repository because you have seen my talk on EXPLAIN.
Welcome !

On this repository you will find a dump of the database, a few SQL lines used to generate data, and the queries used during this talk.


## Lost the slides ?

Here they [are](https://fr.slideshare.net/LouiseGrandjonc/becoming-a-better-developer-with-explain)


## How to get started with this project ?

# Create the database

First you need to create a database

```console
CREATE DATABASE owl_conference WITH OWNER owl;
```

Then you can simply use the dump, in your shell

```console
$ psql owl_conference < sql/dump.sql
```

I put the code using `generate_series` that I used to generate humans and letters (with random foreign keys to humans).
You can see that in `sql/01_generate_data.sql`

# Test the python joins

Use a virtualenv with `django` and `psycopg2` installed.

Then you can do

```console
$ python manage.py shell
```

Try the `hash_join` and the `nested_loop` like this

```console
>>> from owl.utils.joins import *
>>> data = nested_loops()
>>> print(data[0].job)
>>> data = hash_join()
>>> print(data[0].job)
```

You can try the `suspicious_letters` from the slide 44 of the talk by running in the python shell

```console
>>> from owl.utils.examples import *
>>> data = suspicious_letters()
>>> print(data)
```

# Test the queries

In the `sql/02_queries.sql` you have all the queries from the conference. The last one is the funiest one ;)

Go into your psql and try looking at the `EXPLAIN` :)

```console
$ psql owl_conference
```