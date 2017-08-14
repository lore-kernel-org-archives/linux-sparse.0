From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] assorted LLVM fixes
Date: Mon, 14 Aug 2017 21:41:49 +0200
Message-ID: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35820 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdHNTl7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 15:41:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id r77so15567365wmd.2
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 12:41:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains two fixes for sparse-llvm.
It is supposed to be applied on top of all others
LLVM fixes.

Luc Van Oostenryck (3):
  llvm: warn instead of assert on global inits
  llvm: add support for float initializer
  llvm: only compare void pointers

 sparse-llvm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.14.0

