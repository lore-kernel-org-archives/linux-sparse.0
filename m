From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 7/18] Fix regression created by commit af30c6df74f01db10fa78ac0cbdb5c3c40b5c73f
Date: Mon, 09 Mar 2009 07:11:18 +0000
Message-ID: <E1LgZdu-0000tv-13@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43749 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbZCIHLT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:11:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZdu-0000tv-13
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:11:18 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


const and friends are reserved words, TYVM...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c               |    2 ++
 validation/reserved.c |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 validation/reserved.c

diff --git a/parse.c b/parse.c
index a2048a2..12d2bba 100644
--- a/parse.c
+++ b/parse.c
@@ -354,6 +354,8 @@ void init_parser(int stream)
 		struct init_keyword *ptr = keyword_table + i;
 		struct symbol *sym = create_symbol(stream, ptr->name, SYM_KEYWORD, ptr->ns);
 		sym->ident->keyword = 1;
+		if (ptr->ns == NS_TYPEDEF)
+			sym->ident->reserved = 1;
 		sym->ctype.modifiers = ptr->modifiers;
 		sym->op = ptr->op;
 	}
diff --git a/validation/reserved.c b/validation/reserved.c
new file mode 100644
index 0000000..caacd21
--- /dev/null
+++ b/validation/reserved.c
@@ -0,0 +1,40 @@
+static int (struct);
+static int (union);
+static int (enum);
+static int (volatile);
+static int (__volatile);
+static int (__volatile__);
+static int (const);
+static int (__const);
+static int (__const__);
+static int (restrict);
+static int (__restrict);
+static int (__restrict__);
+static int (typedef);
+static int (__typeof);
+static int (__typeof__);
+static int (inline);
+static int (__inline);
+static int (__inline__);
+/*
+ * check-name: const et.al. are reserved identifiers
+ * check-error-start:
+reserved.c:1:12: error: Trying to use reserved word 'struct' as identifier
+reserved.c:2:12: error: Trying to use reserved word 'union' as identifier
+reserved.c:3:12: error: Trying to use reserved word 'enum' as identifier
+reserved.c:4:12: error: Trying to use reserved word 'volatile' as identifier
+reserved.c:5:12: error: Trying to use reserved word '__volatile' as identifier
+reserved.c:6:12: error: Trying to use reserved word '__volatile__' as identifier
+reserved.c:7:12: error: Trying to use reserved word 'const' as identifier
+reserved.c:8:12: error: Trying to use reserved word '__const' as identifier
+reserved.c:9:12: error: Trying to use reserved word '__const__' as identifier
+reserved.c:10:12: error: Trying to use reserved word 'restrict' as identifier
+reserved.c:11:12: error: Trying to use reserved word '__restrict' as identifier
+reserved.c:13:12: error: Trying to use reserved word 'typedef' as identifier
+reserved.c:14:12: error: Trying to use reserved word '__typeof' as identifier
+reserved.c:15:12: error: Trying to use reserved word '__typeof__' as identifier
+reserved.c:16:12: error: Trying to use reserved word 'inline' as identifier
+reserved.c:17:12: error: Trying to use reserved word '__inline' as identifier
+reserved.c:18:12: error: Trying to use reserved word '__inline__' as identifier
+ * check-error-end:
+ */
-- 
1.5.6.5


