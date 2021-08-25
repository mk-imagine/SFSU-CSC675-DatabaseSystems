# Milestone 2: The Relational Model 

The goal of this milestone is to create a complete technical document that will define in detail the logical 
design and architecture of your database system. Note that this milestone is a professional document that is read by 
technical and non-technical people and teams (i,e CEO, CTO, Project Managers, Founders, Engineers, Testers....).

The relational model defines how data in your database system is storage based on your design from milestone 1 
In this milestone, you are going to create the database model (EER) based in your ERD. Once the database model is created, 
it will be forwarded engineered, and then tested. The integration process of your database system is not part of this milestone, but will be done
in the final project. 

After milestone 2 is completed, M1 and M2 become a single technical DB document with all the documentation needed 
to understand the design and architecture of your database system.

## TODO Before Next Section 

**IMPORTANT: Milestone 1 and 2 will become the same document. So, all the work done in this milestone must be done
after section VI of milestone 1**

1. Update your milestone history table with this new milestone. In descending order. For example: 


| Milestone/Version |    Date    |
| ----------------- | ---------- |
|       M2          | 07/15/2020 |
|       M1          | 06/25/2020 |

***Note: the dates on the "Date" column are not the real deadlines of the milestones. I made them up to illustrate the concept***

2. Update the table of contents of the document with the new sections from this milestone that will be added to the 
actual document

3. Complete the following sections after section VI of your milestone 1

## Section VII: Database Model/EER

***Note: I strongly recommend to use MYSQLWorkBench for this section. Hand draw database models are not allowed here ***

1. Create the database model of your database system based on the final version of your ERD. Once the database model is 
completed. Export it as in image, or take a screen shot of it, and add it to this section. Note that screenshot must look 
professional (don't forget that this is a professional technical document about your database system). You can use 
MYSQLWorkBench to create the database model as taught in class. Your database must show clearly:
 
   * PK, FK and Unique keys
  
   * All the table attributes, and their data types
  
   * NOT NULL in attributes (if any)
  
   * Identifying relationships and non-identifying relationships. Both of them represented by solid and dashed lines in 
  the database model. 
  
   * All the cardinalities including those with zeros 
   
2. Save your database model as EER.mwb and add this file to the "files" folder  

3. Create a description (similar to the one below) of all the tables that implement ON DELETE AND ON UPDATE and all their possible 
constraints (CASCADE, SET NULL......). This description should include a detailed comment about your
motivations to select those tables as the ones that implement those constraints. 

|     Table     |       FK        |       ON DELETE        |        ON UPDATE        |                  Comment                        | 
| ------------- | --------------- | ---------------------- | ----------------------- | ----------------------------------------------- |
|    Account    |      user       |       ON CASCADE       |        ON CASCADE       | If a user is deleted, then the account from that user must be deleted as well
|    User       |      role       |       SET NULL         |        ON CASCADE       | If a role is deleted from the user table, the user that was holding that role will have no role until a new one is assigned.    

## Section VIII: Forward Engineering 

***Note: in this section, I strongly recommend to use MYSQLWorkBench for this section. Backward engineering is 
not allowed in this section***

The forwarding engineering process is the one that translate your database model (EER)  into the database schema 
that is used to create the physical database, tables and attributes in your database system

1. Before starting the forwarding engineering process of your database model, make sure to provide a meaningful name for your 
database schema. By default, MSQLWorkBench assign 'mydb'. Replace it with the name of your database + "DB" (i.e LibraryManagementDB)

2. Proceed with the forward engineering process of your database model as learned in class, and create a
file databasemodel.sql file that contains all the CREATE SQL statements from the forward engineering process

3. Modify the SQL code in your databasemode.sql, and create at least two triggers, one function and one procedure that will
solve different problems in the logic of your database system. For example, you would want to create a trigger that 
would help you to create accounts. So, once the user is inserted into the DB, the system automatically creates an account
for that user in your accounts table. 

4. Run databasemodel.sql script in your mysql instance to create your physical database schema and its tables 
in your system. This can be done in many different ways, but the most common are:

    * Run the databasemodel.sql script directly in your MYSQLWorkBench 
    
    * Open a SQL script windows MYSQLWorkBench, and copy and paste the content of databasemodel.sql there.
      Then, click on run.
      
    * Open a terminal windows, and connect to your MySQL instance, then execute the following command: 
       ```mysql
          mysql> source <path_to_your_sql_script>;
       ```

5. Put databasemodel.sql file in the 'files' folder

6. No need to add anything to the milestone2 document for this section. 

***Note: databasemodel.sql must run without errors when I run it in my machine***

## Section IX: Inserting Data 

In order to test your database system, it needs to have sample data that represents the scope and domain
of the real data that the user of your system will insert in your database. 

1. Create a file inserts.sql file. 

2. Add some comments on the top of the file to explain the context of this file

3. The first SQL code this file must have is the following: 

    ```mysql
       USE LibrarySystemDB; -- Replace LibrarySystemDB by the name of your database system
    ```
4. Insert some sample data in all your tables. ***Each table in your database must have at least three inserts.***
For instance, our library system database has three tables User, Book, and Account: 
    ```mysql
       -- Script name: inserts.sql
       -- Author:      Jose Ortiz
       -- Purpose:     insert sample data to test the integrity of this database system
       
       -- the database used to insert the data into.
       USE LibrarySystemDB; 
       
       -- User table inserts
       INSERT INTO User (user_id, name, dob) VALUES (1, 'Alice', 631152000), (2, 'Bob', 694742400), (3, 'Trudi', 958089600);
       
       -- Book table inserts
       INSERT INTO Book (ISBM, title, author) VALUES (87736778838, 'Database System Concepts', 'Avi Silberschatz'), (87736778838, 'Clean Code', 'Robert C. Martin'), (8773677564, 'The Art of Computer Programming', 'Donald E. Knuth');
   
       -- Account table inserts
       INSERT INTO Account (account_id, user, role) VALUES (1, 1, 'Admin'), (2, 2, 'user'), (3, 3, 'admin');
       
   ``` 
5. Run inserts.sql in your MySQL instance. Steps are the same as listed in Section VIII (4) but using inserts.sql
instead of databasemodel.sql file

6. Put inserts.sql file in 'files' folder

7. No need to add anything to the milestone 2 document for this section. 

***Note: inserts.sql must run without errors when I run it in my machine***

## Section X: Testing 

***Note: all the tables in your database must be tested in this section***

In this section, you will test the integrity of your database model using the sample data inserted in 
section IV

1. Create a tests.sql file

2. Follow steps (2) and (3) from section IX

3. For each table in your database, create two SQL queries that will test the integrity of your database system
using UPDATE and DELETE query statements. Make sure that you also test if your triggers, functions and procedures 
work as expected. For example: 

```mysql
       -- Script name: tests.sql
       -- Author:      Jose Ortiz
       -- Purpose:     test the integrity of this database system
       
       -- the database used to insert the data into.
       USE LibrarySystemDB; 
       
       -- 1. Testing User table
       DELETE FROM User WHERE name = 'Alice';
       UPDATE User SET user_id = 4 WHERE name = 'Trudi';
 ``` 

5. Run tests.sql in your MySQL instance. Steps are the same as listed in Section VIII (4) but using tests.sql
instead of databasemodel.sql file

6. If you get an error in a DELETE or UPDATE statement when running tests.sql perform the following steps: 
    i. Comment out the line that is throwing the error, add a comment with the error description, and enumerate it 
    (do not try to fix it)  
       for example the following test will fail: 
       ```mysql 
       -- 1. Error in Account UPDATE
           -- query: UPDATE Account SET user_id = 5 WHERE name = 'Trudi';
           -- Error: user_id referenced value cannot be found in the parent table. 
       ```
    ii. Truncate all the tables (add truncate statements at the beginning of this scripts) 
    iii. Run again the inserts.sql file from section IX
    iv. Repeat steps (5), [6(i)], [6(ii)] and [6(iii)] until the tests.sql file runs without errors. 

7. Put inserts.sql file in 'files' folder 

8. No need to add anything to milestone 2 document for this section. 

***Note: inserts.sql must run without errors after all the errors are commented out***
## Section XI: Testing Table 

***This section MUST be added to milestone 2 document***

Create a testing table in this section of the document with a structure similar to the one below. 
If a entity (table in the database scheme) passed the tests from section X. Then, set it to Pass. 
Otherwise, set it to Fails and state a general description of the error in the error description.  

***Note: all your entities (tables) must be defined in this testing table even if some of them passed 
all the test*** 

|   Entity  | SQLQuery  |  Pass/Fail |        Error Description            |                Possible Solution                    | 
| --------- |-----------|----------- |------------------------------------ | --------------------------------------------------- |
|  User     |   Delete  |   Pass     |  None                               |    None                                             |
|  User     |   Update  |   Pass     |  None                               |    None                                             |
|  Book     |   Delete  |   Fail     |  ISBN key not found                 |    key was misspelled, change it to ISBM, instead   |
|  Book     |   Update  |   Fail     |  value in title attribute not found |    forgot to truncate the tables, and insert again  |
|  Account  |   Delete  |   Pass     |  None                               |    None                                             |
|  Account  |   Update  |   Failed   |  Referenced PK does not exists      |    Add missing PK in User or use an existing one    |
      
*** Please do not try to fix errors in your database model in this milestone. They will be fixed in
your final project. I will use this table in your final project project as a reference to make sure 
that those errors were fixed ***

# Grading Rubrics 

0. This milestone completes the technical docs for your database system (M1 + M2 documents)

1. This milestone is worth 20% of your final grade, and will be graded using a point scale where the maximum possible grade 
   is 100 points. For example, a grade of 80/100 in this milestone will be converted to 0.80 * 20% = 16% of 20%

2. Milestones with one or more incomplete sections (submitted by the due date) will be returned. 
   Every time a milestone is returned, it is penalized with a reduction of 10 points from the final grade of the milestone

3. Late submissions will be penalized with 20 points of the final grade of this milestone. Once the milestone is due, 
   late submissions policies will apply for only one week. Milestones submitted one week after their original due date 
   will get the lowest possible grade. Milestones that are not turned in will get no points. 

4. Document formatting in technical docs. As a result of a bad document formatting, students
   will be penalized with 10 points in total. Note that each section must begin in a new page, and all pages must be 
   numbered.  

5. Each section of this milestone is worth 18 points. (5*18=90). The remaining 10 points will be applied to the improvements
made to the version of M1 concatenated to this document


# Submission Guidelines 

The due date for this milestone will be announced in class, on iLearn, Discord, and by email. The following are the 
submission guidelines that you need to follow:

1. The table of assignments (found in main README file) must be updated to "completed/done" for this milestone. 
Milestones set to 'not completed' won't be graded because I will assume that it was not turned it. Note that this table 
is the first thing I check when I grade a milestone. 

2. The name of your document must be M2.pdf 

3. Milestones documents must be submitted in PDF format. Otherwise, they will be returned and the grade penalization 
policies described in the grading rubrics section will be applied.

4. Milestones documents must be hosted in the master branch of your class repository by the deadline. 
(DatabaseSystems/milestones/milestone2/M2.pdf).

5. Milestones documents that are sent by email, or hosted in personal repositories won't be graded, and will be considered as
not submitted. I will only grade milestones documents hosted in your class repository. ***No exceptions***




