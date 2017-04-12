From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] extend canonical order
Date: Wed, 12 Apr 2017 14:59:10 +0200
Message-ID: <20170412125912.46641-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33193 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbdDLNB1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 09:01:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so6280855wmb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 06:01:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

After linearization, operands of binops of binops are
maintained in a 'canonical' order but this order is only:
	anything > symbols > integer literals
but there is some value to impose a more complete order
as this creates more opportunities for CSE and help to
limit the number of patterns that need to be checked
at simplification of even during code generation.

This is what is done by this (almost single patch) series.

This series is available at:
	git://github.com/lucvoo/sparse.git base-file
based on commit:
	c9585071d02590f40175ea90c395d15ef70e9a1e (cset-setfval)
up to commit:
	462a61a21b1e3bb17abce88fb1bdbc93d9653245


Luc Van Oostenryck (2):
  CSE: split optim/cse-dual-compare.c in two files
  CSE: extend canonical_order()

 linearize.h                                        |  4 +--
 simplify.c                                         | 29 +++++++++++-----
 validation/call-inlined.c                          |  2 +-
 .../optim/{cse-dual-compare.c => cse-dual-cmpeq.c} | 11 +-----
 validation/optim/cse-dual-cmpne.c                  | 40 ++++++++++++++++++++++
 5 files changed, 65 insertions(+), 21 deletions(-)
 rename validation/optim/{cse-dual-compare.c => cse-dual-cmpeq.c} (68%)
 create mode 100644 validation/optim/cse-dual-cmpne.c

-- 
2.12.0

