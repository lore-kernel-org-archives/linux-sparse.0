Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3631E84C
	for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852744; cv=none; b=Fs4SB3yAyhvYpbj+fQq/KOxQyY+jZz4/qaudGJpJCnUEX+ApVMX9AJIc7ufR6B976u1TcT+YqRRtmW2XjEVWoVibX/5TfIjT6Crta0h8fXj7x1CyR1V75/Qli/W4fVJkHfgfMzonPp25xAi2pW15sB4PNY0o5i+fQZ7VdK/1qxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852744; c=relaxed/simple;
	bh=LKuHRjJgSTESnVZNFy+ZOoFzNHNWaOQmUuDPiB+tuc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cG7YBQjFGF/QQ3q8bF1gXxgMUwDVQQL8WhJw2F/jnnEsWDsOVzfEWe6jaSCv4o+6DwYgbX9LHcAeUsJs6APYNfoz8iQYIzgGau8dFa17rp7SEtGuAcZxaQ1kYSs0wOW3v/69WNJWv14h0rZ19klHAOF/rgyDKOOATC7SbgCqAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=nT3S8mfG; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="nT3S8mfG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=NYa3xx6SlvyrbONR2VMUYvPrat09evei/YcWuf3T6lc=; b=nT3S8mfGv0tHirkW
	RZNX7qSVIhRMW7uo8VuoHG4TjoxRSxhHpVMwfRfovyUPAD2dlE51SjEFnbjkTeeKXahDXk6cwvbNc
	c17ZYQuyNn4jl1NMNFFOvjFacDbnctk1T0gJbGWdYffRhjyRL2IVstfvkJug5stuQe2CVdDBttI9p
	DcOPEOGDJbEfIXfVv7oJYoNgz30sFH0USTdewQDcpCgRsNOoMf8JzBVGlOsS9T+5qhBCcxZlbjxP6
	u32W+7YHzHtu7QSYmXhUauOoJvuwG9W8LCUyFhBaFRI4nQb9mcR7AuRST4RufQVjYdycU5LPNnpFl
	RZTmZxAqmaL4iL9sOQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1waTIE-00Ap9p-Dk; Fri, 19 Jun 2026 08:05:34 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1waTID-0000000033k-2SFq;
	Fri, 19 Jun 2026 08:05:33 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC v4 2/4] add -Wformat
Date: Fri, 19 Jun 2026 08:05:30 +0100
Message-Id: <20260619070532.11664-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
References: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Add option to enable/disable format checking (and default it to off)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 options.c | 2 ++
 options.h | 1 +
 sparse.1  | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/options.c b/options.c
index 6ee4d878..54ac00b4 100644
--- a/options.c
+++ b/options.c
@@ -106,6 +106,7 @@ int Wflexible_array_array = 1;
 int Wflexible_array_nested = 0;
 int Wflexible_array_sizeof = 0;
 int Wflexible_array_union = 0;
+int Wformat = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
@@ -865,6 +866,7 @@ static const struct flag warnings[] = {
 	{ "flexible-array-nested", &Wflexible_array_nested },
 	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
 	{ "flexible-array-union", &Wflexible_array_union },
+	{ "format", &Wformat },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
 	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
diff --git a/options.h b/options.h
index c2a9551a..105c45d0 100644
--- a/options.h
+++ b/options.h
@@ -106,6 +106,7 @@ extern int Wflexible_array_array;
 extern int Wflexible_array_nested;
 extern int Wflexible_array_sizeof;
 extern int Wflexible_array_union;
+extern int Wformat;
 extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
diff --git a/sparse.1 b/sparse.1
index 2fba7e7a..64b0571e 100644
--- a/sparse.1
+++ b/sparse.1
@@ -285,6 +285,14 @@ To have any effect, at least one of \fB-Wflexible-array-array\fR,
 be enabled.
 
 Sparse does issue these warnings by default.
+.B \-Wformat
+Warn about parameter mismatch to any variadic function which specifies
+where the format string is specified with the 
+.BI __attribute__((format( type, message, va_start )))
+attribute.
+
+Sparse does not issue these warnings by default. To turn them on, use
+\fB\-W-format\fR.
 .
 .TP
 .B \-Winit\-cstring
-- 
2.37.2.352.g3c44437643

