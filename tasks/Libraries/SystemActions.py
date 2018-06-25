# from robot.api import keyword
import os
import hashlib
import io
import logging


class SystemActions:

    def __init__(self, path):
        self.path = path

    def get_files_directory(self):
        logging.debug("Has been this path %s", self.path)
        for root, dirs, files in os.walk(self.path):
            return files

    def check_contain(self, array, file_name):
        logging.debug("Has been given list and file: %s", file_name)
        if file_name in array:
            logging.debug("File has been found $s", file_name)
            return True
        else:
            logging.debug("List doesn't contain this file: %s", file_name)
            return False

    def get_md5_sum(self, file_object):
        md5 = hashlib.md5()
        with io.open(file_object, mode="rb") as fd:
            content = fd.read()
        # md5 hash object
        md5.update(content)
        # return hash sum
        return md5.hexdigest()
