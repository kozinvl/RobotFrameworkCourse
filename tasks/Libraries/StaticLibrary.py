# from robot.api import keyword
import os
import hashlib
import io
import logging


def get_files_directory(path):
    logging.debug("Has been this path %s", path)
    for root, dirs, files in os.walk(path):
        return files


def check_contain(array, file_name):
    logging.debug("Has been given list and file: %s", file_name)
    if file_name in array:
        return True
    else:
        logging.debug("List doesn't contain this file: %s", file_name)
        return False


def get_md5_sum(path):
    md5 = hashlib.md5()
    try:
        with io.open(path, mode="rb") as fd:
            content = fd.read()
        # hash object
            md5.update(content)
        # hash sum
    except StandardError:
        logging.debug("Something done wrong")
    return md5.hexdigest()
