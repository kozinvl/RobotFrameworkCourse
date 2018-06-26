import os
import hashlib
import io
import logging
from robot.api.deco import keyword

__all__ = ['get_files_directory', 'check_contain', 'get_md5_sum']

def get_files_directory(path):
    logging.debug("Has been given path %s", path)
    for root, dirs, files in os.walk(path):
        return files


def check_contain(array, file_name):
    logging.debug("Has been given list and file: %s", file_name)
    if file_name in array:
        return True
    else:
        logging.debug("List doesn't contain this file: %s", file_name)
        return False

@keyword("Get MD5 sum ${path}")
def get_md5_sum(path):
    logging.debug("Start calculating hash sum")
    md5 = hashlib.md5()
    try:
        with io.open(path, mode="rb") as fd:
            content = fd.read()
            # hash object
            md5.update(content)
    except Exception:
        logging.debug("Something done wrong")
        raise MyFatalError(RuntimeError)
    # hash sum
    return md5.hexdigest()


class MyFatalError(RuntimeError):
    ROBOT_EXIT_ON_FAILURE = True
