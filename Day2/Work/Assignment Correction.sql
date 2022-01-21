use pubs


--Qns 11 Print the first published title in every type (Difficult)
select title
from titles
where title in (
select count(title),type, min(pubdate)
from titles
group by type)
group by type

--Correction (after G3 discussion)
select type, min(pubdate)'First published' from titles group by type

--Qns 16 Print the author name of books which have more royalty than the average royalty of all the titles (Difficult)
select concat(a.au_fname ,' ', a.au_lname) Author_Name 
from authors a 
join titleauthor ta on a.au_id=ta.au_id
join titles t on t.title_id=ta.title_id
where t.title_id in(
select title_id
from titles 
having avg(royalty)< royalty)

--Correction (after G3 discussion)
select concat(au_fname,' ',au_lname) from authors where au_id in
(select au_id from titleauthor where title_id in
(select title_id from titles where royalty>
(select avg(royalty) from titles))

--Qns 17 Print all the city and the number of pulishers in it, only if the city has more than one publisher
select * from sales

--Correction (after G3 discussion)
select city,count(pub_id) 'No of publishers' from publishers
group by city
having count(pub_id)>1 

--Qns 28 Select the employees who have taken more than 2 orders
select emp_id
from employee
group by emp_id
having count(pub_id) > 2

 --Correction (after G3 discussion)
select stor_id, count(ord_num) 'Number of orders' from sales
group by stor_id
having count(ord_num)>2





