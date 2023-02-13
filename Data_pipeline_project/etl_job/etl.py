# Import libraries.

import pandas as pd
import time
import logging

import pymongo

from sqlalchemy import create_engine
import psycopg2

from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer


# Connect to Mongodb.

HOST = "mongodb"
PORT = 27017
conn_string = f"mongodb://{HOST}:{PORT}"


mdb_client = pymongo.MongoClient(conn_string)
twitter_db = mdb_client.twitter
time.sleep(10)  

"""

Print few entries--Sanity check

test = db.tweets.find(limit = 5)
for doc in test:
    print(doc)

    """

logging.critical("Connection established.")



# Access the postgres database.

pg = create_engine('postgresql://postgres:*****@postgresdb:5432/tweets_db', echo=True)

# Create a postgres table for inserting transformed tweets.

pg.execute('''
    CREATE TABLE IF NOT EXISTS tweets (
    text VARCHAR(500),
    sentiment NUMERIC,
    timestamp VARCHAR(500)
);
''')


# Extract data from mongodb.

def extract():

    """

    This function extracts tweets from the mongo db.

    """

    extracted_tweets = list(twitter_db.tweets.find())
    return extracted_tweets


# Transform the data (add value to the data).

def transform(extracted_tweets):

    """

    This functions tranforms the tweets by cleaning and scoring.

    """

    s = SentimentIntensityAnalyzer()
    transformed_tweets = []

    for tweet in extracted_tweets:
        sentiment = s.polarity_scores(tweet["text"])
        tweet["sentiment"] = sentiment["compound"]
        transformed_tweets.append(tweet)
    
    return transformed_tweets


# Load the data into a postgres database.

def load(transformed_tweets):

    """

    This function loads the transformed tweets into a postgres database.

    """

    for tweet in transformed_tweets:

        query = "INSERT INTO tweets VALUES (%s, %s, %s);"
        pg.execute(query, (tweet["text"], tweet["sentiment"], tweet["created_at"]))

        logging.critical("A new tweet is inserted into postgres.")



if __name__ == "__main__":

#uncomment while and time.sleep() to run it ever 3' 
    #while True:
    entries = extract()
    entries = transform(entries)
    load(entries)

    #time.sleep(180)

    
