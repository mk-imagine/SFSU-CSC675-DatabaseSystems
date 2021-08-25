# Milestone 1: The Semantic-Conceptual Model 

The goal of this milestone is to create a complete technical document that will define in detail the conceptual 
design and architecture of your database system. Note that this milestone is a professional document that is read 
by technical and non-technical people and teams (i,e CEO, CTO, Project Managers, Founders, Engineers, Testers....).

## Cover Page

This page must contain the title of your project (i.e Library Management System ), your name, student id and GitHub  username, and finally, a version history table similar 
to the one in the below:

| Milestone/Version |    Date    |
| ----------------- | ---------- |
|       M1V1        | 06/07/2020 |

## Table of Contents

A technical document like this one is read by technical and non-technical people (i,e CEO, founders, 
engineers....). So, some of them would want to have access to specific sections of this milestone directly and 
skip some others. A table of contents with page numbers will help them to access quickly to all the content in 
this milestone
   

## Section I: Project Description

In this section, you are going to create a complete description of the idea for your database system project. 
This is a high level description since at this point, the scope of the database system that you are about to create 
is not clear yet. The project description should define clearly the technical/business problems you are trying to solve. 
Focus on problems in the scope of database systems. Put time on this section because all the user cases that you are going to create
in the next section must be strictly related with this section


## Section II: Use Cases 

Based on your project description, **create at least five use cases for all the main entities and actors in your system.**
Refer to class slides to learn more about how to create good use cases for your system. 
Take into consideration that having good use cases will help to extract good 
database requirements for your system. Use at least one of your use cases to define a possible failure in your system, 
and how to recover from it. For example, taking into consideration the example from section I, 
a good use case for that system would be:

"Marie wants to rent a book from library X (X is your system´s name), the system asks Marie to register first as a 
prerequisite to rent the book. Marie register into the system, and then login in her account. Then, she can search 
for the book she wants to rent. Marie finds a good book and starts the renting process. During the process, 
she decides that she needs an additional book. However, the system does not let her to rent a new book until 
the process of renting the first one is done." 

As you can see, this is a good use case because is using three main entities, 
and one specific problem that our system should be able to solve with a good DB design. 

## Section III: Database Requirements (Business Rules)

***Note: In this section, students must create database requirements based on the user cases from section II. They
must cover all your entities and relations that will exist in your database system.***

Business rules are database requirements that are extracted from use cases. A good business rules contains: 
(1) two or more entities, (2) one or more rules defining a relationship between such entities, 
(3) all the entities must be quantifiable, and (4) one or more optional conditions. 
Quantifiable entities are defined by the many, one or zero quantities. 

Database requirements must be enumerated and grouped by the entity that performs the action 
so later they are easy to find in the document. 

Example of database requirements extracted from our use case example given in section II: 

    1. User 
        1.1. A user shall create only one account 
        1.2. A user shall be able to rent multiple books at once before checking out
        1.3. A user shall have at least one role.

    2. Account 
        2.1. An account shall be created by only one user. 
    
    3. Role
        3.1 A role shall be linked to many users. 
    
    4. Book
        4.1 A book can be rented by multiple users

Database requirements listed in this section must cover ALL the following relationships:

1. Many-to-Many
2. One-to-One
3. Many-to-One
4. One-to-Many
5. ISA
6. Aggregation 
7. Recursive

 

## Section IV: Detailed List of Main Entities, Attributes and Keys 

***Note: In this section, students must create at least 16 strong entities, and each entity must have 
at least three or more attributes. Failure to meet those guidelines will result in your milestone being returned with
a grade reduction.***

In this section, you must describe entities and their attributes for your database system, including keys and 
attributes details (data type and form). For example using our two business rules from section III. A good list would be:

      1. User (Strong)
          * user_id: key, numeric 
          * name: composite, alphanumeric
          * dob: multivalue, timestamp
          
      2. Book (Strong)
          * ISBM: key, alphanumeric
          * title: composite, alphanumeric
          * author: composite, alphanumeric
      
      3. Role (Strong)
          * role_id: key, numeric
          * description: alphanumeric
      
      3. Account (Weak)
          * id: key, numeric 
          * user: key, numeric 
          * role: key, numeric
          


***Give meaningful names to your entities and your attributes. For instance 't' is not a good
attribute name for the title of the book***

## Section V: Entity Relationship Diagram (ERD) 

***Note: all your entities from section IV must be in this diagram***

Based on your database requirements from section III and the entities and attributes from section IV, create a Entity
Relationship Diagram (ERD) that will represent the conceptual high level architecture of your database system.  

***Note: hand drawing diagrams are not allowed in this section***

This ERD must be done using a software tool that supports drawing diagrams. I strongly recommend for this section to
use [draw.io](https://www.draw.io) 



## Section VI: Testing Table 

This section must be done concurrently with section V. Create a testing table similar to the one below with all the relationships in your ERD, and test it as learned in class. 
If any of your tests fails, please fix your ERD, but do not update the test table to pass. 
That way, when I see that a relationship failed in your testing table, I can go back to your ERD and see how you fixed it. 

Testing table example:

| Rule | Entity A  |  Relation |  Entity B | Cardinality  | Pass/Fail  |           Error Description               |  
|------|-----------|-----------|-----------|--------------|------------|-------------------------------------------|
|  1   |   User    |  Creates  |  Account  |    1-to-1    |    Fail    |  Users can create many accounts with different emails/usernames         | 
|  2   |   User    |  Rents    |  Book     |    M-to-N    |    Pass    |                None                       |

***Important Note: students must keep track of all the mistakes they do during the complexion of section V. 
At first, all the ERDs have conceptual/logical mistakes because when the ERD is created for the first time, 
we don't have access yet to the complete flow of the diagram. The second time the ERD is reviewed, we can see the whole 
picture and more mistakes would be found. So, if your testing table is all set to pass, 
points will be taken off from this section. I am really interested in the mistakes students did in section V, 
and the approach taken to fix them. ***



# Grading Rubrics 

1. This milestone is worth 20% of your final grade, and will be graded using a point scale where the maximum possible grade 
   is 100 points. For example, a grade of 80/100 in this milestone will be converted to 0.80 * 20% = 16% of 20%

2. Milestones with one or more incomplete sections (submitted by the due date) will be returned. 
   Every time a milestone is returned, it is penalized with a reduction of 10 points from the final grade of the milestone

3. Late submissions will be penalized with 20 points of the final grade of this milestone. Once the milestone is due, 
   late submissions policies will apply for only one week. Milestones submitted one week after their original due date 
   will receive the lowest possible grade.

4. Good formatting in technical documents is really important. There are non-technical individuals that would want to read 
   only some specific sections of your document. That is why your document formatting must be good. (e.g including table 
   of contents and page numbers) As a result of a bad document formatting, students will be penalized with 10 points in total  

5. Each section of this milestone is worth 16 points. (6*16=96). The remaining four points will be given only if the student
   meets the requirements for the cover page and table of contents pages. 


# Submission Guidelines 

The due date for this milestone will be announced in class, on iLearn, Discord, and by email. The following are the 
submission guidelines that you need to follow:

1. The table of assignments (found in main README file of your repository) must be updated to "completed/done" for this milestone. 
Milestones set to 'not completed' won't be graded because I will assume that it was not turned in. 

2. The name of your document must be M1.pdf, and must be submitted in PDF format. Otherwise, the milestone will 
be re



turned and the grade penalization policies described in the grading rubrics section will be applied.

4. Milestone 1 document must be hosted in the master branch of your class repository 
(DatabaseSystems/milestones/milestone1/M1.pdf).

5. Milestones documents that are sent by email, or hosted in personal repositories won't be graded, and will be considered as
not submitted. I will only grade milestones documents hosted in your class repository.***No exceptions***












