From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] diagnose unknown escapes after preprocessing
Date: Tue,  7 Feb 2017 18:45:04 +0100
Message-ID: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34806 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdBGRx6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 12:53:58 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so29719236wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 09:53:58 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series aims to solve the wrong warning recently 
received when using sparse on Linux's kernel for arm64. 
It quite straightforwardly move the diagnostic of
unknown escape sequence together with escape conversion,
after preprocessing.

Patch 1 is just a test case (and could be folded with patch 2)
Patch 2 is the fix in itself
Patch 3 remove potential cruft left by patch 2.


Luc Van Oostenryck (3):
  add testcase for wrong early escape conversion
  warn on unknown escapes after preprocessing
  remove 'Escape' from token character class

 char.c                                 |  6 ++++++
 tokenize.c                             | 28 +++++++++++-----------------
 validation/escapes.c                   |  2 +-
 validation/preprocessor/early-escape.c | 22 ++++++++++++++++++++++
 4 files changed, 40 insertions(+), 18 deletions(-)
 create mode 100644 validation/preprocessor/early-escape.c

-- 
2.11.0

