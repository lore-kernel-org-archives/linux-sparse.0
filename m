Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EA349B18
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644473; cv=none; b=SL++dV7v11rYeabIcvRHD1lPwC7IwTx8CwL1Q5DxSL8DX2/QLsEMe3mKJT299BSncoam2YEZh3lQxYvPPXJHPstx96MAeHD8smivXReSmiqXQJ3wTDsRaW9MgCT0J2tqHPWs073kXFXUKQURtlzknqa5D3CrG0Waa/K7jv71ujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644473; c=relaxed/simple;
	bh=EONa4J68KQxg8RFpZXnfuBzQWWJpeSoEqN9BWy+zrlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mzcdtp0T36qh+mL1kp6zP56Wu7FaxmKQpwRE3BN2pbPckyYLKgLdsljylq8VkL5C9acqALOCumlezPULAdexuiRoUMB73rGCG4Aokh1VtXB+16pgjwbC47HC9sD7YA5pZXkKapbC3CwpKtcjcW6aX2dZnDR9qJfFEbvc9S2h47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Bpc4fy9A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Bpc4fy9A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2MhP/h1NP3FEbuRLwJ+b16puZdt/Ewugl715srCAW4w=; b=Bpc4fy9A7FkO77fEVQYArFCFKT
	gK4EfMSgectPTi/97EDGWGmMS6qzhQBoSwE/5SXgd/ungxP7IdjQl10QTJR5C3e8FMuXndzF62gFG
	+wavjH7QMt4D18Tc95wr4pwRnMdF/craOqqp3uMMKSlk1uGchTYoXmoWJvJZ7wSedigo/rFvEMS5E
	NDW1mGfevnCoVLL9BYuPgUMvrWMwwkmIacHFuKp+rWM9B+1YqVxadNutGa3sZm+qPHTRqzBHbcrLE
	Tjh0XAhFgGQDVo1BskOR9J/3X98DOf61C+bKXQ3tydQ/zZdo4WtAtkP5aoLrNgPU3/hmHlFA0PEKy
	ngJzXVYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zt-00000003E1c-0tTh;
	Mon, 16 Mar 2026 07:04:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 07/21] make expand_has_...() responsible for expanding its argument
Date: Mon, 16 Mar 2026 07:04:01 +0000
Message-ID: <20260316070415.768839-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316070415.768839-1-viro@zeniv.linux.org.uk>
References: <20260316065622.GA607739@ZenIV>
 <20260316070415.768839-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

If we want to make expansion of arguments on-demand, we need to adjust
->expand() calling conventions first, passing it unexpanded arguments.
Switch create_arglist() to setting argcounts from normal=1 to quoted=1,
provide a helper (first_arg()) that does actual expansion and make
->expand() instances use it.  After that these fake arglists are used
only for two things: they indicate that these macros are function-like
and they short-circuit expand_arguments().  Once we switch to on-demand
argument expansion, the second role will disappear and we can just use
&eof_token_entry as ->arglist for those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c                           | 17 ++++++++++++-----
 validation/preprocessor/has-attribute.c |  3 +++
 validation/preprocessor/has-builtin.c   |  3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 17ed7f85..85662365 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -2000,9 +2000,16 @@ static int handle_nondirective(struct stream *stream, struct token **line, struc
 	return 1;
 }
 
+static struct token *first_arg(struct arg *args)
+{
+	struct token *arg = args[0].arg;
+	expand_list(&arg);
+	return arg;
+}
+
 static bool expand_has_attribute(struct token *token, struct arg *args)
 {
-	struct token *arg = args[0].expanded;
+	struct token *arg = first_arg(args);
 	struct symbol *sym;
 
 	if (token_type(arg) != TOKEN_IDENT) {
@@ -2017,7 +2024,7 @@ static bool expand_has_attribute(struct token *token, struct arg *args)
 
 static bool expand_has_builtin(struct token *token, struct arg *args)
 {
-	struct token *arg = args[0].expanded;
+	struct token *arg = first_arg(args);
 	struct symbol *sym;
 
 	if (token_type(arg) != TOKEN_IDENT) {
@@ -2032,7 +2039,7 @@ static bool expand_has_builtin(struct token *token, struct arg *args)
 
 static bool expand_has_extension(struct token *token, struct arg *args)
 {
-	struct token *arg = args[0].expanded;
+	struct token *arg = first_arg(args);
 	struct ident *ident;
 	bool val = false;
 
@@ -2057,7 +2064,7 @@ static bool expand_has_extension(struct token *token, struct arg *args)
 
 static bool expand_has_feature(struct token *token, struct arg *args)
 {
-	struct token *arg = args[0].expanded;
+	struct token *arg = first_arg(args);
 	struct ident *ident;
 	bool val = false;
 
@@ -2103,7 +2110,7 @@ static void create_arglist(struct symbol *sym, int count)
 		token_type(id) = TOKEN_IDENT;
 		uses = __alloc_token(0);
 		token_type(uses) = TOKEN_ARG_COUNT;
-		uses->count.normal = 1;
+		uses->count.quoted = 1;
 
 		*next = id;
 		id->next = uses;
diff --git a/validation/preprocessor/has-attribute.c b/validation/preprocessor/has-attribute.c
index 3149cbfa..dd0f275e 100644
--- a/validation/preprocessor/has-attribute.c
+++ b/validation/preprocessor/has-attribute.c
@@ -6,6 +6,8 @@ __has_attribute()??? Quesako?
 #endif
 
 123 __has_attribute(nothinx) def
+#define A packed
+456 __has_attribute(A)
 
 #if __has_attribute(nothinx)
 #error "not a attribute!"
@@ -49,6 +51,7 @@ __has_attribute()??? Quesako?
 
 "has __has_attribute(), yeah!"
 123 0 def
+456 1
 "ok gcc"
 "ok gcc ignore"
 "ok sparse specific"
diff --git a/validation/preprocessor/has-builtin.c b/validation/preprocessor/has-builtin.c
index 03272fc9..010d44bd 100644
--- a/validation/preprocessor/has-builtin.c
+++ b/validation/preprocessor/has-builtin.c
@@ -28,6 +28,8 @@ constant_p
 #endif
 
 123 __has_builtin(abc) def
+#define A __builtin_constant_p
+456 __has_builtin(A)
 
 /*
  * check-name: has-builtin
@@ -39,5 +41,6 @@ constant_p
 abs
 constant_p
 123 0 def
+456 1
  * check-output-end
  */
-- 
2.47.3

