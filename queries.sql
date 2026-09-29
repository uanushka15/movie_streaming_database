-- Example queries for the Movie Streaming Database
-- Run moviestreaming_database.sql first.

USE moviestreaming;

-- 1. Top 10 highest-rated movies (catalogue rating)
SELECT movie_id, title, release_year, language, rating
FROM Movies
ORDER BY rating DESC, title
LIMIT 10;

-- 2. Most-watched movies (number of views)
SELECT m.movie_id, m.title, COUNT(*) AS total_views
FROM Watch_History w
JOIN Movies m ON m.movie_id = w.movie_id
GROUP BY m.movie_id, m.title
ORDER BY total_views DESC, m.title
LIMIT 10;

-- 3. Number of subscribers per plan
SELECT plan, COUNT(*) AS subscribers
FROM Subscription
GROUP BY plan
ORDER BY subscribers DESC;

-- 4. Average user score per movie (from Ratings)
SELECT m.title,
       ROUND(AVG(r.score), 2) AS avg_user_score,
       COUNT(*) AS num_ratings
FROM Ratings r
JOIN Movies m ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
ORDER BY avg_user_score DESC, num_ratings DESC
LIMIT 10;

-- 5. Every movie with its genres in one line
SELECT m.movie_id, m.title,
       GROUP_CONCAT(g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
FROM Movies m
JOIN Movie_Genre mg ON mg.movie_id = m.movie_id
JOIN Genres g ON g.genre_id = mg.genre_id
GROUP BY m.movie_id, m.title
ORDER BY m.movie_id;

-- 6. Users who have no subscription
SELECT u.user_id, u.username, u.signup_date
FROM Users u
LEFT JOIN Subscription s ON s.user_id = u.user_id
WHERE s.subscription_id IS NULL;

-- 7. Users with an active subscription on a given date
SELECT u.username, s.plan, s.start_date, s.end_date
FROM Subscription s
JOIN Users u ON u.user_id = s.user_id
WHERE '2024-01-01' BETWEEN s.start_date AND s.end_date
ORDER BY s.plan, u.username;

-- 8. Top 5 users by total minutes watched
SELECT u.user_id, u.username, SUM(w.watched_minutes) AS total_minutes
FROM Users u
JOIN Watch_History w ON w.user_id = u.user_id
GROUP BY u.user_id, u.username
ORDER BY total_minutes DESC
LIMIT 5;

-- 9. Genre popularity by number of views
SELECT g.genre_name, COUNT(*) AS views
FROM Watch_History w
JOIN Movie_Genre mg ON mg.movie_id = w.movie_id
JOIN Genres g ON g.genre_id = mg.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY views DESC;

-- 10. Completion rate per movie (movies with at least 2 views)
SELECT m.title,
       COUNT(*) AS views,
       SUM(w.completed) AS completed_views,
       ROUND(100 * SUM(w.completed) / COUNT(*), 1) AS completion_pct
FROM Watch_History w
JOIN Movies m ON m.movie_id = w.movie_id
GROUP BY m.movie_id, m.title
HAVING COUNT(*) >= 2
ORDER BY completion_pct DESC, views DESC;