Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432610;
	b=CCsPw2G/2NASFkSjrSFpSOgmjtnrb82wt5yVRCjL3SeLdXA7I+7BR8SpKCJ07DUbZROK
	 6QXkTEGSMBucU0XjiCKyfD7w13Ru1BXGtDcOfnaeQafNp0vd/q/sG4VCXMeSq531xcOHD
	 wtBSkN7l0dLMJvfl72oaQSVcnoNPAy3iT1DgFIzZTypAgUkTKQidt3mblmXc8mYmnsN5f
	 R/Iqwm5yRsMpDGvVaSsKeSjKjzkpBIfEeX0DeikAbzLWQ/AGm2iVAikjJAdDgS1QBUEgA
	 WR/R9pADyVV3XB1lmq+9k+adPC7AGlvQwxJKTrIVCYJ2I6QdeYHSmknpU9QuYLucViA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=03w18RD9BwNfGVQQbcQN1voITgEJ0QzwxlpjGzVdwdQ=;
	b=kaJJFV1/SjJ5JESBM7CppoZyHMQhPtdACW3l0DrDdW7aZgep9EzbEtcVNplcviYv21Nu
	 +DjBZ9xKkpqV3sxQC0W9opqAnyDqUYLLT+bHzKbqAXcHJ5MOuT/GanjQp7eOpXfMVLVvp
	 A1HDK+tomZw2/UVPbcdQgLF5lg9D03mIYesTiatlNVSdfroLCQG4TVcrnQ2UgiJ36RJLv
	 IB4NA2X3V1MuevH+ThOKjJDlIk38b7GTus6KjicrQyIwQVxQSmcS3vZgSAHX8Q4YzHPm5
	 hACAZA7pqa5UJfw78WhmcWUFyKWGTaiS+5X23R7rAkMcyzjOcbVniqPfHnY8fr+wNbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="OjJ3U/Yb";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01353606A31D
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01353606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=OjJ3U/Yb
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsl51YWz1XM311;
	Mon, 19 Oct 2026 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432602; x=1795024603; bh=03w18
	RD9BwNfGVQQbcQN1voITgEJ0QzwxlpjGzVdwdQ=; b=OjJ3U/YbnJSKaEUMdgqvK
	LGFAlSXhTv3MYvHP1QjG+kuH7aCzCEXNYfRab08Txpuihs96amnRTJWJHnePadYr
	hdzLclIuVmOcOU5QhG2Odql0CgNXbvG8hs/8jwno5cbyVGjs2nhwuaOaxC5GfijT
	lL35/iuigOTmtfPo8mDj/rJDw7p3jG3tcH4F8NhMqlRkwtPWdhxhgJjOfL0xVT1M
	tKTxK2SoBz49x4S4IH9ZXMEfY9lVAwQE7x73zXL0W5LPtyYCLsuedwBhJ6LcynFb
	OrrPdfONkKdeTrd3RAROSmr5n05Ht3xgmzPc+LWdVZiiDqyMQxlFbFX/ZbdmTtIb
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h8r1SNooXqRJ; Mon, 19 Oct 2026 17:56:42 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsk0L42z1XM4Tn;
	Mon, 19 Oct 2026 17:56:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 01/20] doc: Update maintainer and mirror information
Date: Mon, 19 Oct 2026 10:56:14 -0700
Message-ID: <20261019175633.415493-2-bvanassche@acm.org>
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

Update the maintainer entry to list Bart Van Assche and replace the
unofficial GitHub mirror URL with https://github.com/bvanassche/sparse.
The maintainer information has been derived from the git changelog.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/index.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index f483c081681d..112a3751cc44 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -22,10 +22,11 @@ as mixing pointers to user address space and pointers=
 to kernel address space.
 Maintainer
 ----------
=20
-1. 2006 - 2009, Josh Triplett
-2. 2009 - 2018, Chris Li
-3. 2018 - 2025, Luc Van Oostenryck
-4. 2025 - present, Chris Li
+1. 2006/09 - 2008/08, Josh Triplett
+2. 2008/12 - 2017/02, Chris Li
+3. 2017/03 - 2024/02, Luc Van Oostenryck
+4. 2025/09 - 2025/10, Chris Li
+5. 2026/09 - present, Bart Van Assche
=20
 Getting Sparse
 --------------
@@ -36,7 +37,7 @@ repository with the command::
 	git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
=20
 You can also `browse the Git repository <https://git.kernel.org/pub/scm/=
devel/sparse/sparse.git>`_
-or use the mirror at https://github.com/lucvoo/sparse.
+or use the mirror at https://github.com/bvanassche/sparse.
 The tarballs of released versions of Sparse and their signatures can be =
found at
 https://www.kernel.org/pub/software/devel/sparse/dist/.
=20
