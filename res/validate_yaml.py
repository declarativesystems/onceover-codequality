import sys
import os
import re

status = 0
try:
  import yaml
  for root, dirs, files in os.walk("."):
    for f in files:
      # we want yaml files that are not in hidden (.) dirs. account for / vs \ on windows/linux
      target = os.path.join(root, f)
      if target.endswith(".yaml") and not re.match("^\.(/|\\\)\.", target):
        try:
          yaml.safe_load(open(target,"r"))
        except Exception as e:
          status = 1
          print("YAML syntax error in %s: %s" % (target, str(e)))

except ImportError as e:
  print("Please install the python-yaml library: pip install pyyaml")


sys.exit(status)

