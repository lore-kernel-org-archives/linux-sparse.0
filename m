From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] teach sparse about arch specific asm constraints
Date: Sat,  4 Jul 2020 15:57:44 +0200
Message-ID: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDN5w (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 09:57:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E0C061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 06:57:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so23419504ejx.0
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 06:57:52 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When evaluating asm operands it must be known if they correspond
to a memory operand or not. This is done by looking at the constraint.
In most case it's enough to look at the common constraints but
PPC & S390 have some specific constraints for memory operands.
Other kinds of operands may also need arch-specific constraints.
    
This series adds support for processing arch-specific constraints
and let sparse know about PPC & S390 constraints for memory operands.


Luc Van Oostenryck (3):
  add support for arch specific asm constraints
  add memory asm constraint for PPC
  add memory asm constraint for S390

 evaluate.c    |  5 ++++-
 target-ppc.c  | 13 +++++++++++++
 target-s390.c | 13 +++++++++++++
 target.h      |  3 ++-
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.27.0
