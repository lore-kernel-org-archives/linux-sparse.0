From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] unssa improvements
Date: Thu,  1 Dec 2016 16:07:00 +0100
Message-ID: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f174.google.com ([209.85.210.174]:34073 "EHLO
        mail-wj0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbcLAPHR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Dec 2016 10:07:17 -0500
Received: by mail-wj0-f174.google.com with SMTP id mp19so207599686wjc.1
        for <linux-sparse@vger.kernel.org>; Thu, 01 Dec 2016 07:07:17 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie improves the out-of-SSA step by:
* simplify the conversion of the phi-nodes & phi-sources into copies
* eliminate some copies which are trivially not needed.

The elimination step is significant since on a small corpus which
produced 267 copies, after the patch only 165 remain.

Luc Van Oostenryck (5):
  unssa: do not try to update liveness
  unssa: simplify rewrite of OP_PHISOURCE
  unssa: try to avoid some OP_PHI copies
  unssa: eliminate trivial phisrc copies
  unssa: update comment about the unneeded copies

 unssa.c | 141 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 74 insertions(+), 67 deletions(-)

-- 
2.10.2

