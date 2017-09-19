From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] cclass: cleanup
Date: Tue, 19 Sep 2017 04:56:00 +0200
Message-ID: <20170919025600.11900-3-luc.vanoostenryck@gmail.com>
References: <20170919025600.11900-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38846 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdISC4L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:56:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id x17so2524278wmd.5
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:56:10 -0700 (PDT)
In-Reply-To: <20170919025600.11900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The table of charatcer classes: cclass[] used to contain information
about escaped chars but this is no more the case.

Simplify the table by merging sequence of character of same classes
and remove old comment about the escape.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 tokenize.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index 7e68cf1ee..aa4dc1840 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -484,31 +484,19 @@ enum {
 };
 
 static const char cclass[257] = {
-	['0' + 1 ... '7' + 1] = Digit | Hex,	/* \<octal> */
-	['8' + 1 ... '9' + 1] = Digit | Hex,
+	['0' + 1 ... '9' + 1] = Digit | Hex,
 	['A' + 1 ... 'D' + 1] = Letter | Hex,
 	['E' + 1] = Letter | Hex | Exp,	/* E<exp> */
 	['F' + 1] = Letter | Hex,
 	['G' + 1 ... 'O' + 1] = Letter,
 	['P' + 1] = Letter | Exp,	/* P<exp> */
 	['Q' + 1 ... 'Z' + 1] = Letter,
-	['a' + 1 ... 'b' + 1] = Letter | Hex, /* \a, \b */
-	['c' + 1 ... 'd' + 1] = Letter | Hex,
-	['e' + 1] = Letter | Hex | Exp,/* \e, e<exp> */
-	['f' + 1] = Letter | Hex,	/* \f */
-	['g' + 1 ... 'm' + 1] = Letter,
-	['n' + 1] = Letter,	/* \n */
-	['o' + 1] = Letter,
+	['a' + 1 ... 'd' + 1] = Letter | Hex,
+	['e' + 1] = Letter | Hex | Exp,	/* e<exp> */
+	['f' + 1] = Letter | Hex,
+	['g' + 1 ... 'o' + 1] = Letter,
 	['p' + 1] = Letter | Exp,	/* p<exp> */
-	['q' + 1] = Letter,
-	['r' + 1] = Letter,	/* \r */
-	['s' + 1] = Letter,
-	['t' + 1] = Letter,	/* \t */
-	['u' + 1] = Letter,
-	['v' + 1] = Letter,	/* \v */
-	['w' + 1] = Letter,
-	['x' + 1] = Letter,	/* \x<hex> */
-	['y' + 1 ... 'z' + 1] = Letter,
+	['q' + 1 ... 'z' + 1] = Letter,
 	['_' + 1] = Letter,
 	['.' + 1] = Dot | ValidSecond,
 	['=' + 1] = ValidSecond,
-- 
2.14.0

