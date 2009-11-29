From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] Ignore "naked" attribute
Date: Sun, 29 Nov 2009 23:59:12 +0100
Message-ID: <200911292359.13785.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:43188 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbZK2W7s (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 Nov 2009 17:59:48 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

The GCC "naked" attribute is used on certain architectures to generate
functions without a prologue/epilogue.

Ignore it in sparse.

Signed-off-by: Michael Buesch <mb@bu3sch.de>


---
 parse.c |    2 ++
 1 file changed, 2 insertions(+)

--- sparse-dev.orig/parse.c
+++ sparse-dev/parse.c
@@ -521,6 +521,8 @@ const char *ignored_attributes[] = {
 	"__model__",
 	"ms_abi",
 	"__ms_abi__",
+	"naked",
+	"__naked__",
 	"no_instrument_function",
 	"__no_instrument_function__",
 	"noinline",

-- 
Greetings, Michael.
