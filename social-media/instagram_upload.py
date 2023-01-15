#!/usr/bin/env python


import argparse
import json
from instabot import Bot
from os.path import expanduser
import os
import glob
import shutil


def main():


    parser = argparse.ArgumentParser(
        description='Upload to instagram')
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

    file = args.file
    caption = args.text

    #clean_up(file)
    rm_cookie()

    with open(expanduser("~/.secrets/instagram")) as json_file:
        credentials = json.load(json_file)
    username = credentials.get("username")
    password = credentials.get("password")


    bot = Bot()
    bot.login(username=username)

    bot.upload_photo(file, caption=caption)

def rm_cookie():
    cookie_del = glob.glob("config/*cookie.json")
    os.remove(cookie_del[0])


def clean_up(i):
    dir = "config"
    remove_me = "/tmp/{}.REMOVE_ME".format(i)
    # checking whether config folder exists or not

    if os.path.exists(dir):
        try:
            # removing it so we can upload new image
            shutil.rmtree(dir)
        except OSError as e:
            print("Error: %s - %s." % (e.filename, e.strerror))

    if os.path.exists(remove_me):
        src = os.path.realpath("imgs\{}".format(i))
        os.rename(remove_me, src)


if __name__ == '__main__':
    main()
