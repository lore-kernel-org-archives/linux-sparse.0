From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 0/2] drop the concept of 'known-but-ignored' attributes
Date: Wed, 14 Feb 2018 00:21:07 +0100
Message-ID: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46226 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeBMXVQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 18:21:16 -0500
Received: by mail-wr0-f194.google.com with SMTP id 34so9970860wre.13
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 15:21:15 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Lance Richardson <lrichard@redhat.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Randy Dunlap <rdunlap@infradead.org>, Rui Teng <rui.teng@linux.vnet.ibm.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to drop the concept of
'known-but-ignored' attributes which, for a semantic
checker like sparse, adds absolutely no added value
but bring endless annoyances.

Luc Van Oostenryck (2):
  By default disable the warning flag '-Wunknown-attribute'
  drop the concept of 'known-but-ignored' attributes

 gcc-attr-list.h                     | 210 ------------------------------------
 lib.c                               |   2 +-
 parse.c                             |  42 +-------
 validation/Wunknown-attribute-def.c |   1 -
 4 files changed, 2 insertions(+), 253 deletions(-)
 delete mode 100644 gcc-attr-list.h

-- 
2.16.0

