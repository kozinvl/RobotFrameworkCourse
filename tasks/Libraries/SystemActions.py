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
        """return boolean variable about contain file in list"""
        logging.debug("Has been given file: %s", file_name)
        if file_name in array:
            logging.debug("File has been found %s", file_name)
            return True
        else:
            logging.debug("List doesn't contain this file: %s", file_name)
            return False

    @keyword("Calculate md5 ${name}")
    def get_md5_sum(self, name):
        md5 = hashlib.md5()
        try:
            with io.open(self.path + '/' + name, mode="rb") as fd:
                content = fd.read()
                # md5 hash object
                md5.update(content)
        except Exception:
            logging.debug("Something done wrong")
            raise MyFatalError(RuntimeError)
        # hash sum
        return md5.hexdigest()


class MyFatalError(RuntimeError):
    ROBOT_EXIT_ON_FAILURE = True
