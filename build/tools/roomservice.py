#!/usr/bin/env python3
#
# Copyright (C) 2026 ExpressiveOS
# SPDX-License-Identifier: Apache-2.0
#
# build/envsetup.sh's lunch runs this from the top of the tree, as
# 'roomservice.py <product>' when it can't find the product and as
# 'roomservice.py <product> true' when it can (dependencies only).
#
# ExpressiveOS's manifest already lists every project, and its build kit
# refuses a tree with anything in .repo/local_manifests. So this looks
# nothing up, fetches nothing and writes no local manifest. It takes the
# same arguments as before and always exits with status 0.

import sys

print("ExpressiveOS's manifest already lists every project: nothing to fetch.")
sys.exit(0)
