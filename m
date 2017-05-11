From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/3] fix false "crazy programmer" warning
Date: Fri, 12 May 2017 00:26:18 +0200
Message-ID: <20170511222621.88420-1-luc.vanoostenryck@gmail.com>
References: <CANeU7QnpFci3ViG9dP1g5x1wPKnR=dAXCiLwnD4buD9t1NyaeA@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35436 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbdEKW03 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 18:26:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id g12so5395166wrg.2
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 15:26:28 -0700 (PDT)
In-Reply-To: <CANeU7QnpFci3ViG9dP1g5x1wPKnR=dAXCiLwnD4buD9t1NyaeA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to get rid of false "crazy programmer"
warnings. This warning is issued when a cycle is detected in
the address calculation of memory operations. Such cycle can
happen when simplifying phi-nodes dealing with uninitialized
variables.

However the very same diagnostic can also be emitted if we try
to simplify phi-nodes inside an unreachable loop (because localy
it's exactly the same situation: since the loop is unreachable
it's very possible that the induction variables have no more
an initial value). Of course, since this situation is only
the consequence of trying to simplify code that is not reachable
while the original may very well not contain any unitialized var,
this diagnostic should not be emitted in this situation.

The solution is to kill potential unreachable BBs before
trying to simplify them, each time a parent is removed
from a BB.

---

Changes since v1:
- split the patch in 3, the first 2 being small preparatory
  patches, the third being the meat.
- try to avoid to have to call kill_unreachable_bbs() in the
  rare situations where the BB having a parent removed still
  contains another parent and thus can't be unreachable.

Luc Van Oostenryck (3):
  introduce REPEAT_CFG_CLEANUP
  let kill_unreachable_bbs() clear REPEAT_CFG_CLEANUP
  fix: kill unreachable BBs after killing a child

 flow.c                      |  2 ++
 flow.h                      |  1 +
 linearize.c                 |  5 ++++-
 validation/crazy02-not-so.c | 22 ++++++++++++++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 validation/crazy02-not-so.c

-- 
2.12.2

