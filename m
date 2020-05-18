From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH] univ-init: conditionally accept { 0 } without warnings
Date: Tue, 19 May 2020 01:54:46 +0200
Message-ID: <20200518235446.84256-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgERXyw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 19:54:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46AC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:54:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so13787336wra.7
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:54:51 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Junio C Hamano <gitster@pobox.com>, =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In standard C '{ 0 }' is valid to initialize any compound object.
OTOH, Sparse allows '{ }' for the same purpose but:
1) '{ }' is not standard
2) Sparse warns when using '0' to initialize pointers.

Some projects (git) legitimately like to be able to use the
standard '{ 0 }' without the null-pointer warnings

So, add a new warning flag (-Wno-universal-initializer) to
handle '{ 0 }' as '{ }', suppressing the warnings.

Reference: https://lore.kernel.org/git/1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com/
Reference: https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Suggestions for a better name than this -W[no-]universal-initializer
are warmly welcome.

-- Luc


 lib.c                      |  2 ++
 lib.h                      |  1 +
 parse.c                    |  7 +++++++
 sparse.1                   |  8 ++++++++
 token.h                    |  7 +++++++
 validation/Wuniv-init-ko.c | 14 ++++++++++++++
 validation/Wuniv-init-ok.c | 11 +++++++++++
 7 files changed, 50 insertions(+)
 create mode 100644 validation/Wuniv-init-ko.c
 create mode 100644 validation/Wuniv-init-ok.c

diff --git a/lib.c b/lib.c
index f9ec285e8fea..9ee8d3cf6b21 100644
--- a/lib.c
+++ b/lib.c
@@ -295,6 +295,7 @@ int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
+int Wuniversal_initializer = 1;
 int Wunknown_attribute = 0;
 int Wvla = 1;
 
@@ -782,6 +783,7 @@ static const struct flag warnings[] = {
 	{ "typesign", &Wtypesign },
 	{ "undef", &Wundef },
 	{ "uninitialized", &Wuninitialized },
+	{ "universal-initializer", &Wuniversal_initializer },
 	{ "unknown-attribute", &Wunknown_attribute },
 	{ "vla", &Wvla },
 };
diff --git a/lib.h b/lib.h
index b18295a889cb..5e6db111170a 100644
--- a/lib.h
+++ b/lib.h
@@ -184,6 +184,7 @@ extern int Wtransparent_union;
 extern int Wtypesign;
 extern int Wundef;
 extern int Wuninitialized;
+extern int Wuniversal_initializer;
 extern int Wunknown_attribute;
 extern int Wvla;
 
diff --git a/parse.c b/parse.c
index a29c67c8cf41..48494afc6f2c 100644
--- a/parse.c
+++ b/parse.c
@@ -2750,6 +2750,13 @@ static struct token *initializer_list(struct expression_list **list, struct toke
 {
 	struct expression *expr;
 
+	// '{ 0 }' is equivalent to '{ }' unless wanting all possible
+	// warnings about using '0' to initialize a null-pointer.
+	if (!Wuniversal_initializer) {
+		if (match_token_zero(token) && match_op(token->next, '}'))
+			token = token->next;
+	}
+
 	for (;;) {
 		token = single_initializer(&expr, token);
 		if (!expr)
diff --git a/sparse.1 b/sparse.1
index 574caef3acbb..50e928392573 100644
--- a/sparse.1
+++ b/sparse.1
@@ -428,6 +428,14 @@ However, this behavior can lead to subtle errors.
 
 Sparse does not issue these warnings by default.
 .
+.TP
+.B \-Wuniversal\-initializer
+Do not suppress warnings about 0 used to initialize a null-pointer
+when using '{ 0 }' as initializer.
+
+Sparse issues these warnings by default.  To turn them off, use
+\fB\-Wno\-universal\-initializer\fR.
+.
 .SH MISC OPTIONS
 .TP
 .B \-\-arch=\fIARCH\fR
diff --git a/token.h b/token.h
index 292db167e4a8..33a6eda1cc53 100644
--- a/token.h
+++ b/token.h
@@ -241,4 +241,11 @@ static inline int match_ident(struct token *token, struct ident *id)
 	return token->pos.type == TOKEN_IDENT && token->ident == id;
 }
 
+static inline int match_token_zero(struct token *token)
+{
+	if (token_type(token) != TOKEN_NUMBER)
+		return false;
+	return token->number[0] == '0' && !token->number[1];
+}
+
 #endif
diff --git a/validation/Wuniv-init-ko.c b/validation/Wuniv-init-ko.c
new file mode 100644
index 000000000000..315c211a5db6
--- /dev/null
+++ b/validation/Wuniv-init-ko.c
@@ -0,0 +1,14 @@
+struct s {
+	void *ptr;
+};
+
+
+static struct s s = { 0 };
+
+/*
+ * check-name: univ-init-ko
+ *
+ * check-error-start
+Wuniv-init-ko.c:6:23: warning: Using plain integer as NULL pointer
+ * check-error-end
+ */
diff --git a/validation/Wuniv-init-ok.c b/validation/Wuniv-init-ok.c
new file mode 100644
index 000000000000..c39647517323
--- /dev/null
+++ b/validation/Wuniv-init-ok.c
@@ -0,0 +1,11 @@
+struct s {
+	void *ptr;
+};
+
+
+static struct s s = { 0 };
+
+/*
+ * check-name: univ-init-ok
+ * check-command: sparse -Wno-universal-initializer $file
+ */
-- 
2.26.2
