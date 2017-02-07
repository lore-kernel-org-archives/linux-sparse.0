From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] remove 'Escape' from token character class
Date: Tue,  7 Feb 2017 18:45:07 +0100
Message-ID: <20170207174507.22722-4-luc.vanoostenryck@gmail.com>
References: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35418 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbdBGRw3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 12:52:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so29701595wmu.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 09:52:29 -0800 (PST)
In-Reply-To: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that diagnostic on unknown escape sequence
have moved to post-preprocessing phase this is not more used.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 tokenize.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tokenize.c b/tokenize.c
index 632413f0c..bc97242b4 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -481,11 +481,10 @@ enum {
 	Dot = 16,
 	ValidSecond = 32,
 	Quote = 64,
-	Escape = 128,
 };
 
 static const long cclass[257] = {
-	['0' + 1 ... '7' + 1] = Digit | Hex | Escape,	/* \<octal> */
+	['0' + 1 ... '7' + 1] = Digit | Hex,	/* \<octal> */
 	['8' + 1 ... '9' + 1] = Digit | Hex,
 	['A' + 1 ... 'D' + 1] = Letter | Hex,
 	['E' + 1] = Letter | Hex | Exp,	/* E<exp> */
@@ -493,22 +492,22 @@ static const long cclass[257] = {
 	['G' + 1 ... 'O' + 1] = Letter,
 	['P' + 1] = Letter | Exp,	/* P<exp> */
 	['Q' + 1 ... 'Z' + 1] = Letter,
-	['a' + 1 ... 'b' + 1] = Letter | Hex | Escape, /* \a, \b */
+	['a' + 1 ... 'b' + 1] = Letter | Hex, /* \a, \b */
 	['c' + 1 ... 'd' + 1] = Letter | Hex,
-	['e' + 1] = Letter | Hex | Exp | Escape,/* \e, e<exp> */
-	['f' + 1] = Letter | Hex | Escape,	/* \f */
+	['e' + 1] = Letter | Hex | Exp,/* \e, e<exp> */
+	['f' + 1] = Letter | Hex,	/* \f */
 	['g' + 1 ... 'm' + 1] = Letter,
-	['n' + 1] = Letter | Escape,	/* \n */
+	['n' + 1] = Letter,	/* \n */
 	['o' + 1] = Letter,
 	['p' + 1] = Letter | Exp,	/* p<exp> */
 	['q' + 1] = Letter,
-	['r' + 1] = Letter | Escape,	/* \r */
+	['r' + 1] = Letter,	/* \r */
 	['s' + 1] = Letter,
-	['t' + 1] = Letter | Escape,	/* \t */
+	['t' + 1] = Letter,	/* \t */
 	['u' + 1] = Letter,
-	['v' + 1] = Letter | Escape,	/* \v */
+	['v' + 1] = Letter,	/* \v */
 	['w' + 1] = Letter,
-	['x' + 1] = Letter | Escape,	/* \x<hex> */
+	['x' + 1] = Letter,	/* \x<hex> */
 	['y' + 1 ... 'z' + 1] = Letter,
 	['_' + 1] = Letter,
 	['.' + 1] = Dot | ValidSecond,
@@ -520,10 +519,8 @@ static const long cclass[257] = {
 	['&' + 1] = ValidSecond,
 	['|' + 1] = ValidSecond,
 	['#' + 1] = ValidSecond,
-	['\'' + 1] = Quote | Escape,
-	['"' + 1] = Quote | Escape,
-	['\\' + 1] = Escape,
-	['?' + 1] = Escape,
+	['\'' + 1] = Quote,
+	['"' + 1] = Quote,
 };
 
 /*
-- 
2.11.0

