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
select concat(a.au_fname ,' ', a.au_lname) 'Author Name' 
from authors

(select title_id from titles where royalty>
(select avg(royalty) from titles))

select * from titles

--Qns 17 Print all the city and the number of pulishers in it, only if the city has more than one publisher
select * from sales

--Correction (after G3 discussion)


--Qns 28 Select the employees who have taken more than 2 orders
select emp_id
from employee
group by emp_id
having count(pub_id) > 2

 --Correction (after G3 discussion)
select store_id,count(ord_num) fro sales
from em
group by city
having count(pub_id)>1





