From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [WIP 00/13] LLVM fixes
Date: Sun,  5 Mar 2017 12:20:34 +0100
Message-ID: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34615 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbdCELae (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:30:34 -0500
Received: by mail-wm0-f65.google.com with SMTP id u132so1463637wmg.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:30:33 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series solves a number of issues in sparse-llvm,
mainly about wrong type information as needed for LLVM
or simply the lack of these infos.
These issues have been reported and investigated by
Dibyendu Majumdar.

These patches have been lightly tested and already
allow to compile a lot more code to LLVM.
It's still incomplete though:
- it won't work on bitfields
- it won't work on computed gotos
- it won't work on label-as-value
- it won't work on exotic instructions (OP_SPLICE)
- few things are working correctly with floats
  (but this is not specific to sparse-llvm).
There is most probably a bunch of others issues too.

For testing purpose this serie is also available at:
  https://github.com/lucvoo/sparse/tree/llvm-fixes-v0


Luc Van Oostenryck (13):
  llvm: add a helper to convert an integer to a ValueRef
  llvm: fix translation of PSEUDO_VALs into a ValueRefs
  llvm: fix output_op_store() which modify its operand
  llvm: fix output_op_[ptr]cast()
  add get_nth1_arg()
  llvm: fix type of literal integer passed as arguments
  llvm: fix output OP_ADD mixed with pointers
  llvm: add support for OP_NEG
  give a type to OP_PHISOURCE
  give a type to OP_SEL, always
  llvm: remove unneeded arg 'module'
  llvm: remove unneeded arg 'fn'
  llvm: fix: do not mix pointers and floats when doing compares

 flow.c                        |   2 +-
 linearize.c                   |  18 ++--
 linearize.h                   |   2 +-
 memops.c                      |   2 +-
 sparse-llvm.c                 | 187 +++++++++++++++++++++++++++++++-----------
 symbol.h                      |  13 +++
 validation/backend/null.c     |  24 ++++++
 validation/backend/store-x2.c |  16 ++++
 8 files changed, 203 insertions(+), 61 deletions(-)
 create mode 100644 validation/backend/null.c
 create mode 100644 validation/backend/store-x2.c

-- 
2.11.1

