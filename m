From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] split OP_BR between OP_BR & OP_CBR
Date: Sat, 18 Feb 2017 02:28:46 +0100
Message-ID: <20170218012848.27417-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36287 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbdBRB27 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 20:28:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so5151565wmd.3
        for <linux-sparse@vger.kernel.org>; Fri, 17 Feb 2017 17:28:58 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series introduces a new instruction opcode (OP_CBR)
for conditional branches. Previously both conditional and
non-conditional branches used the OP_BR opcode which is
now reserved for non-conditional branches.

The motivation is the correctness of the test between
the two kind of branches and an added benefit is the
simplicity of this test now.

Luc Van Oostenryck (2):
  split OP_BR between unconditional & conditional: OP_CBR
  remove unused helper is_branch_goto()

 example.c                       |   2 +
 flow.c                          |  13 ++--
 linearize.c                     |  14 +++--
 linearize.h                     |   5 +-
 liveness.c                      |   3 +-
 simplify.c                      |  11 ++--
 sparse-llvm.c                   |  25 ++++----
 validation/loop-linearization.c | 136 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 176 insertions(+), 33 deletions(-)
 create mode 100644 validation/loop-linearization.c

-- 
2.11.0

