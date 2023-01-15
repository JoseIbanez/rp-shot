#!/usr/bin/env python

import argparse
from os.path import expanduser
import json

import tweepy
import logging

logger = logging.getLogger(__name__)

def upload(filename,message):

    try:

        with open(expanduser('~/.secrets/twitter.json')) as f:
            auth_data = json.load(f)
        
        auth = tweepy.OAuth1UserHandler(**auth_data)
        api = tweepy.API(auth)

        media = api.media_upload(filename=filename)
        print("MEDIA: ", media.media_id)

        tweet = api.update_status(status=message, media_ids = [media.media_id_string])
        print("TWEET: ", tweet.text)



    except KeyboardInterrupt:
        print('Terminated by user')

    except Exception as e:
        logger.exception('STOPPED: %s' % e)





if __name__ == '__main__':

    parser = argparse.ArgumentParser(
        description='Request any Twitter Streaming or REST API endpoint')
    parser.add_argument(
        '-oauth',
        metavar='FILENAME',
        type=str,
        help='file containing OAuth credentials',
        default=expanduser("~/.secrets/twitter"))
    parser.add_argument(
        '-file',
        metavar='FILENAME',
        type=str,
        help='image to upload',
        required=True)
    parser.add_argument(
        '-text',
        metavar='NAME_VALUE',
        type=str,
        help='text to send',
        default='My picture')
    args = parser.parse_args()


    upload(args.file,args.text)
