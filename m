From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] avoid creating orphaned OP_PHISRCs
Date: Thu, 13 Apr 2017 18:55:43 +0200
Message-ID: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36693 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbdDMQz7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:55:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id q125so13647547wmd.3
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:55:58 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to avoid the creation of
orphaned OP_PHISRCs by simplify_loads() when it appears
that the loads con't be simplified afterall but that some
OP_PHISRC have already been created.
This change then lead to some code restructuration and
simplification.

This series is available at:
	git://github.com/lucvoo/sparse.git fix-orphaned-phisrc
based on commits (a merge)
	ac6c25bc066eab36942539ba11c7ab6cf0c63674 (bool-context)
	ecda2093f19088fa94c3a4ac85359c6d0f1c64af (fix-cond-address)
	fc981fe285c37ee297e93ef1cc8725caac75f9b3 (fix-bitfield-init-v2)
up to commit:
	8b6716908788dfd1713215e7d4ddaa4f3d341948


Luc Van Oostenryck (8):
  extract add_dominator() from find_dominating_parents()
  add helper add_load_dominators()
  remove test on initial phi->ident
  avoid phisrc orphaned by simplify_loads()
  avoid phisrc orphaned by find_dominating_stores()
  integrate add_load_dominators() into rewrite_load_instruction()
  check duplicated phi-nodes directly on dominators
  avoid creating unneeded phi-sources

 flow.c                               | 79 +++++++++++++++++++++++-------------
 flow.h                               |  2 +-
 memops.c                             | 14 ++-----
 validation/linear/phisrc-orphan-ld.c | 22 ++++++++++
 validation/linear/phisrc-orphan-st.c | 17 ++++++++
 validation/loop-linearization.c      | 30 +++++++-------
 6 files changed, 110 insertions(+), 54 deletions(-)
 create mode 100644 validation/linear/phisrc-orphan-ld.c
 create mode 100644 validation/linear/phisrc-orphan-st.c

-- 
2.12.0

