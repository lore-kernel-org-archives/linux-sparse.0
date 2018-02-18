From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 0/2] use a single multiplication instruction
Date: Sun, 18 Feb 2018 10:15:17 +0100
Message-ID: <20180218091519.6708-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50845 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeBRJP0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Feb 2018 04:15:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id k87so10067809wmi.0
        for <linux-sparse@vger.kernel.org>; Sun, 18 Feb 2018 01:15:26 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These two patches replace the instrcutions for signed & unsigned
multiplication (OP_MULS & OP_MULU) by a single one: OP_MUL.

There is no reasons to have both since the IR doesn't do
full/widening multiplication.

Luc Van Oostenryck (2):
  unsigned multiplication is also associative
  no need for signed & unsigned multiplication

 Documentation/IR.md |  7 ++-----
 cse.c               |  4 ++--
 example.c           |  5 ++---
 linearize.c         |  9 ++++-----
 linearize.h         |  2 +-
 opcode.c            |  3 +--
 simplify.c          | 15 +++++----------
 sparse-llvm.c       |  6 +-----
 validation/int128.c |  2 +-
 9 files changed, 19 insertions(+), 34 deletions(-)

-- 
2.16.0

