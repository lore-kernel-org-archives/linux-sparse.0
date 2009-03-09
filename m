From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 9/18] Fix handling of typedefs with several declarators
Date: Mon, 09 Mar 2009 07:11:38 +0000
Message-ID: <E1LgZeE-0000v3-1P@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43752 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbZCIHLj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:11:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZeE-0000v3-1P
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:11:38 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


We set MOD_USERTYPE only on the first one, so declaration_specifiers
didn't recognize something like
	unsigned P;
where P had been such a typedef as redefinition (see the testcase).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                    |    3 +++
 validation/multi_typedef.c |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 validation/multi_typedef.c

diff --git a/parse.c b/parse.c
index 7b1cfb6..1435fde 100644
--- a/parse.c
+++ b/parse.c
@@ -2365,6 +2365,9 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			return token;
 		}
 
+		if (is_typedef)
+			decl->ctype.modifiers |= MOD_USERTYPE;
+
 		bind_symbol(decl, ident, is_typedef ? NS_TYPEDEF: NS_SYMBOL);
 
 		/* Function declarations are automatically extern unless specifically static */
diff --git a/validation/multi_typedef.c b/validation/multi_typedef.c
new file mode 100644
index 0000000..d9ffd0f
--- /dev/null
+++ b/validation/multi_typedef.c
@@ -0,0 +1,15 @@
+typedef int T, *P;
+static void f(void)
+{
+	unsigned P = 0;
+	unsigned x = P;
+}
+static void g(void)
+{
+	int P = 0;
+	int x = P;
+}
+/*
+ * check-name: typedefs with many declarators
+ * check-description: we didn't recognize P above as a typedef
+ */
-- 
1.5.6.5


