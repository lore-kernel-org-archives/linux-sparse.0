From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/2] split OP_BR between OP_BR & OP_CBR
Date: Tue, 28 Feb 2017 14:30:26 +0100
Message-ID: <20170228133028.45237-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=60E+2tvn=bdjaYnZFS3U3PMiTTq0=eYS-NkPDK3aJNA@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35994 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbdB1NdN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 08:33:13 -0500
Received: by mail-wr0-f195.google.com with SMTP id l37so1663708wrc.3
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 05:32:37 -0800 (PST)
In-Reply-To: <CANeU7Q=60E+2tvn=bdjaYnZFS3U3PMiTTq0=eYS-NkPDK3aJNA@mail.gmail.com>
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


Changes since v1:
- add missing '/* fall through */' 
- convert 2 more tests of ->cond/->bb_{true,false}
  into tests of ->opcode == OP_CBR/OP_BR

Luc Van Oostenryck (2):
  split OP_BR between unconditional & conditional: OP_CBR
  remove unused helper is_branch_goto()

 example.c                       |   2 +
 flow.c                          |  17 +++--
 linearize.c                     |  14 +++--
 linearize.h                     |   5 +-
 liveness.c                      |   3 +-
 simplify.c                      |  15 ++---
 sparse-llvm.c                   |  25 ++++----
 validation/loop-linearization.c | 136 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 179 insertions(+), 38 deletions(-)
 create mode 100644 validation/loop-linearization.c

-- 
2.11.1

