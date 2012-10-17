From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] Inherit nocast modifier when referencing  a variable
Date: Wed, 17 Oct 2012 19:12:53 +0200
Message-ID: <1350493973-6210-1-git-send-email-lars@metafoo.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp-out-123.synserver.de ([212.40.185.123]:1126 "EHLO
	smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504Ab2JQRSV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Oct 2012 13:18:21 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

The nocast modifier should be inherited when referencing a variable, so add it
to MOD_PTRINHERIT.

E.g. without this patch the following code snippet ...

	typedef int __attribute__((nocast)) test_type;

	static void foo(test_type *a) {}

	static void bar(void)
	{
		test_type a;
		foo(&a);
	}

... incorrectly generates the following sparse warnings:

	nocast_ref.c:8:10: warning: incorrect type in argument 1 (different modifiers)
	nocast_ref.c:8:10:    expected int [nocast] [usertype] *a
	nocast_ref.c:8:10:    got int *<noident>
	nocast_ref.c:8:10: warning: implicit cast to nocast type

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 symbol.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/symbol.h b/symbol.h
index 1e74579..c7ec35b 100644
--- a/symbol.h
+++ b/symbol.h
@@ -229,7 +229,8 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE | MOD_NORETURN)
+#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE | \
+	MOD_NORETURN | MOD_NOCAST)
 
 
 /* Current parsing/evaluation function */
-- 
1.7.10.4

