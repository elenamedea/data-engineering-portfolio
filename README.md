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


## Twitter Sentiment Analysis Project

This is a Natural Language Processing project on Sentiment Analysis using RoBERTa model to predict the emotion (positive, negative or neutral) of tweets regarding the keyword 'Balenciaga'. 

This term was choosen in order to investigate the crisis that engulfed the designer brand in late November 2022 after backlash to an ad campaign featuring S&M-inspired products alongside children boiled over, resulting in social media outrage, cable news takedowns, vandalism and protests at stores. 

<p align="center">
  <img src="https://github.com/elenamedea/data-engineering-portfolio/blob/main/Twitter_Sentiment_Analysis_project/balencigaga_crisis.png"/>
</p>

The twitter footprint of such a scandal can give us insight on the society reflexes towards controversies  as well as business analytics on damage control.

Tweets were scraped with snscrape library, which, unlike Tweepy, doesn't require use of API keys and allows one to scrape historical data. 

In the first version of the notebook, a total of 1000 tweets were collected from 01.12.2022 to 02.12.2022. The data were stored in an Elasticsearch index.

Subsequently, they were quered in order to be cleaned and preprocessed before they were sent for an ETL job, where RoBERTa model was utilized.

The resulted processed tweets and sentiment analysis results went through a preliminary Exploratory Data Analysis (EDA) and were stored to another Elasticsearch index.

### To Do:
- Utilize emojis instead of excluding them from the Sentiment Analysis
- Compare RoBERTa with *e.g.* VADER
- Set up Kibana as dashboard
- Gather cleaning and preprocess functions in a python class
- Repeat project for streaming data using Tweepy, pySpark and Kafka
- Dockerize ł Cloud computing ł Airflow
