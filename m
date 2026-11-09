Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256406;
	b=EH62J7IoPeDK/92b1yno+xGt9hoPTkpOtkAkiX1NGFCfOwMah8QbP9W2wbD/gDCk6USg
	 F/1IScYNUUYQJpB2HvDMzoZ1laDspJ9QWhNhIodvGHpGMblLo3ckiD07ZQlb6pwUldF7x
	 Q5l5Jkeymz9GYxvbMgu+WcLQroWQgrOgAJol4Nmhn812uSqfotftjI+wSkZBe3FQVnU+4
	 Yg9k85B11FwfHT19WORbMfgPHaNyzY0O+2kc24qRnGZU1nTNgOh0FcwMs2w7YiTqBZsv/
	 TPsRanzMu5HGVzIf8QUU/YN3NLojjWYzFkhq1F2JclAQ1AMEoaRzisrfcCB635MDyNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=vMCI9uuCpf+rsuGNk3OH4dtS9kOF0ELS1K/3IjT41a8=;
	b=GFPCHC0PoR1Z0JDGiQ0gdtjFAAIf8IS9Fqt8J/H54zGM5YJHKtGwfPZtdBax20gYXcdo
	 +QoChvgQMWdMaYQXCVl4npNLbJfONj4XtauszCDiuEwXbz+jhHF2GegBTTOP/49prcP3I
	 AU4tz/yeD3XF7g/8TGOe0cw9joQVkyvE+b7wtlSJPUqCXX7ecLBgV8X+U175rJxXh/Ei4
	 uIPdqTkKoe7P0fh9ny6coBnp4kN4l0zdK3lfuceNqcd3gIYg3HnLVKnwZKfrh2bVG9SDP
	 iR/Y41H1gBL0t0ffleXnqS2MFFQiqWbN9YQ/7LZqrXP2u2hc1PnD7VdM6jAh80KnDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="whKsqm/2";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2C606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC2C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=whKsqm/2
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLs4GXcz1XM0nl;
	Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256404; x=1796848405; bh=vMCI9
	uuCpf+rsuGNk3OH4dtS9kOF0ELS1K/3IjT41a8=; b=whKsqm/29C0q8ZZ/XUNEM
	ywFCJfLaRPRzACdn9btDfMsuNq57z0G5ywbGTex7/5CaV0R8bSwjKakDGp6Bum0l
	CPiLfpq3n4qyPMpD4TDOKTote+4JWmcg5Q63413+HSU3W2eHTv2msOiIXZltZqNK
	Xtx+0N1Fvd6kQAzLwlhE0aeljzT7dxwnbu5e1gbzbs4fe0z1Q1Zwhy+si98Ma4cI
	kCSP5icYURpdkpNtW8XMDa93sX1uiwMzAOJPTIRss+mpG7CKLWePXOxP5GFW1w7y
	LMipFK8W+aFv//pqA8GFahzQsud6bn0OxYrLqQRYJVrK+mbKuNVn933mcjGg+++k
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4HmK52V7q11z; Mon,  9 Nov 2026 20:33:24 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLr3Nthz1XM6J7;
	Mon,  9 Nov 2026 20:33:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 01/73] Makefile: Pass '--' to rm in clean target to handle dash-prefixed files
Date: Mon,  9 Nov 2026 12:31:47 -0800
Message-ID: <20261109203259.362845-2-bvanassche@acm.org>
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

Pass '--' to rm in the clean target so that stray files starting with a
hyphen (such as '-.o') are not interpreted as command-line options by
rm.

Fixes: 86eb97a3c2df ("Makefile: stop cleaning files we didn't make...")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e172758b8b09..4d2700f5cad3 100644
--- a/Makefile
+++ b/Makefile
@@ -288,7 +288,7 @@ validation/%: $(PROGRAMS) FORCE
=20
=20
 clean: clean-check
-	@rm -f *.[oa] .*.d $(PROGRAMS) version.h
+	@rm -f -- *.[oa] .*.d $(PROGRAMS) version.h
 clean-check:
 	@echo "  CLEAN"
 	@find validation/ \( -name "*.c.output.*" \
