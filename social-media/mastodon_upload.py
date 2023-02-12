#!/usr/bin/env python

import argparse
from os.path import expanduser
import json

from mastodon import Mastodon

import logging
logger = logging.getLogger(__name__)



def upload(filename,message):

    try:

        with open(expanduser('~/.secrets/mastodon.json')) as f:
            auth_data = json.load(f)
        
        m=Mastodon(**auth_data)


        metadata = m.media_post(filename, "image/png")
        m.status_post(message, media_ids=metadata["id"])


    except KeyboardInterrupt:
        print('Terminated by user')

    except Exception as e:
        logger.exception('STOPPED: %s' % e)





if __name__ == '__main__':

    parser = argparse.ArgumentParser(
        description='Post media to Mastodon')
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
