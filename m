From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] Simplify booleans
Date: Wed, 12 Apr 2017 16:17:59 +0200
Message-ID: <20170412141802.81231-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36452 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdDLOUL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 10:20:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id q125so6720384wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 07:20:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add some simplification
concerning booleans and is a preparatory steps to give
a proper boolean context when required.


This series is available at:
	git://github.com/lucvoo/sparse.git simplify-bool-mask
based on commit:
	d440a16358aefd718029963bb2261f1deccfddab (fpos)
up to commit:
	d4208cd1ef7df00f7d79dba1ccb365136d382914

Luc Van Oostenryck (3):
  simplify 'x | ~0' and 'x & ~0'
  simplify 'x ^ ~0' to '~x'
  simplify casts bool -> int -> bool

 simplify.c                       | 35 +++++++++++++++++++++++++++++++++--
 validation/optim/bool-int-bool.c | 12 ++++++++++++
 validation/optim/bool-not-zero.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 validation/optim/bool-int-bool.c
 create mode 100644 validation/optim/bool-not-zero.c

-- 
2.12.0

