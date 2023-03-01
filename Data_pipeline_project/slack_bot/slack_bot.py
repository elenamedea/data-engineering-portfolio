import time
import requests
from sqlalchemy import create_engine, text
import psycopg2
import logging

time.sleep(10)


# Establish a connection to Postgres.

pg = create_engine("postgresql://postgres:*********@postgresdb:5432/tweets_db", echo=True)

webhook_url = "https://hooks.slack.com/services/*********"

logging.critical("Connection established.") 


# Get the tweets from postgres.

def get_tweets_from_pg():
    
    """

    This function gets the tweets from postgres database.

    """
    
    sl_tweets = []
    tweets = list(pg.execute('''SELECT * FROM tweets ORDER BY timestamp LIMIT 5;'''))
    for tweet in tweets:
        if tweet in sl_tweets:
            continue
        else:
            sl_tweets.append(tweet)

    logging.critical("Tweets loaded.")

    return sl_tweets



# Post the tweets in slack.

def post_in_slack(sl_tweets):
    
    """

    This functions posts the tweets in slack.
    
    """

    for tweet in sl_tweets:
        data = {'text': tweet[0]}
        requests.posts(url = webhook_url, json = data)




if __name__ = "__main__":
    sl_tweets = get_tweets_from_pg()
    post_in_slack(sl_tweets)




    


