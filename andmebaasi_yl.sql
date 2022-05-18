
# Ülesanne 21.1
SELECT * FROM bookstore.books;
;

# Ülesanne 21.2
SELECT * 
FROM bookstore.books 
WHERE release_date > 2009 
AND type = "new" 
ORDER BY title 
;

# Ülesanne 21.3
SELECT title, release_date, price, type 
FROM bookstore.books 
WHERE release_date < 1970 AND type = "used" AND price < 20 
;

# Ülesanne 21.4
SELECT COUNT(order_date) as "Tellimuste arv", YEAR(order_date) as "Aasta" 
FROM bookstore.orders 
GROUP BY YEAR(order_date)
;

# Ülesanne 21.5
SELECT YEAR(order_date) as "aasta", round(sum(price),2) as "summa", count(order_date) as "tellimuste arv" 
FROM (select order_date, b.price from orders as o LEFT JOIN books as b ON o.book_id = b.id )o
GROUP BY YEAR(order_date)
;

# Ülesanne 21.6
SELECT YEAR(order_date) as "aasta", COUNT(order_date) as "tellimuste arv", ROUND(SUM(price), 2) AS "hind kokku"
FROM bookstore.orders
LEFT JOIN bookstore.books 
ON bookstore.orders.book_id = bookstore.books.id
GROUP BY YEAR(order_date) DESC
LIMIT 1
;

# Ülesanne 21.7
SELECT c.first_name, c.last_name, round(sum(price), 2) 
FROM orders o LEFT JOIN books b ON b.id=o.book_id LEFT JOIN clients c ON c.id=o.client_id 
WHERE year(order_date) = 2017 
GROUP BY client_id 
ORDER BY sum(price) DESC
;

# Ülesanne 21.8
SELECT books.title, COUNT(book_id) AS "müüdud raamatute arv"
FROM bookstore.orders orders
LEFT JOIN bookstore.books books
ON orders.book_id = books.id
WHERE YEAR(order_date) IN (SELECT MAX(YEAR(order_date)) FROM orders)
GROUP BY book_id
ORDER BY COUNT(book_id) DESC
LIMIT 10
;

# Ülesanne 21.9
SELECT * FROM  bookstore.books 
WHERE price > (SELECT avg(price) FROM bookstore.books)
;





# Ülesanne 22.1
SELECT sum(stock_saldo * price)  
FROM bookstore.books
;

# Ülesanne 22.2
SELECT round(min(price), 2), round(max(price), 2), round(avg(price), 2) 
FROM bookstore.books
;

# Ülesanne 22.3
SELECT round(max(price), 2) 
FROM bookstore.books 
WHERE type = "used"
;

# Ülesanne 22.4
SELECT 
CASE
	WHEN books.type = "new" THEN "uus"
    WHEN books.type = "used" THEN "kasutatud"
    WHEN books.type = "ebook" THEN "e-raamat"
    ELSE "viga"
END AS "tüüp", ROUND(AVG(books.price), 2) AS "keskmine hind", COUNT(books.id) AS "kogus"
FROM bookstore.books books
GROUP BY books.type
;
    
# Ülesanne 22.5
SELECT books.title, books.price, books.type
FROM bookstore.books books
WHERE books.type = "used"
AND books.price > (SELECT AVG(books.price) FROM books WHERE books.type = "new")
ORDER BY books.price ASC
;

# Ülesanne 22.6
SELECT *
FROM bookstore.books
WHERE price > (
	SELECT
        
        
        
        
WHERE price > (
		SELECT AVG(price)
        FROM bookstore.orders
        LEFT JOIN bookstore.book_authors
        ON orders.book_id = book_authors.book_id
        LEFT JOIN bookstore.books
        ON books.id = book_authors.book_id
        GROUP BY book_authors.author_id
        ORDER BY COUNT(orders.book_id) DESC
        LIMIT 1			
        )

# Ülesanne 22.7
SELECT *
FROM bookstore.books
WHERE books.release_date % 2 = 0
;

# Ülesanne 22.8
SELECT language, COUNT(language)
FROM bookstore.books
GROUP BY language
ORDER BY COUNT(language) DESC
LIMIT 3
;




# Ülesanne 23.1
INSERT INTO clients (username, first_name, last_name, email, password, address)
VALUES ("mari", "mammu", "maasikas", "mari@mari", "iram", "metsalagendik")
;

# Ülesanne 23.2
UPDATE books
SET language = "eesti"
WHERE id = 1
;

# Ülesanne 23.3
DELETE FROM orders
WHERE id = 2300
;

# Ülesanne 23.4
INSERT INTO clients (username, first_name, last_name, email, password, address)
VALUES 
	("mari_1", "mammu", "maasikas", "mari_1@mari", "1_iram", "metsalagendik_1-1"),
    ("mari_2", "mammu", "maasikas", "mari_2@mari", "2_iram", "metsalagendik_1-2"),
    ("mari_3", "mammu", "maasikas", "mari_3@mari", "3_iram", "metsalagendik_1-3"),
    ("mari_4", "mammu", "maasikas", "mari_4@mari", "4_iram", "metsalagendik_1-4"),
    ("mari_5", "mammu", "maasikas", "mari_5@mari", "5_iram", "metsalagendik_1-5")
;

# Ülesanne 23.5
INSERT INTO orders (delivery_address, order_date, status, client_id, book_id)
VALUES ("V_for", "2022-12-03 00:00:00.000", "sent", (SELECT id FROM books WHERE title = "Vendetta"), (SELECT id FROM clients WHERE username = "mcage1o"))
;

# Ülesanne 23.6
UPDATE books
SET price = price * 1.05, pages = pages + 5
;

# Ülesanne 23.7
DELETE FROM authors
WHERE id NOT IN (
	SELECT authors.id
    FROM book_authors
    WHERE authors.id = book_authors.author_id
)
;










