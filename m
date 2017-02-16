From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] CSE improvements
Date: Fri, 17 Feb 2017 00:12:27 +0100
Message-ID: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34546 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPXOk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 18:14:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id c4so3668015wrd.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 15:14:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie aims at improving CSE by
- recognize commutative instructions as equivalent
- avoid to hash instructions that are already eliminated
- slight optimization of hash of non-commutative instructions

Luc Van Oostenryck (4):
  CSE: add test cases for comparisons duality
  CSE: use commutativity to identify equivalent instructions
  CSE: avoid hashing removed instructions
  CSE: improve hashing of non-commutative binops

 cse.c                                | 50 +++++++++++++++++++++---------------
 validation/optim/cse-commutativity.c | 22 ++++++++++++++++
 validation/optim/cse-dual-compare.c  | 34 ++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 20 deletions(-)
 create mode 100644 validation/optim/cse-commutativity.c
 create mode 100644 validation/optim/cse-dual-compare.c

-- 
2.11.0

