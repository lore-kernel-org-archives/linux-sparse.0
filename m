Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BD279DB4
	for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586302; cv=none; b=fuGWWmkgkWgi6dtjnYnuq91PjsKyMrR8SifSME2iFQwB8RSDHZ1opdhwkAifV5UHis7s4Cg1m8CrvaL8OO4dCUTkOaIQO2KaRFsPTMG2t3aXu6DhAEil9vT3HDM5yKwbEuH7WAGX7iyY/Qk3weYDDvChTLJ/plOFTlbewpFr0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586302; c=relaxed/simple;
	bh=LKuHRjJgSTESnVZNFy+ZOoFzNHNWaOQmUuDPiB+tuc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrxlEFpi31oDgXatWrVVhIS9tIlWBVYzE14FBzo9caqpQmLVLYXBVZbDIxufI2XFbvnPo6BBNx31xZVk03DFSOKuqSgImEfnLOZYXLM1eUMa9RipN6JWiTK+RG0f7BO4yoE3t/D0dQCwtsJpETU+7x91m2Sh317ZYA9ORQmKXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=HNX0/uLS; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="HNX0/uLS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=NYa3xx6SlvyrbONR2VMUYvPrat09evei/YcWuf3T6lc=; b=HNX0/uLSo75kwQ/i
	EHsTwSrp2q9kiUrfghqF6cehqYG3xLXNCRr2nX1cN5wVUJdwkatB8Wwl8/31J15EtIhgfG7N5N/1s
	pF0KPpea/uO0TcrxxMqnUqjGyV25K6hANE0mf5z/VsOg25j/uFeR+xRMnvhAmGytgnjU0goQ4LUSg
	dbHM2Mx3Hz2cQPREI9P2KNCDa1G9LR/kLorqcJVHLTLAAV/289uwhoPNCr3cPvxFEknwqTpZszmrU
	jyo6FmYp81wHKJVWN2CnHAByOpcQXa3yhOHhLEvTqhqjXE8uWHBEhZSi5v4xyZ70QIrsPr6xVpCjs
	HiJghRtaATMXWTR5Sw==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vgo5K-002Qlp-KU; Fri, 16 Jan 2026 17:58:11 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vgo5L-000000001n3-1cr0;
	Fri, 16 Jan 2026 17:58:11 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	sparse@chrisli.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v3 2/4] add -Wformat
Date: Fri, 16 Jan 2026 17:58:07 +0000
Message-Id: <20260116175809.6849-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260116175809.6849-1-ben.dooks@codethink.co.uk>
References: <20260116175809.6849-1-ben.dooks@codethink.co.uk>
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

