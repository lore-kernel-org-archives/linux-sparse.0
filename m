Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432616;
	b=1WsTFG2G5ar+IlVRlwXsvM+UIGhKtDI0aQTiSenL4sVphVYFe/Eb0Uq0nhlruRJpaRuD
	 b30DW8bcidFFQDZBvR/JO5mWlIjlXI1XyNYQOG4wb/rkIpNn2xs2iGaDItrUJE4mDqTTx
	 ptYCWYNYQAaOUiU6qiIVP3cTri/0UlWfMrwPMBR+LK/h2j45yZp5xKzbh3gJYsMfySg6B
	 fbKYNbMGiNi2S8fTwPTw1/0TSJVVUIu6zBpy8vhxurmhx2iczP8sLUWa32/RLtnTW7uzG
	 Cqb1Pj1qDyUwFrZN6HbjzmgYiSOFhUffb46LUTo6u4C3UMHtQC/pJ/VSjp1di6fHx8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=5xKkavuX1pF796DfjviBYLYHvCl2xsZPKZQEudD1UEc=;
	b=uR0Ewnh6WlYwJgfjivvt28U/HzGUIzFKojDRZk0ygKJGIIRxeggoWSsqDC5DyqSeoD74
	 9PONL3niTSmvpyMfxTq+UL3LyQpVR8EOY4LwBeFCzKNxjoHnr0SoxNnW8xHsFNyxHyeSz
	 cpNIxJLvnL3Oz2Zer0liP3Ta1gfoNB8xsOacNtd3G7jqzrAUZgyX1UOLTgz8h2JkXP0BH
	 XVJlpd3j0QohH8gzDodyw4Yjen7I+OSX8PuwjgM+CeOuKn8WFNJOvbMg6H3+6vGRKXhvz
	 Nyr2juF65py7Xs2OM+f7OlsS9F+Q/WlQqLIqOMbcDesw1n3IN//a9m6HrtPhjlcA6Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=z3oMq8uP;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E3606A324
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B92E3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=z3oMq8uP
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsq6Rlvz1XM6Ht;
	Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432606; x=1795024607; bh=5xKka
	vuX1pF796DfjviBYLYHvCl2xsZPKZQEudD1UEc=; b=z3oMq8uPIuDOvcFgBu9R6
	UVE6U4vXibzAXMNiKeh5Z4BjsNaBLu/wM/WH5NSfL/IET6h6b0m3pO8mLIieHsRh
	sUaCX0LKGyV9vG8pLl06aT+Jxd2svB5HF0sd6xQbxhEZ7lFtIV5K+sm9oqggfKOU
	nrbSBlAqNa1/FSuM6QEoZqCF5+1j+4nsQMz2V/b04wQVjQCDBz7OogoNmEwH4+ao
	6sisEWWI2pCdIcgAUUSeUaj6CWQ5ZJCj4vPuXUszFcct1EC04bem71DDIpmXRNp+
	tJo+htP5FOciK2yjr0yQAqdF25ywlh28pZk8BhVIkwm89bqd4FCaDfdSBJaAlbIU
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZD1s0ntYkvIf; Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsn4Hs0z1XM30h;
	Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 15/20] sparsec: Emit object files directly with llc -filetype=obj
Date: Mon, 19 Oct 2026 10:56:28 -0700
Message-ID: <20261019175633.415493-16-bvanassche@acm.org>
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

Modern LLVM llc supports emitting object files directly via
'-filetype=3Dobj'. Use 'llc -filetype=3Dobj' instead of piping assembly
output into the system assembler ('as') to simplify the compilation
pipeline and fix test-suite failures when using LLVM 14+.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 sparsec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparsec b/sparsec
index 3f9b60c67e0a..57a02d51cd48 100755
--- a/sparsec
+++ b/sparsec
@@ -45,7 +45,7 @@ case "$(uname -s)" in
 	;;
 esac
=20
-$DIRNAME/sparse-llvm $SPARSEOPTS | $LLC ${LLC_ARCH_OPTS} | as -o $TMPFIL=
E
+$DIRNAME/sparse-llvm $SPARSEOPTS | $LLC ${LLC_ARCH_OPTS} -filetype=3Dobj=
 -o $TMPFILE
=20
 if [ $NEED_LINK -eq 1 ]; then
 	if [ -z $OUTFILE ]; then
