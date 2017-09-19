From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] cclass: char is wide enough
Date: Tue, 19 Sep 2017 04:55:59 +0200
Message-ID: <20170919025600.11900-2-luc.vanoostenryck@gmail.com>
References: <20170919025600.11900-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37100 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdISC4K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:56:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so2528642wmh.4
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:56:09 -0700 (PDT)
In-Reply-To: <20170919025600.11900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The table for character classes is declared as 'long cclass[]'
but there is no more reasons for such a wide type, 'int', or even
'char' is enough here.

Change this to use 'char' instead of 'long'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 tokenize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tokenize.c b/tokenize.c
index 99b958035..7e68cf1ee 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -483,7 +483,7 @@ enum {
 	Quote = 64,
 };
 
-static const long cclass[257] = {
+static const char cclass[257] = {
 	['0' + 1 ... '7' + 1] = Digit | Hex,	/* \<octal> */
 	['8' + 1 ... '9' + 1] = Digit | Hex,
 	['A' + 1 ... 'D' + 1] = Letter | Hex,
-- 
2.14.0

