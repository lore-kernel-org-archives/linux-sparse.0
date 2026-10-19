Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432612;
	b=v/Q2rLzmxqHRnoeFj+y43OfxuAp7clABp4GO85HDXbnt/tAqZfF2MsUUAFAfg4jFEGx9
	 ANa2xD/g2x/x2Y9TRJqmvKyuwF82B6ZWVA/MmNFRMHvtDZZdOp3uzB+wwX1tItImnOudX
	 r15ZMr2XvW25Ctm0yugbk5xytPryZGvWDiPkNs3haNmDhy+7hyWmYfAMnrr3aTQcIGiX8
	 VcplIL2u2SHp1wZ4+vY4bCqMob7n0MYf5ZSysskN4DFxm9oKR6azoRuhFK06dZ+B34YPF
	 /9/7ywt8sOSbLr36Mvnp7fbJ6ScLey6huphcVadhJ7OILViAEbTn/qYJp90qbr5r7Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=AkJ6aU8Ip3cHBs/fb/7HkymM2jJamjH2DnIK+kkM8gs=;
	b=PlqgU2SgiRpAVuxEwuTI6eJWO+XcBvesId9qsreomsAvJTueMRM7cCRXJjomuAARZ/Gm
	 0PRTDkC0ToE2BPBVJZhfEV/7Kw85UEVPeTsvllx3uMKB9UJVbiuj+iUjCASOhmEQtb8rJ
	 dzEApq/pYtWCRufm4+Etgr9Ib9ibfW3R12Ah+5dSyCp5CocjNKtTHxayNbyxuWeZQ64f+
	 JBSNRjDTXH0GfJg+uw7uiuYQtctIK06WXCQL3ckYdnjMmSTYHwIc8HyGgO+VQ170ZpZpJ
	 CEhZ9PyTFOXz8Fa3GvsHm1kr7276pUS7Eux7TqpGkm/HN5FQbvhue6Nq+hBhGvFToeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="P/OtX5Q/";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317D606A319
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E317D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=P/OtX5Q/
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsn54qbz1XM6JF;
	Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432604; x=1795024605; bh=AkJ6a
	U8Ip3cHBs/fb/7HkymM2jJamjH2DnIK+kkM8gs=; b=P/OtX5Q/7bM0zU4T/LPy4
	KAsqSSoV4uPSNOSYT3YJQM3HTDMmntQSfGJ/DbZrFBSJHHEUUSGTWjw4PP0o1tJE
	OQoDpYrxNe5WedRQtP0DGr/x55C+G9savmEL6HkEutxxyJa0dMYJocAFnpkeMY35
	X+Fc0fiTvwOl6oDcqgkLUsPmHjkLgpeBNwc0cdshdXX/kobEj4QUm/rWIZm/kLRq
	j/1HdWNDHSivs+ywwZUG8nKOhqc8kqLHIxtKhxLDWl0COUNUSkEqSIFRn9VtzqkF
	MSOUnjcErCpMzjVPz1/C/c/jAwY96lOkeICt7VY3tA0iT4D+cpo3o+t4aNyyu8/g
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JKV2mMxSOaF1; Mon, 19 Oct 2026 17:56:44 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsl018Wz1XM30r;
	Mon, 19 Oct 2026 17:56:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 05/20] builtin: Bound argument array iteration in declare_builtin()
Date: Mon, 19 Oct 2026 10:56:18 -0700
Message-ID: <20261019175633.415493-6-bvanassche@acm.org>
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

Bound the loop over entry->args[] in declare_builtin() with
ARRAY_SIZE(entry->args) before reading entry->args[i], and remove the
sentinel member _args_null_tail from struct builtin_fn.

Prevent out-of-bounds array reads past the end of struct builtin_fn's
six-element args[] array when declaring six-argument builtins such as
__atomic_compare_exchange_n, avoiding AddressSanitizer bounds errors.

Fixes: 935cf032524f ("builtin: use a table for the builtins")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 builtin.c | 2 +-
 builtin.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin.c b/builtin.c
index a704c5e8447c..1f3568bbad47 100644
--- a/builtin.c
+++ b/builtin.c
@@ -658,7 +658,7 @@ static void declare_builtin(int stream, const struct =
builtin_fn *entry)
 	fun->ctype.base_type =3D get_ctype(entry->ret_type);
 	fun->variadic =3D entry->variadic;
=20
-	for (i =3D 0; (arg =3D entry->args[i]); i++) {
+	for (i =3D 0; i < ARRAY_SIZE(entry->args) && (arg =3D entry->args[i]); =
i++) {
 		struct symbol *anode =3D alloc_symbol(sym->pos, SYM_NODE);
 		anode->ctype.base_type =3D get_ctype(arg);
 		add_symbol(&fun->arguments, anode);
diff --git a/builtin.h b/builtin.h
index 5fe77c926244..8f82d138bec7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -8,7 +8,6 @@ struct builtin_fn {
 	struct symbol *ret_type;
 	unsigned int variadic:1;
 	struct symbol *args[6];
-	struct symbol *_args_null_tail;
 	struct symbol_op *op;
 };
=20
