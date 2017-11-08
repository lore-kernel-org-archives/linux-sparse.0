From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] dump IR
Date: Wed,  8 Nov 2017 11:27:53 +0100
Message-ID: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45716 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdKHK2J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:09 -0500
Received: by mail-wr0-f195.google.com with SMTP id y9so1956084wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:09 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add finer control to the dumping
of sparse's IR. As a kind of side-effect, this series also
add the notion of 'passes' and add some control to them.

Notes:
*) this series doesn't impact the tools 'sparse', only
   test-linearize (and test-unssa).
*) the added options & control are only meant to facilite
   development concerning the generation of the IR.
*) this series depends on the previous 'option parsing
   improvements' series.


Luc Van Oostenryck (9):
  dump-ir: add defines for the compilation passes
  dump-ir: allow to specify the passes to execute via cli's options
  dump-ir: activate/deactive pass 'mem2reg'
  dump-ir: set the default optimization level to 2
  dump-ir: use -O0
  dump-ir: saner use of fdump_linearize
  dump-ir: rename -fdump-linearize to -fdump-ir
  dump-ir: make it more flexible
  dump-ir: activate -fdump-ir=mem2reg

 Documentation/options.md               |  29 +++++++++
 cgcc                                   |   3 +-
 lib.c                                  | 113 ++++++++++++++++++++++++++++++---
 lib.h                                  |  19 +++++-
 linearize.c                            |  12 ++--
 sparse.1                               |   6 --
 test-linearize.c                       |   2 +
 test-unssa.c                           |   2 +
 validation/linear/bitfield-init-mask.c |   2 +-
 9 files changed, 164 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/options.md

-- 
2.14.0

