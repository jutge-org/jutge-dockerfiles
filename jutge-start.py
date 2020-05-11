#!/usr/bin/env python3

print("WORK IN PROGRESS!!!")

"""
This script is used to correct a submission.
"""

import os
import sys
import logging
import shutil
import resource
import getpass
import socket


def init_logging():
    '''Configures basic logging options.'''

    logging.basicConfig(
        format='%s@%s ' % (username(), hostname())
        + '%(asctime)s %(levelname)s %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S',
    )
    logging.getLogger('').setLevel(logging.NOTSET)


def del_dir(d):
    '''Deletes the directory d. Does not complain on error.'''
    try:
        shutil.rmtree(d)
    except OSError:
        pass


def mkdir(d):
    '''Makes the directory d. Does not complain on error.'''
    try:
        os.makedirs(name)
    except OSError:
        pass


def username():
    '''Returns the username of the process owner.'''
    return getpass.getuser()


def hostname():
    '''Returns the hostname of this computer.'''
    return socket.gethostname()



# ##############################################################################################
# main
# ##############################################################################################

init_logging()

name = sys.argv[1]
logging.info('name: %s' % name)

full = False

if full:

    logging.info('starting correction')
    logging.info('cwd=%s' % os.getcwd())
    logging.info('user=%s' % util.username())
    logging.info('host=%s' % util.hostname())

    logging.info('setting ulimits')
    resource.setrlimit(resource.RLIMIT_CORE, (0,0))
    resource.setrlimit(resource.RLIMIT_CPU, (300,300))
    resource.setrlimit(resource.RLIMIT_NPROC, (1000,1000))

    logging.info('setting umask')
    os.umask(0o077)

    logging.info('decompressing submission')
    del_dir('submission')
    mkdir('submission')
    util.extract_tgz('submission.tgz', 'submission')

    logging.info('decompressing problem')
    del_dir('problem')
    mkdir('problem')
    util.extract_tgz('problem.tgz', 'problem')

    logging.info('decompressing driver')
    del_dir('driver')
    mkdir('driver')
    util.extract_tgz('driver.tgz', 'driver')

    logging.info('mkdir solution')
    del_dir('solution')
    mkdir('solution')

    logging.info('mkdir correction')
    del_dir('correction')
    mkdir('correction')


# http://stackoverflow.com/questions/692000/how-do-i-write-stderr-to-a-file-while-using-tee-with-a-pipe

cmd = 'bash -c "python3 driver/judge.py %s </dev/null > >(tee stdout.txt) 2> >(tee stderr.txt >&2)"' % name
logging.info('executing %s' % cmd)
os.system(cmd)
os.rename("stderr.txt", "correction/stderr.txt")
os.rename("stdout.txt", "correction/stdout.txt")
os.system("chmod -R u+rwX,go-rwx .")

logging.info('end of correction')

logging.info('flushing and closing files')
sys.stdout.flush()
sys.stderr.flush()
sys.stdout.close()
sys.stderr.close()
sys.stdin.close()
os._exit(0)

