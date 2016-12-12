From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/5] unssa improvements
Date: Mon, 12 Dec 2016 16:28:56 +0100
Message-ID: <20161212152901.24948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35451 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbcLLP3I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Dec 2016 10:29:08 -0500
Received: by mail-wj0-f193.google.com with SMTP id he10so12134152wjc.2
        for <linux-sparse@vger.kernel.org>; Mon, 12 Dec 2016 07:29:08 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie improves the out-of-SSA step by:
* simplify the conversion of the phi-nodes & phi-sources into copies
* eliminate some copies which are trivially not needed.

The elimination step is significant since on a small corpus which
produced 267 copies, after the patch only 165 remain.


Changes since v1:
  * during unSSA, do not use kill_instruction() on OP_PHI
  * fix related to the fact that after unSSA, pseudos *can*
    again be defined by several instructions. If it's effectively the
    case, their ->def is set to NULL (and must, of course, not be used).

Note: this serie depends on the serie 'fix uses of killed instructions'
    and on the changes to the testsuite for checking after some patterns
    in the output.

This serie can also be found on github:
	https://github.com/lucvoo/sparse/tree/sent/unssa-simple

Luc Van Oostenryck (5):
  unssa: do not try to update liveness
  unssa: simplify rewrite of OP_PHISOURCE
  unssa: try to avoid some OP_PHI copies
  unssa: eliminate trivial phisrc copies
  unssa: update comment about the unneeded copies

 unssa.c | 142 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 75 insertions(+), 67 deletions(-)

-- 
2.10.2

