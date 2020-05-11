#!/usr/bin/env python3

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
import tarfile
import argparse


def init_logging():
    """Configures basic logging options."""

    logging.basicConfig(
        format='%s@%s ' % (username(), hostname())
        + '%(asctime)s %(levelname)s %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S',
    )
    logging.getLogger('').setLevel(logging.NOTSET)


def del_dir(d):
    """Deletes the directory d. Does not complain on error."""
    try:
        shutil.rmtree(d)
    except OSError:
        pass


def mkdir(d):
    """Makes the directory d. Does not complain on error."""
    try:
        os.makedirs(d)
    except OSError:
        pass


def username():
    """Returns the username of the process owner."""
    return getpass.getuser()


def hostname():
    """Returns the hostname of this computer."""
    return socket.gethostname()


def extract_tgz(name, path):
    """Extracts a tgz file in the given path."""
    if name == '-':
        tar = tarfile.open(mode='r|gz', fileobj=sys.stdin)
    else:
        tar = tarfile.open(name, 'r:gz')
    for x in tar:
        tar.extract(x, path)
    tar.close()


def create_tgz(name, filenames, path=None):
    """Creates a tgz file name with the contents given in the list of filenames.
    Uses path if given."""
    if name == '-':
        tar = tarfile.open(mode='w|gz', fileobj=sys.stdout)
    else:
        tar = tarfile.open(name, 'w:gz')
    if path:
        cwd = os.getcwd()
        os.chdir(path)
    for x in filenames:
        tar.add(x)
    if path:
        os.chdir(cwd)
    tar.close()



def main():
    """main"""

    init_logging()

    parser = argparse.ArgumentParser(
        description='Correct a submission')
    parser.add_argument('name')
    parser.add_argument(
        '--nowrapping',
        action='store_true',
        help='do not wrapping')
    args = parser.parse_args()

    wrapping = not args.nowrapping

    logging.info('name: %s' % args.name)
    logging.info('wrapping: %s' % str(wrapping))


    if wrapping:

        logging.info('starting correction')
        logging.info('cwd=%s' % os.getcwd())
        logging.info('user=%s' % username())
        logging.info('host=%s' % hostname())

        logging.info('setting ulimits')
        resource.setrlimit(resource.RLIMIT_CORE, (0,0))
        resource.setrlimit(resource.RLIMIT_CPU, (300,300))
        resource.setrlimit(resource.RLIMIT_NPROC, (1000,1000))

        logging.info('setting umask')
        os.umask(0o077)

        logging.info('decompressing submission')
        del_dir('submission')
        mkdir('submission')
        extract_tgz('submission.tgz', 'submission')

        logging.info('decompressing problem')
        del_dir('problem')
        mkdir('problem')
        extract_tgz('problem.tgz', 'problem')

        logging.info('decompressing driver')
        del_dir('driver')
        mkdir('driver')
        extract_tgz('driver.tgz', 'driver')

        logging.info('mkdir solution')
        del_dir('solution')
        mkdir('solution')

        logging.info('mkdir correction')
        del_dir('correction')
        mkdir('correction')

    # http://stackoverflow.com/questions/692000/how-do-i-write-stderr-to-a-file-while-using-tee-with-a-pipe

    cmd = 'bash -c "python3 driver/judge.py %s </dev/null > >(tee stdout.txt) 2> >(tee stderr.txt >&2)"' % args.name
    logging.info('executing %s' % cmd)
    os.system(cmd)
    os.rename("stderr.txt", "correction/stderr.txt")
    os.rename("stdout.txt", "correction/stdout.txt")
    os.system("chmod -R u+rwX,go-rwx .")

    logging.info('end of correction')


    if wrapping:

        logging.info('compressing correction')
        create_tgz('correction.tgz', '.', 'correction')


    logging.info('flushing and closing files')
    sys.stdout.flush()
    sys.stderr.flush()
    sys.stdout.close()
    sys.stderr.close()
    sys.stdin.close()
    os._exit(0)



if __name__ == '__main__':
    main()
