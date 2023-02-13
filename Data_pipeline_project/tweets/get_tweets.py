# Import libraries.

import tweepy
import time
from credentials import bearer_token
from sqlalchemy import create_engine, text
import logging
import pymongo


# Authentication.


BEARER_TOKEN = bearer_token

tw_client = tweepy.Client(
    bearer_token = BEARER_TOKEN,
    wait_on_rate_limit = True,
)

HOST = "mongodb"
PORT = 27017
conn_string = f'mongodb://{HOST}:{PORT}'

mdb_client = pymongo.MongoClient(conn_string)
twitter_db = mdb_client.twitter


logging.critical("Connection established.") #This is like a special kind of printing.

# Search for Tweets.



search_query = "Balenciaga -is:retweet -is:reply -is:quote lang:en -has:links" # - means NOT
current_time = time.time()

# Get tweets.

while time.time() < current_time + 60:

    cursor = tweepy.Paginator(method= tw_client.search_recent_tweets,
        query = search_query,
        tweet_fields = ["author_id", "created_at", "public_metrics"]).flatten(limit = 200)

    time.sleep(2)

    for tweet in cursor:
        #logging.critical(dict(tweet))
        twitter_db.tweets.insert_one(dict(tweet))


print("Tweets successfully written.")
    


