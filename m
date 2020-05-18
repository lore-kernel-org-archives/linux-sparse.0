From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] simplify parsing of inline/__tls/__visible
Date: Tue, 19 May 2020 01:42:04 +0200
Message-ID: <20200518234207.84150-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXmO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 19:42:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B677DC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u188so1377522wmu.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a follow-up of the previous series "improve handling
of function attributes" removinf the special cases that were
needed to parse and handle these 3 specifiers.

Luc Van Oostenryck (3):
  attribute: '__tls' is just another 'declaration' modifier
  attribute: 'inline' is just another 'declaration' modifier
  attribute: 'externally_visible' is just another 'declaration' modifier

 parse.c                    | 26 +++++++-------------------
 symbol.h                   |  5 ++---
 validation/attr-visible.c  |  1 -
 validation/attr-visible2.c |  1 -
 4 files changed, 9 insertions(+), 24 deletions(-)


base-commit: 146e6a63e715e0c3e08aacbcaa79ff8930289297
-- 
2.26.2
