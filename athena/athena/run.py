#!/usr/bin/env python

import os
import subprocess
import argparse

# Global variables
athena_path = os.path.expanduser('~') + '/athena/'

# Function (wrapper) for running configure and compile bash script
def run_cc(**kwargs):
    """Configure and configure"""
    current_dir=os.getcwd()
    os.chdir(athena_path)
    cc_command = [athena_path + 'cc']

    if kwargs['mpi'] is True:
        cc_command.append('-m')
    if kwargs['debug'] is True:
        cc_command.append('-d')

    try:
        subprocess.check_call(cc_command)
    except subprocess.CalledProcessError as err:
        raise AthenaError('Return code {0} from command \'{1}\''\
                          .format(err.returncode,' '.join(err.cmd)))

    finally:
      os.chdir(current_dir)

# General exception class for these functions
class AthenaError(RuntimeError):
    pass

# Execute main function
if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='run configure and compile script')

  parser.add_argument('-m','--mpi',
      default=True,
      action='store_true',
      help="enable mpi")

  parser.add_argument('-d','--debug',
      default=False,
      action='store_true',
      help="enable debug")

  kwargs = parser.parse_args()

  run_cc(**vars(kwargs))
