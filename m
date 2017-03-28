From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] floating-point specific instructions
Date: Tue, 28 Mar 2017 16:18:25 +0200
Message-ID: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33751 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdC1OZV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:25:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so1099wmb.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:25:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Floating-point arithmetic is quite different from arithmetic
on integers (or on real numbers). In particular,
most transformations, simplifications that can be done on integers
are invalid when done on floats.

Since they don't follow the same rules as their integer
counterpart, better to give a specific opcode to floating-point
operations instead of having to test the type of the operands at
each manipulation.


Luc Van Oostenryck (4):
  fix linearize_inc_dec() with floats
  add test case for boolean negation on float
  fix support of floating-point compare
  add support of floating-point specific arithmetic ops

 cse.c                               |  14 ++++
 linearize.c                         |  58 ++++++++++++++---
 linearize.h                         |  25 ++++++++
 liveness.c                          |   1 +
 opcode.c                            |  46 +++++++++++---
 opcode.h                            |  10 +++
 simplify.c                          |   2 +-
 sparse-llvm.c                       |  64 ++++++++++---------
 validation/backend/arithmetic-ops.c |  20 ++++++
 validation/bool-float.c             |   9 +++
 validation/fp-ops.c                 |  57 +++++++++++++++++
 validation/inc-dec-float.c          |  13 ++++
 validation/optim/canonical-fcmp.c   | 123 ++++++++++++++++++++++++++++++++++++
 13 files changed, 394 insertions(+), 48 deletions(-)
 create mode 100644 validation/bool-float.c
 create mode 100644 validation/fp-ops.c
 create mode 100644 validation/inc-dec-float.c
 create mode 100644 validation/optim/canonical-fcmp.c

-- 
2.12.0

