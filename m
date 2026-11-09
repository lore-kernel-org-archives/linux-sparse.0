Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256426;
	b=TTWiIT1292ZZtzt7pWoLhNttMi4S+tPhPoluT4ijOHChTPtlDwlECBYb4It0kiKEIchL
	 EOkGCV2eppIYV7aQtV3p7Clad2LvgElXPnAOBtYwR7Vsz+hgQhmGJ0k+aTJ0dfrvJ4W+D
	 veh/EcB9Nl9s+KYLrCYXjurjlpGX8Vm1YyRWwq9ISQjD8hraEzrPtl9uyX8ToClS+1PAx
	 kXUhMk5L+onOLcRELRiE+NaySZIslJRWRofvr0nr/HGL/HJxXKArhnoeThMMapjfultC8
	 Y96iiIcVTXxcBRpNU8MCHaoHTS2rcTOd2uZ1q3R2/KaIzt/FoeozzxmBuXomqemPAiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=faM50yzecqhg5oMxwq1slikLLO/hTDztZ3n886lEhj8=;
	b=P8BQDHmx+IUjU6B7uQrGYwMUjX0tY4BvX7IZBNe2c7M6FFq1sRmyBvpMZFYACwo8kbnJ
	 A/t9QFlPUQkCuNQNvbgQMbdXOekww5mYnCuoGOtoAWSUzNRT6ldSS0Z2BGaxRNPSohHXH
	 N1I1hrsU2Z92n3WkpPrwirCHvsmOv0a9HOCqlSiA6ZQxugruGjAam6iMT7cMyat16rVVn
	 jzkI13zQiEInU9YL3C9lZEANguWyXIsQqyaWyxLOQbFSbYpXQH7LQq8CRFX3C9//QcQMr
	 pmtQT5UZTFHIXy5gIu9PkEhZ3JAbcHIxzGyLlowL2hjcpA31tz8KKnYBrpGmXLQ6pmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Q6lv++cp;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C5606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9C5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Q6lv++cp
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM76cQcz1XMYJL;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=faM50
	yzecqhg5oMxwq1slikLLO/hTDztZ3n886lEhj8=; b=Q6lv++cp/OCWVV6o2schX
	qy9VlkTJZ19ca/35iDy6k4mg8sfVMfo65TBGooMBHZkpxclFFRqp2Vhxp6/LO57Q
	ACFbEPsALReZOaZkKjTGYV1Ykxku4/jxEb2ssiW3uR5AlTIE3MkM27zMQtTB+sr2
	6G96NHgJ1k5DeAL29vFdMu+gBPgBmENK9Rk/7gEdd1c9VZxDl4Ui5uOGc09fc6ei
	/F70iVAG+toyh0CAaMPCi90yCs+EgyXH8c5iKsDEga3BfrZdpaheiu+Y85Xuh9xW
	SrrIsutIVplIhyv1OTuQFyk2p8z+KLliBG0Uh3lnZJVtvnay5T/PIWljnSh5ljK1
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BsLk1OJ2qyIh; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM02953z1XLyhl;
	Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 36/73] bitwise: Don't remove MOD_SPECIFIER from 'bitwise' types
Date: Mon,  9 Nov 2026 12:32:22 -0800
Message-ID: <20261109203259.362845-37-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Linus Torvalds <torvalds@linux-foundation.org>

Preserve MOD_SPECIFIER on 'bitwise' (SYM_RESTRICT) types in
declaration_specifiers() so that signedness modifiers such as
MOD_UNSIGNED are not stripped from the restricted type.

Prevent clearing MOD_SPECIFIER from dropping MOD_UNSIGNED on bitwise
typedefs (such as 'typedef unsigned int __attribute__((bitwise)) le32;')
so ordered comparisons like '(le32)-1 <=3D (le32)0' are not evaluated as
signed comparisons.

Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ bvanassche: Rewrite commit message in imperative mood, pass
  expr->cast_expression to is_promoted() in evaluate_type_information(),
  and suppress redundant 'unsigned' modifier output for SYM_RESTRICT in
  show-parse.c ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/types.rst | 2 +-
 evaluate.c              | 2 +-
 parse.c                 | 1 -
 show-parse.c            | 3 ++-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/types.rst b/Documentation/types.rst
index 974f9861afef..dd5bb2107a7b 100644
--- a/Documentation/types.rst
+++ b/Documentation/types.rst
@@ -125,7 +125,7 @@ SYM_RESTRICT
 Used for bitwise types (aka 'restricted' types):
   * .ctype.base_type points to the underlying type (integer)
   * .ctype.modifiers & .as are like for SYM_NODE and the modifiers
-    are inherited from the base type with MOD_SPECIFIER removed
+    are inherited from the base type
   * .ident is the typedef name (if any).
=20
 SYM_FOULED
diff --git a/evaluate.c b/evaluate.c
index 4e8856aa6bcc..b84eedbe4d33 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2290,7 +2290,7 @@ static struct symbol *evaluate_type_information(str=
uct expression *expr)
 		 * promoted - check that here
 		 */
 		if (is_restricted_type(sym)) {
-			if (sym->bit_size < bits_in_int && is_promoted(expr))
+			if (sym->bit_size < bits_in_int && is_promoted(expr->cast_expression)=
)
 				sym =3D &int_ctype;
 		} else if (is_fouled_type(sym)) {
 			sym =3D &int_ctype;
diff --git a/parse.c b/parse.c
index 2675a3976099..c30a00eafb3e 100644
--- a/parse.c
+++ b/parse.c
@@ -1709,7 +1709,6 @@ static struct token *declaration_specifiers(struct =
token *token, struct decl_sta
 		}
 		type =3D alloc_symbol(token->pos, SYM_BASETYPE);
 		*type =3D *ctx->ctype.base_type;
-		type->ctype.modifiers &=3D ~MOD_SPECIFIER;
 		type->ctype.base_type =3D ctx->ctype.base_type;
 		type->type =3D SYM_RESTRICT;
 		ctx->ctype.base_type =3D type;
diff --git a/show-parse.c b/show-parse.c
index 8ef59b5ee255..850d6ce5f937 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -336,7 +336,8 @@ deeper:
 		if (as)
 			prepend(name, "%s ", show_as(as));
=20
-		if (sym->type =3D=3D SYM_BASETYPE || sym->type =3D=3D SYM_ENUM)
+		if (sym->type =3D=3D SYM_BASETYPE || sym->type =3D=3D SYM_ENUM ||
+		    sym->type =3D=3D SYM_RESTRICT)
 			mod &=3D ~MOD_SPECIFIER;
 		s =3D modifier_string(mod);
 		prepend(name, "%s", s);
