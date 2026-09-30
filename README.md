# Movie Streaming Database -

A relational database for a movie streaming platform, covering users, movies, genres, subscriptions, watch history and ratings. This repository contains the database design, documentation and sample data; the front end is under development.

## Tools Used -

- MySQL Workbench

## Repository Contents -

| File / Folder | Description |
|---|---|
| `moviestreaming_database.sql` | Creates the database, all 7 tables, and loads the sample data |
| `queries.sql` | Example queries that demonstrate the tables working together |
| `docs/` | ER diagram, database schema, entity relationships, functional dependencies and normalization |

## How to Run -

1. Open **MySQL Workbench** and connect to your local MySQL server.
2. Open `moviestreaming_database.sql` (File → Open SQL Script).
3. Run the whole script (lightning bolt icon, or `Ctrl+Shift+Enter`).
4. Open `queries.sql` and run the queries one at a time to explore the data.


## Tables and Expected Row Counts -

After a successful run, each table should contain:

| Table | Purpose | Rows |
|---|---|---|
| `Users` | Registered users | 50 |
| `Movies` | Movie catalogue | 50 |
| `Genres` | Genre list | 15 |
| `Movie_Genre` | Links movies to genres (many-to-many) | 129 |
| `Subscription` | Subscription plan and dates for each user | 45 |
| `Watch_History` | Which user watched which movie, when, and for how long | 68 |
| `Ratings` | Score and review a user gave a movie | 56 |



## Relationships -

- **Users ↔ Subscription:** each subscription belongs to one user (`Subscription.user_id`).
- **Users ↔ Movies (watches):** many-to-many through `Watch_History`.
- **Users ↔ Movies (rates):** many-to-many through `Ratings`, one rating per user per movie.
- **Movies ↔ Genres:** many-to-many through `Movie_Genre`.

Load order matters because of foreign keys: `Users`, `Movies` and `Genres` first, then `Movie_Genre`, `Subscription`, `Watch_History` and `Ratings`. The script already follows this order.

## Normalization -

All tables are in 1NF, 2NF and 3NF (and BCNF). The step-by-step proof with functional dependencies is in the `docs/` folder.

## Notes About the Data -

- All data is **sample data** created for demonstration.
- Emails use the `example.com` domain, and the values in the `password` column are **dummy strings, not real credentials or real hashes**.
- Movie titles are real, but durations, ratings, reviews, subscriptions and viewing activity are illustrative.
- `Movies.rating` is a catalogue rating, while `Ratings.score` is the score given by the platform's own users. They are stored separately and are not derived from each other.

## Front End -

The front end is in progress and currently works with the sample data above.
