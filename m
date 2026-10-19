Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432615;
	b=2a6fzESJfjN/XnU8KV3KT5lcOabmn1mUd3rB1jkvoEswIEx+kUmw3jiQzofrOhxmxBGs
	 PJvF9Ut0BHY7RqBnI6C3lIRm6DOfln9Nhnl58DbLeQ8DRGwQ0tWz6O7Uz5m4RuyBf6Ezk
	 RGBkadGr/YBhxbZMN49wvMPHzr9cEoIEfKzSPiGFALD0uk1qqQXLWTexxkogiaBATBK92
	 zltmgF7X5BKaQdWzKxxZ+2ReY9hMBgruykWuxQ2wpNYkM9m8NthUjjRMRl3oq8gPXUHmn
	 WepFE33kNUNwyMsMv7q9Itu9WdUbAQD9Df22E3i+T99V+XFskcznGtSX7Ij4RSThCaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=q5wPOaDvPsRAf8H6zHXqBU6G2b8Yr5sdKeRM9HH3Spk=;
	b=fZrCcXXzYkpMt6c2w6KwiKSYBX2uZ4+kseiWW4tUyet56kVVnj7HMa0WwhqQSv8ni3EW
	 8nRFvX+hwcIxflOMV7oyL57KPcuWlOqxf4OwyQzBOu+La12qvPDQ1vdhSzC9t/QSDQbRu
	 EGm9qUSM+oZxx989488MEio98HhLqhNE4YXb8hJzrJxwpAdNQfVRiYKIumgM1y73/Xw6c
	 LXg7sdHMpDVFqfqyNkSI29qaarkVXs6O2x2cENiXHhv1MZWPDSoBHm7bZIfF5U2ve3UUD
	 x9EfFKUYBcdYdz6xoXKhXF/yN3JZ9xxaJcAx8AePBM0V5o7wsALhX+1tltskzz04oSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4cMu8UxR;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C421606A322
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C421606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4cMu8UxR
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsq2LFMz1XM6JP;
	Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=q5wPO
	aDvPsRAf8H6zHXqBU6G2b8Yr5sdKeRM9HH3Spk=; b=4cMu8UxR1Ao4fW3HR+Cdu
	L2aFFfezK1Hs7g+eWYZZMBlwzwOTxCspWizx+FRwdf1Ruf8BP4jH/srosa2JX+iW
	SuZBEaeyTe4JHHrotlSbNY0UR3mbpbcMEnU1oJL5j74kBYOCH2ZXqYVr3tXxchGF
	ppk6BUg7EHTBPljSHXlRTpAza+HVbf66U0hGkxZuhvNarUxFUjEnRP3Pox14xmcQ
	NDuOOWme9zkU0X+PWDYrsLommJO6cgUzeHMEEZ/+zwhDQ3MfTbS1rvYiu4cZMX8Z
	DS0NG0f3SrTu2V6e0xYW294dDAQCr9liYZhjOU9jS/0BTzIkWqPa9nPOHpAmMN/f
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ldUQnUYACk7S; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsm00ssz1XM6Ht;
	Mon, 19 Oct 2026 17:56:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 09/20] pre-process: Avoid reading token->string on non-string tokens
Date: Mon, 19 Oct 2026 10:56:22 -0700
Message-ID: <20261019175633.415493-10-bvanassche@acm.org>
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

Check whether token_type(token) equals TOKEN_STRING before accessing
token->string->data in token_name_sequence(), and call show_token(token)
in the else branch.

Avoid dereferencing an inactive union member of struct token when
processing non-string tokens such as identifiers or punctuation in
computed or angle-bracketed #include directives, preventing undefined
pointer formation on non-pointer union payloads.

Fixes: f9d206d60eec ("Properly expand tokens on #if/#elif/#include prepro=
cessor lines")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 pre-process.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 038e019b11c9..7b6555677570 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -787,8 +787,10 @@ static const char *token_name_sequence(struct token =
*token, int endop, struct to
=20
 	while (!eof_token(token) && !match_op(token, endop)) {
 		int len;
-		const char *val =3D token->string->data;
-		if (token_type(token) !=3D TOKEN_STRING)
+		const char *val;
+		if (token_type(token) =3D=3D TOKEN_STRING)
+			val =3D token->string->data;
+		else
 			val =3D show_token(token);
 		len =3D strlen(val);
 		memcpy(ptr, val, len);
