import os
import hashlib
import io
import logging
from robot.api.deco import keyword


class SystemActions:

    def __init__(self, path):
        self.path = path

    @keyword('Get Files Directory')
    def get_files_directory(self):
        """return list files from directory"""
        logging.debug("Has been given path %s", self.path)
        for root, dirs, files in os.walk(self.path):
            return files

    def check_contain(self, array, file_name):
        logging.debug("Has been given list and file: %s", file_name)
        if file_name in array:
            logging.debug("File has been found %s", file_name)
            return True
        else:
            logging.debug("List doesn't contain this file: %s", file_name)
            return False

    @keyword("Calculate md5 ${name}")
    def get_md5_sum(self, name):
        md5 = hashlib.md5()
        with io.open(self.path+name, mode="rb") as fd:
            content = fd.read()
        # md5 hash object
        md5.update(content)
        # return hash sum
        return md5.hexdigest()
