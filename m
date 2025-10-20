Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC51DE3A5
	for <linux-sparse@vger.kernel.org>; Mon, 20 Oct 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974770; cv=none; b=cEKFH9XStx7HVVIhEI77io8gZSGQL/tnSZtNCxmDTIiYBjerhWrUVY/HCAoIENl7tHrATNM2MfA9A3lmWUuWNqUrifmj8lke55bmvtyide9R0X91Ur56EQMkHk72yBb9mTy1XZrBZLezHBYCPeQrn+tzn3wh5TdzjVkOtXJM+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974770; c=relaxed/simple;
	bh=LKuHRjJgSTESnVZNFy+ZOoFzNHNWaOQmUuDPiB+tuc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBZ1tP+2Uqa4i9NRfZPNztzEX7dPryCBex4PTMC83S24sPzMluxzfclB4V64GLfwvkZcVdM+2Zq4ZTWFeKl/z2HBi0X9CqNDoiNCX7Xs9OeBoOYF6FSrxX6TTiC1tGehcIVCk1tZ8wTVvl77PRMZoVCE98ZC1buF2h+uCawB1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=PJw+vgMI; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="PJw+vgMI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=NYa3xx6SlvyrbONR2VMUYvPrat09evei/YcWuf3T6lc=; b=PJw+vgMI81KzccjU
	HSg8VoyIy4jZGSWmZADNG770+Dtk0v48oZGwNsCIcQZh7or7sVSLvw173eUp44hAPY2hUu2Gn/wzb
	rjxhG+x2+wfDwlhiOzFtf5++wTYwu/Zm489/U+Tnp/+kbyJmyJHxgh8d+mTOz4XMjkZILTfy9nq8E
	M1YPgmp79J4XxroyZacqJnIHtHYl0mjBzQf7ZzqGY9vfl10JUz2BY0mBaiG3VtXQXAYta6Se4Xm7M
	7366l0+hF7TluRD8/xVeOwRv3bi7lQijEkfENeRKSzh4J7Xw4cpV69dNNO8KxSy8h2F5zEOmDABmm
	khXliU5wiwZU8BO/uQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vAryh-007Qml-TA; Mon, 20 Oct 2025 16:39:19 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1vAryh-00000003PJ7-1sNN;
	Mon, 20 Oct 2025 16:39:19 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH RESEND2 2/4] add -Wformat
Date: Mon, 20 Oct 2025 16:39:16 +0100
Message-Id: <20251020153918.812235-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20251020153918.812235-1-ben.dooks@codethink.co.uk>
References: <20251020153918.812235-1-ben.dooks@codethink.co.uk>
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

