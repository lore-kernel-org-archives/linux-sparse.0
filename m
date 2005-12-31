From: Alecs King <alecsk@gmail.com>
Subject: [RFC] [PATCH] clean up cclass
Date: Sat, 31 Dec 2005 15:20:55 +0800
Message-ID: <20051231072055.GA2323@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:55871 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751312AbVLaHO3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 02:14:29 -0500
Received: by zproxy.gmail.com with SMTP id 14so2118246nzn
        for <linux-sparse@vger.kernel.org>; Fri, 30 Dec 2005 23:14:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>

Is there a good reason to always add that '+ 1' in both initialization
and dereference of cclass?

This patch just remove that unnecessary '+ 1'.

Signed-off-by: Alecs King <alecsk@gmail.com>


diff --git a/tokenize.c b/tokenize.c
index 497da13..7464b5a 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -347,30 +347,30 @@ enum {
 	ValidSecond = 32,
 };
 
-static const long cclass[257] = {
-	['0' + 1 ... '9' + 1] = Digit | Hex,
-	['A' + 1 ... 'D' + 1] = Letter | Hex,
-	['E' + 1] = Letter | Hex | Exp,
-	['F' + 1] = Letter | Hex,
-	['G' + 1 ... 'O' + 1] = Letter,
-	['P' + 1] = Letter | Exp,
-	['Q' + 1 ... 'Z' + 1] = Letter,
-	['a' + 1 ... 'd' + 1] = Letter | Hex,
-	['e' + 1] = Letter | Hex | Exp,
-	['f' + 1] = Letter | Hex,
-	['g' + 1 ... 'o' + 1] = Letter,
-	['p' + 1] = Letter | Exp,
-	['q' + 1 ... 'z' + 1] = Letter,
-	['_' + 1] = Letter,
-	['.' + 1] = Dot | ValidSecond,
-	['=' + 1] = ValidSecond,
-	['+' + 1] = ValidSecond,
-	['-' + 1] = ValidSecond,
-	['>' + 1] = ValidSecond,
-	['<' + 1] = ValidSecond,
-	['&' + 1] = ValidSecond,
-	['|' + 1] = ValidSecond,
-	['#' + 1] = ValidSecond,
+static const long cclass[256] = {
+	['0' ... '9'] = Digit | Hex,
+	['A' ... 'D'] = Letter | Hex,
+	['E'] = Letter | Hex | Exp,
+	['F'] = Letter | Hex,
+	['G' ... 'O'] = Letter,
+	['P'] = Letter | Exp,
+	['Q' ... 'Z'] = Letter,
+	['a' ... 'd'] = Letter | Hex,
+	['e'] = Letter | Hex | Exp,
+	['f'] = Letter | Hex,
+	['g' ... 'o'] = Letter,
+	['p'] = Letter | Exp,
+	['q' ... 'z'] = Letter,
+	['_'] = Letter,
+	['.'] = Dot | ValidSecond,
+	['='] = ValidSecond,
+	['+'] = ValidSecond,
+	['-'] = ValidSecond,
+	['>'] = ValidSecond,
+	['<'] = ValidSecond,
+	['&'] = ValidSecond,
+	['|'] = ValidSecond,
+	['#'] = ValidSecond,
 };
 
 /*
@@ -394,7 +394,7 @@ static int get_one_number(int c, int nex
 
 	*p++ = c;
 	for (;;) {
-		long class =  cclass[next + 1];
+		long class =  cclass[next];
 		if (!(class & (Dot | Digit | Letter)))
 			break;
 		if (p != buffer_end)
@@ -647,7 +647,7 @@ static int get_one_special(int c, stream
 	 * Check for combinations
 	 */
 	value = c;
-	if (cclass[next + 1] & ValidSecond) {
+	if (cclass[next] & ValidSecond) {
 		comb = combinations[0];
 		c1 = c; c2 = next; c3 = 0;
 		for (i = 0; i < NR_COMBINATIONS; i++) {
@@ -810,7 +810,7 @@ static int get_one_identifier(int c, str
 	buf[0] = c;
 	for (;;) {
 		next = nextchar(stream);
-		if (!(cclass[next + 1] & (Letter | Digit)))
+		if (!(cclass[next] & (Letter | Digit)))
 			break;
 		if (len >= sizeof(buf))
 			break;
@@ -832,7 +832,7 @@ static int get_one_identifier(int c, str
 
 static int get_one_token(int c, stream_t *stream)
 {
-	long class = cclass[c + 1];
+	long class = cclass[c];
 	if (class & Digit)
 		return get_one_number(c, nextchar(stream), stream);
 	if (class & Letter)

-- 
Alecs King
