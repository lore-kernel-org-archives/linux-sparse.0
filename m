From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] IR cleanup
Date: Wed, 14 Feb 2018 02:08:38 +0100
Message-ID: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34957 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBKx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:10:53 -0500
Received: by mail-wr0-f196.google.com with SMTP id 33so6420836wro.2
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:10:52 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains some cleanup of the IR as well
as some changes in the details of how the IR is defined. 

Luc Van Oostenryck (5):
  IR: fix typo in IR doc
  IR: remove now unused OP_LNOP & OP_SNOP
  IR: remove never-generated instructions
  IR: let .cond unionize with .src and not .target
  IR: let OP_COMPUTEGOTO use .src instead of .target

 Documentation/IR.md | 22 +++-------------------
 example.c           | 10 ----------
 flow.c              |  4 +---
 linearize.c         | 18 ++++--------------
 linearize.h         | 19 ++++---------------
 liveness.c          | 15 +--------------
 sparse-llvm.c       |  8 +-------
 7 files changed, 14 insertions(+), 82 deletions(-)

-- 
2.16.0

