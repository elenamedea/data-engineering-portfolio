# Data Engineering portfolio

## Building a Dashboard with Metabase, PostgreSQL and AWS 

<div align="justify">In this project, I built an interactive online dashboard summarizing the Northwind Database, a sample database, which is shipped along with Microsoft Access and refers to sales data of the fictional company "Northwind Traders".
 
The database was created from .csv files with PostgreSQL and hosted in a cloud database (AWS RDS). The dashboard was created with Metabase that was installed on a virtual server (AWS RC2) and connected to the cloud database.</div><br>

<div align="justify">Due to costs, both the AWS database and the virtual server has been deleted, therefore the dashboard is not available online anymore.</div><br> 

<div align="justify">These are some static screenshots of the dashboard:</div><br> 

<p align="center">
  <img src="https://github.com/elenamedea/data-engineering-portfolio/blob/main/Dashboard_project/northwind_1.png"/>
  <img src="https://github.com/elenamedea/data-engineering-portfolio/blob/main/Dashboard_project/northwind_2.png"/>
  <img src="https://github.com/elenamedea/data-engineering-portfolio/blob/main/Dashboard_project/northwind_3.png"/>
</p>

<br>
Entity-Relationship Diagram with DbSchema.  

<p align="center">
  <img src="https://github.com/elenamedea/data-engineering-portfolio/blob/main/Dashboard_project/er_diagram_northwind.png"/>
</p>



## The Data Pipeline: Tweets Sentiment Analysis

<p align="center">
  <img src="https://github.com/elenamedea/data-engineering-portfolio/blob/main/Data_pipeline_project/pipeline_workflow.png"/>
</p>


<div align="justify">The goal of current Data Engineering project is to build a Dockerized Data Pipeline which analyzes the Sentiment of Tweets. Firstly, using Tweepy API, tweets of a selected topic are collected and stored in a MongoDB database. Subsequently, the Sentiment of Tweets is analyzed and the tweets together with their scores are stored in a Postgres database. Finally, the processed tweets are sent periodically from Postgres database to a slack channel. </div><br>

