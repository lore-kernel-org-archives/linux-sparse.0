Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256424;
	b=vHHrwcZz7WqoAs90vU2khF6QcUAZTy9bQG7GtLdtJh5iTbS4G/6wS+KayGc4Jao5HTwy
	 rDKPMApqlyydMPpZq8ABI19gqryLRg1w8jEp9Nsnjlf7rKLTZLxIDREE5GapyYQKpbHlg
	 4r2qcqnKakvzjXWrv1OlqoTjeOcxcdvsBwJEEqoma1o3nQUKPKlMIQobObxVjsakZ0nj1
	 sN6nEXIj9VaB9SvdfkDG3019r594iypp+R9uhUfNlanXOihBN9ZccXtruXXx8E5m2EBN8
	 QHiA+yecB4jW70Pd7gfYDjdshXp4HxOSz3yhV8v3dK3Ruy3CqNm0cCWsxjzHISGC5zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=MTOnAxLFCON0eYPzz9crnIJAIXlA5E4I+6h2LNT7UWE=;
	b=xZP7mPt3EHGuh+avZZBRB1zzwBoswkUJsAkMWp6leCg0dKEA5qwJvAZV9ZEYXf/AFFoH
	 8EaeXUin3szeGn2XETdgYpyzEblGyUsnoPsDkaQZjzla9vDxTSOL1h7uORG8sIlB7a31F
	 k/E9nUd042ovS9Jiaq+iWC/WUvrdxVOqzCHjFKh/UUMeMQ9I0rWxP1kY5FL3v/r+7ugiV
	 QCsFVq4yYr9LLj2pPJBM6tYlhfpFmj7wkR13sH+hW5iB7vnUUs5sADTeI45cDUp5OvVgH
	 CWBr7//U1Gg/+IfCOOx01a1TMmaxzJzRecdwNGw24XDlUDpGy+Zkob/Okslqgsn4Q4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=NrsqccUp;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E30606A335
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E30606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=NrsqccUp
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM71x4Tz1XMfrh;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=MTOnA
	xLFCON0eYPzz9crnIJAIXlA5E4I+6h2LNT7UWE=; b=NrsqccUpsNSKK9fqsXYFL
	W0L1+mmh8Z+6ghtdo6zH/jJfhZXBHjhs0ASkScN/jErcgOpOzUeRLazVVS+/0xHh
	4i+Ua/V1inPaKaei0caUwLNUdTNiv4BAZ33bQ4nV4pTPIk3uoG/q6heANeTADDPO
	gO71wlQWAVVDJ0RKT3lwNBaZ7VTENMqncjISAoMxtmFtLvC49detYM9Nla+Bk6wA
	0wbpUHT0guDf5RqTz66zw0no3Xk35+yZH/XstPLX2HT4RLSKikJHLvGdr8CMQd5T
	x7MGmKmRsehp6qL47okhQZXBafJ996vjD+Be1kTJz6H1Et2uOxBOoGz2MlyTHiI1
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RdYxtk4uQVfd; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM100Mxz1XMYJY;
	Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 39/73] options: Add support for -std=c23, -std=c2x and -std=gnu23
Date: Mon,  9 Nov 2026 12:32:25 -0800
Message-ID: <20261109203259.362845-40-bvanassche@acm.org>
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

Add STANDARD_C23 and STANDARD_GNU23 to enum standard, handle the c23,
c2x, iso9899:2024, gnu23, and gnu2x arguments to -std=3D, and set
__STDC_VERSION__ to 202311L when targeting C23 so that users and build
systems can select ISO C23 and GNU23 language modes and feature-test
macros.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 options.c                     |  5 +++++
 options.h                     |  2 ++
 predefine.c                   |  4 ++++
 validation/c23-stdc-version.c | 11 +++++++++++
 4 files changed, 22 insertions(+)
 create mode 100644 validation/c23-stdc-version.c

diff --git a/options.c b/options.c
index 5aa3290e07da..c140a912e8e9 100644
--- a/options.c
+++ b/options.c
@@ -797,6 +797,11 @@ static char **handle_switch_s(const char *arg, char =
**next)
 		else if (!strcmp(arg, "gnu17") ||
 			 !strcmp(arg, "gnu18"))
 			standard =3D STANDARD_GNU17;
+		else if (!strcmp(arg, "c23") || !strcmp(arg, "c2x") ||
+			 !strcmp(arg, "iso9899:2024"))
+			standard =3D STANDARD_C23;
+		else if (!strcmp(arg, "gnu23") || !strcmp(arg, "gnu2x"))
+			standard =3D STANDARD_GNU23;
=20
 		else
 			die("Unsupported C dialect");
diff --git a/options.h b/options.h
index c2a9551a78e2..94eb7d10e362 100644
--- a/options.h
+++ b/options.h
@@ -27,6 +27,8 @@ enum standard {
 	STANDARD_GNU11 =3D STANDARD_C11 | STANDARD_GNU,
 	STANDARD_C17,
 	STANDARD_GNU17 =3D STANDARD_C17 | STANDARD_GNU,
+	STANDARD_C23,
+	STANDARD_GNU23 =3D STANDARD_C23 | STANDARD_GNU,
 };
=20
 extern int die_if_error;
diff --git a/predefine.c b/predefine.c
index 5b0f0caf4c35..d6ab0785abad 100644
--- a/predefine.c
+++ b/predefine.c
@@ -111,6 +111,10 @@ void predefined_macros(void)
 	case STANDARD_GNU17:
 		predefine("__STDC_VERSION__", 1, "201710L");
 		break;
+	case STANDARD_C23:
+	case STANDARD_GNU23:
+		predefine("__STDC_VERSION__", 1, "202311L");
+		break;
 	}
 	if (!(standard & STANDARD_GNU) && (standard !=3D STANDARD_NONE))
 		predefine("__STRICT_ANSI__", 1, "1");
diff --git a/validation/c23-stdc-version.c b/validation/c23-stdc-version.=
c
new file mode 100644
index 000000000000..a2903362f2f3
--- /dev/null
+++ b/validation/c23-stdc-version.c
@@ -0,0 +1,11 @@
+__STDC_VERSION__
+
+/*
+ * check-name: c23-stdc-version
+ * check-command: sparse -E -std=3Dc23 $file
+ *
+ * check-output-start
+
+202311L
+ * check-output-end
+ */
