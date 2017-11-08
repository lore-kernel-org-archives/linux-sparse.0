From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/7] restricted pointers
Date: Wed,  8 Nov 2017 22:06:06 +0100
Message-ID: <20171108210613.14252-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45841 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbdKHVIV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 16:08:21 -0500
Received: by mail-wm0-f68.google.com with SMTP id y80so13084620wmd.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 13:08:20 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to prepare for a real support
for C99's 'restrict' type qualifier.
As preliminary steps this series also contains a
cleanup of the #define MOD_XYZ and as bonus it teaches
sparse about C11's '_Atomic' as type *qualifier*

Change since v1:
- remove patches related to error vs. warnings which
  have already been integrated.
- improve commit messages

This series is available for review & testing at:
        git://github.com/lucvoo/sparse.git restricted-pointers-v2


Luc Van Oostenryck (7):
  remove never-used MOD_TYPEDEF
  MOD_ACCESSED is not a type modifier ...
  reorganize the definition of the modifiers
  remove redundancy in MOD_STORAGE
  define MOD_QUALIFIER for (MOD_CONST | MOD_VOLATILE)
  associate MOD_RESTRICT with restrict-qualified variables
  add support for C11's _Atomic as type qualifier

 evaluate.c                   |  2 +-
 expand.c                     |  2 +-
 gdbhelpers                   | 12 +++---
 ident-list.h                 |  2 +-
 parse.c                      | 31 ++++++++++++---
 show-parse.c                 |  4 +-
 symbol.c                     |  4 +-
 symbol.h                     | 80 ++++++++++++++++++-------------------
 validation/c11-atomic.c      | 93 ++++++++++++++++++++++++++++++++++++++++++++
 validation/optim/restrict.c  | 73 ++++++++++++++++++++++++++++++++++
 validation/reload-aliasing.c | 41 +++++++++++++++++++
 validation/restrict.c        | 93 ++++++++++++++++++++++++++++++++++++++++++++
 validation/typeof-mods.c     | 28 +++++++++++++
 13 files changed, 406 insertions(+), 59 deletions(-)
 create mode 100644 validation/c11-atomic.c
 create mode 100644 validation/optim/restrict.c
 create mode 100644 validation/reload-aliasing.c
 create mode 100644 validation/restrict.c

-- 
2.14.0

