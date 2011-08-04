From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Recognize and ignore _Complex, artificial and vector_size
Date: Thu, 04 Aug 2011 17:38:11 -0400
Message-ID: <20110804213811.27256.73386.stgit@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:26583 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426Ab1HDViO (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Aug 2011 17:38:14 -0400
Received: from [127.0.0.1] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by smtprelay1.cesmail.net (Postfix) with ESMTPSA id CD1A534C8A
	for <linux-sparse@vger.kernel.org>; Thu,  4 Aug 2011 17:43:34 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 ident-list.h |    2 ++
 parse.c      |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index b94aece..973bf57 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -87,6 +87,8 @@ IDENT(fastcall); IDENT(__fastcall__);
 IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
 IDENT(restrict); IDENT(__restrict);
+IDENT(artificial); IDENT(__artificial__);
+IDENT(vector_size); IDENT(__vector_size__);
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
  * itself by name, preventing these tokens from expanding when compiling
diff --git a/parse.c b/parse.c
index 537055f..1c3e305 100644
--- a/parse.c
+++ b/parse.c
@@ -145,6 +145,10 @@ static struct symbol_op restrict_op = {
 	.type = KW_QUALIFIER,
 };
 
+static struct symbol_op complex_op = {
+	.type = KW_QUALIFIER,
+};
+
 static struct symbol_op typeof_op = {
 	.type = KW_SPECIFIER,
 	.declarator = typeof_specifier,
@@ -419,6 +423,7 @@ static struct init_keyword {
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "_Complex",	NS_TYPEDEF, .op = &complex_op},
 
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
@@ -486,6 +491,8 @@ const char *ignored_attributes[] = {
 	"__alloc_size__",
 	"always_inline",
 	"__always_inline__",
+	"artificial",
+	"__artificial__",
 	"bounded",
 	"__bounded__",
 	"cdecl",
@@ -563,6 +570,8 @@ const char *ignored_attributes[] = {
 	"__unused__",
 	"used",
 	"__used__",
+	"vector_size",
+	"__vector_size__",
 	"visibility",
 	"__visibility__",
 	"warn_unused_result",
