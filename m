From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] dump the IR
Date: Fri, 15 Sep 2017 09:40:26 +0200
Message-ID: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34229 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdIOHkk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:40:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so2023158wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:40:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of thsi series is to allow and control dumping of
the IR at different stage of the processing.

This is meant to be used for testing & debugging.


Note: this series depends on the series 'option-parsing'


This series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git dump-ir

----------------------------------------------------------------
Luc Van Oostenryck (8):
      dump-ir: add defines for the compilation passes
      dump-ir: allow to specify the passes to execute via cli's options
      dump-ir: activate/deactive pass 'mem2reg'
      dump-ir: set the default optimization level to 2
      dump-ir: use -O0
      dump-ir: saner use of fdump_linearize
      dump-ir: rename -fdump-linearize to -fdump-ir
      dump-ir: make it more flexible

 Documentation/options.md               |  29 +++++++++
 cgcc                                   |   3 +-
 lib.c                                  | 113 ++++++++++++++++++++++++++++++---
 lib.h                                  |  19 +++++-
 linearize.c                            |  10 +--
 sparse.1                               |   6 --
 test-linearize.c                       |   2 +
 test-unssa.c                           |   2 +
 validation/linear/bitfield-init-mask.c |   2 +-
 9 files changed, 162 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/options.md
