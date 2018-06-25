# from robot.api import keyword
import os
import hashlib
import io
from robot.api import logger


class OperatingSystemActions(object):

    def get_filer_directory(path):
        for root, dirs, files in os.walk(path):
            return files

    def check_contain(array, file_name):
        if file_name in array:
            return True

    def get_md5_sum(path):
        md5 = hashlib.md5()
        with io.open(path, mode="rb") as fd:
            content = fd.read()
        md5.update(content)
        return md5
