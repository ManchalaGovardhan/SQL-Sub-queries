/*Problem 1
Display the names of athletes who won a gold medal in the 2008 Olympics and whose height is greater than the average height of all athletes in the 2008 Olympics. */
use task35;
select name,Height from athlete_events where Year=2008 and Height >(select avg(Height) from athlete_events where Year=2008);
/* Problem 2
Display the names of athletes who won a medal in the sport of basketball in the 2016 Olympics and whose weight is less than the average weight of all athletes who won a medal in the 2016 Olympics. */
select name,medal ,Weight from athlete_events where sport='basketball' and medal !='NA' and Year=2016 and weight<(select avg(weight) from athlete_events where medal !='Na' and Year=2016); 
/*Problem 3
Display the names of all athletes who have won a medal in the sport of swimming in both the 2008 and 2016 Olympics. */
select name,year,sport from athlete_events where medal !='NA' and sport='Swimming' and Year=2008 and name in(select name from athlete_events where medal!='NA' and sport='Swimming' and Year=2016);
/*Problem 4
Display the names of all countries that have won more than 50 medals in a single year. */
select Team from (select Team,Year,count(*) from athlete_events where medal !='NA' group by Team,Year having count(*) >50) as t1;
/* Problem 5
Display the names of all athletes who have won medals in more than one sport in the same year.*/
select name ,year,count(*) from athlete_events where medal!='NA' group by name,Year having count(*)>1;
/* Problem 6
What is the average weight difference between male and female athletes in the Olympics who have won a medal in the same event? */
SELECT AVG(ABS(m.avg_weight - f.avg_weight)) AS overall_avg_diff
FROM (
    SELECT event, AVG(weight) AS avg_weight
    FROM athlete_events
    WHERE medal != 'NA' AND sex = 'M'
    GROUP BY event
) AS m
JOIN (
    SELECT event, AVG(weight) AS avg_weight
    FROM athlete_events
    WHERE medal != 'NA' AND sex = 'F'
    GROUP BY event
) AS f
ON m.event = f.event;

use task35;
select * from insurance_data;
/* Problem 7
How many patients have claimed more than the average claim amount for patients who are smokers and have at least one child, and belong to the southeast reg */
select count(PatientID) from insurance_data where claim >(select avg(claim) from insurance_data where (smoker,children,region) in (select smoker,children,region from insurance_data where smoker='Yes' and children>=1 and region='southeast'));
/* Problem 8
How many patients have claimed more than the average claim amount for patients who are not smokers and have a BMI greater than the average BMI for patients who have at least one child? */
select count(PatientID) from insurance_data where claim >(select avg(claim) from insurance_data where smoker='No' and bmi>(select avg(bmi) from insurance_data where children>=1));
/* Problem 9
How many patients have claimed more than the average claim amount for patients who have a BMI greater than the average BMI for patients who are diabetic, have at least one child, and are from the southwest region?*/
select count(PatientID) from insurance_data where claim >(select avg(claim) from insurance_data where smoker='No' and bmi>(select avg(bmi) from insurance_data where children>=1 and diabetic='Yes'and region='southeast'));
/* Problem 10:
What is the difference in the average claim amount between patients who are smokers and patients who are non-smokers, and have the same BMI and number of children? */

SELECT 
    s.BMI,
    s.children,
    (s.avg_claim - ns.avg_claim) AS avg_claim_diff
FROM
    (SELECT BMI, children, AVG(claim) AS avg_claim
     FROM insurance_data
     WHERE smoker = 'Yes'
     GROUP BY BMI, children) s
JOIN
    (SELECT BMI, children, AVG(claim) AS avg_claim
     FROM insurance_data
     WHERE smoker = 'No'
     GROUP BY BMI, children) ns
ON s.BMI = ns.BMI AND s.children = ns.children;

