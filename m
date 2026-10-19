Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432614;
	b=TY/TjmJy+Jk/bxDIv0j1PDOXAzT3EPC74WwlTdmlTN66Rog4UT048KFeXi0EI1CnTstG
	 gCTO4AsSyLD7oUYJ4ZDvDYAAWwILu9+5DQ0Zp1wTtvTbZzfazXmEmi5ZprBUJoGNFr4KU
	 lnh25lasEZKb0benfc3JR5f7OK0tA9f0/0ZbnDPCfkznAqx6aPJrruDgw4hNf7a8XEKxk
	 fqKaIeGreCV5b5Zu0kNR4kvcc4zkMf6bVyqSvr3T4iI5CDskKo6kPS1nSltfv8T6Q9yrW
	 gVcCINOeTdaCrzAXel/6zaJigPR5NK0EuGuCAhBYu3E2l/cpkU4Mmaxr4j9dwlTXwwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=TvtJs1ARGQT5I+pscgt24p7Y1pver8t2/3x3b7AFPJc=;
	b=xcEIl6TkR9tFhbTHd9zcLUBNj24jCjbZTkh4jwmD59rndmSY7mP7EZIRoDUF5x4Zdq8k
	 ieVMhExVBwaLlSvgSyEVzvB2BlE0f0KJ47IdHpofz1O5M4ktAqY6bG4Cn8W+FdAaPXuYx
	 75n25ycgV/ROaxwbaZuNldL1s+JiLJcmLt5vhj8L4ues9iATDYKJjp1t9d3H7NMKyNa+0
	 PP6qsiteb/WvsbYUSA9SFXmU/pNKebvdAwYpjRA3cmcTBCP99mKZPnEp7SOyTwoN5ob8i
	 YWXxw67YQCN44S0gYHt9qiHlnEI6+lfv0XR+cC4LTVaWPLky7uMpl7NwkzH0p2chzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yoB+fPLp;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73E606A31F
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C73E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yoB+fPLp
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsq0lsVz1XM6J5;
	Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=TvtJs
	1ARGQT5I+pscgt24p7Y1pver8t2/3x3b7AFPJc=; b=yoB+fPLp08LFKuF/ABhQ6
	PCc3rcHY4LZ5yxUK45UIOR2oEe2SO/V1M27Nk5FOrYM4M7xaHvyj+DU78W6iXZsW
	sipCq0/uM0bDpVGxHxwVrm9pt9kUKnjaNIKQWQrNNlMKgX83KWQj/GWrIucbJotJ
	vd0Lqlm/4AG9sSYOn39/t9ErtS8b5Q84oz2F5YDzPkYNMukOa8qNrYgYX2vpWKZ4
	oeqeqQ/+NkW/Q58GwlmqlYf3g8bvmOQedJ6k8hnsw4eeAYtPzkAtF2ncdzmmqTSt
	nI1KPX8JxRXdX5cOnpx+fOKT06fWjoB3ytdWj/ABZb/NKvYFBClc3Ihb8awTm4qW
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7crdpGlrL-nh; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsl5Sy5z1XM4Tn;
	Mon, 19 Oct 2026 17:56:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 08/20] pre-process: Avoid zero-length VLAs for parameterless macros
Date: Mon, 19 Oct 2026 10:56:21 -0700
Message-ID: <20261019175633.415493-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261019175633.415493-1-bvanassche@acm.org>
References: <20261019175633.415493-1-bvanassche@acm.org>
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

Ensure at least one element when declaring the variable-length args[]
arrays in expand() and dump_macro() by using nargs ? nargs : 1 instead of
nargs.

Avoid undefined behavior in C from declaring zero-length variable-length
arrays on the stack when expanding or dumping function-like macros define=
d
with an empty parameter list (nargs =3D=3D 0).

Fixes: 669244d22464 ("[PATCH] lazy-copy macro expansion in pre-processing=
")
Fixes: 9b4e30eb0baf ("teach sparse how to dump macro definitions")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 pre-process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 4e322855d600..038e019b11c9 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -745,7 +745,7 @@ static int expand(struct token **list, struct symbol =
*sym)
 	struct token **tail;
 	struct token *expansion =3D sym->expansion;
 	int nargs =3D sym->arglist ? sym->arglist->count.normal : 0;
-	struct arg args[nargs];
+	struct arg args[nargs ? nargs : 1];
=20
 	if (expanding->tainted) {
 		token->pos.noexpand =3D 1;
@@ -2285,7 +2285,7 @@ static int is_VA_ARGS_token(struct token *token)
 static void dump_macro(struct symbol *sym)
 {
 	int nargs =3D sym->arglist ? sym->arglist->count.normal : 0;
-	struct token *args[nargs];
+	struct token *args[nargs ? nargs : 1];
 	struct token *token;
=20
 	printf("#define %s", show_ident(sym->ident));
