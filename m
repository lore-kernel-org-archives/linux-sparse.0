Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF225E469
	for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612666; cv=none; b=CdT0a5JpUMxchp5b80gfjHljXIHWR+awfLMELK26bZlO9OYok6jBZTrKdooBJjFppjUIAT3yxs0xPHat2hcdiBpoCYiQDOTrwidt/nGnMRbAvUUV6SrBCrhOF3AeAumuiYjdkNI0OIVNkOvv0EHHx49de50yFKhOXgV1AZGZ7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612666; c=relaxed/simple;
	bh=LKuHRjJgSTESnVZNFy+ZOoFzNHNWaOQmUuDPiB+tuc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8DmYXPH8QnYOkFk2r83Wj8X/5JWK6eoKnI4d8+goqdAGGdsEy3a2fNFAlKkwD4cSJWGbGaGEDf9bZ2Yim4L6w13p3XRV/NcLFEYlS0m4TaED6Us2I93EBqD0zV2salWACbTePzC3NXkrG1iEv8JZPy3l0bjLRxqymzYcOmgg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=n1FDwKXT; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="n1FDwKXT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NYa3xx6SlvyrbONR2VMUYvPrat09evei/YcWuf3T6lc=; b=n1FDwKXTCDgWwFRETv+JBo/JtH
	eSASzPIzVFH0SZpE8Y1kgjJUA1ycV6FqGHDjNGxqRnOMEIK6Fu7sJaPD37UXkjd6ohDiGOQi9j37T
	SSZtLqERnuo+6x21NV7zKrIuHly4lg0+xKGRUNa9OOh381NqXiGGENs+xxMpPc43YXcW5YzbsX6q3
	R03469dYHNMbt2Fah3djndp7PDabRJ98srFx7DIdIIfL5epRY1o+3ddoJUYdbokDtVNE2532Rr7H/
	H8GjDjqG6Hp4GqMv0O/zehSwCdS9pVjfP+3BbJ3XaLHd8YL1mE7UsE3pQCIJcGNFBb5yrSSotZfj7
	Eleu7aJA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v9LmK-004bE5-Tf; Thu, 16 Oct 2025 12:04:16 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1v9LmK-00000002e2c-2cTt;
	Thu, 16 Oct 2025 12:04:16 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH RESEND 2/4] add -Wformat
Date: Thu, 16 Oct 2025 12:04:13 +0100
Message-Id: <20251016110415.630506-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
References: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
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

