Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256429;
	b=0hllud1FMYc2fvbwOZlvduF+Q7pRYr+XvHzM86z0Wf0Znr2Tx52l6U+kr0umo4CHkght
	 Sp3El7WvIUUwo5YnWo0/I6eh/5tazBl1LUBM5GSTYPhDtGSIKJ47PDaSDns1wO1r58liD
	 opoUzG0oijyieddDdVZuXEj38Q1iGD12E5jLI67nBlA8C1DsuPcaaK9TYDgbw8PvxpQtN
	 EBg5FzcH/JC+0oqyYkFJm8IFg5X7+E+uMsVl5mO3ATxsOLdl+6aJvAH/0zCtLOKpZWstY
	 x0MS8wWrYbUAsDmRzeU7k4CkU3lWUIWJhFGOOvDWZ/fRw4n2RBb5q6IlbjEnjfTLHVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=MUwEKfKex9WyjXRSVn39cPM4B2nLY2BXDMWmw5ZXREo=;
	b=Wq/qYRVvoJEqr2hwhWHcqOVzsHalEDGW+9atp44Q+oMcCtJhLoGnhD/hhR46/7wKmDm4
	 VVvzfdIlvd7PodduR5BFx3dLY4/lqkVG3gx7mkHpILT5EA2AvDQNeaoAamJC2+c6rWzlZ
	 Be6+HLKm8UxzOMmaV6VmbFhHJK8xczRsKshEj0zsR+9OM16Mp8zpjH0KWP6injwMSBXhY
	 9J5QHfjxHh7lNsUg8lM/ReUfiHa/hqrjpIrCGe7U3uOdE958CRsl/RUcB5HGDHBkg8Q7k
	 kWPdQ9aPUA1b7lW0B5FC8GXXl1O2MCqmWzpSwwZ/TMAQkRp/pX3NNbqRc387kFmAhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=DDZz0r8s;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005C606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3005C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=DDZz0r8s
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMC5qCvz1XMFx7;
	Mon,  9 Nov 2026 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256420; x=1796848421; bh=MUwEK
	fKex9WyjXRSVn39cPM4B2nLY2BXDMWmw5ZXREo=; b=DDZz0r8sqJD3p7727rQLv
	/Y3pt2kJK4onA5w+Q+E37ip7N3W+4RPB4IiAfe1JMP/6sEndsMkng+0/58eS0qt1
	mL60krpthT4p9bh2ZPE2XZRaw/fwzVCS0yy3Xqz3hFOU2fTUXsTw/J3uq6Owp/8W
	/dznaKRhGvewzDdnAzcfzTEPJOl22tCGnMnZHNEDqNl2kYwX7W0RoUj1TWSRYUpW
	42Lc7/R3auPcIv5UfJj6+2Y2ZOrWHl7yGUgxcv/dqfJAUp/HhYmT/8LX9U/pkFUt
	NkqgE/1yZobxzKoeWNiv1+FVSYkRwofQ+k+bbpkI4za7rlIhAQiklc0g5EspB9+n
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NIUZgTHGYjTT; Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM80ZVpz1XLyhl;
	Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 71/73] x86: Undefine conflicting bitness macros when parsing -m flags
Date: Mon,  9 Nov 2026 12:32:57 -0800
Message-ID: <20261109203259.362845-72-bvanassche@acm.org>
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

Emit #undef directives for conflicting x86 bitness macros in
handle_mbitness() in options.c at the command-line position of -m16,
-m32, -m64, or -mx32, while preserving explicit -D macro definitions
that appear later on the command line.

Prevent inconsistent word size errors and static assertion failures in
the Linux kernel when real-mode 16-bit code is compiled under an x86_64
kernel build that passes -D__x86_64__ before -m16 in CHECKFLAGS, and add
validation/arch/x86-bitness-undef.c and x86-bitness-override.c.

Fixes: efd9af566c05 ("arch: move target-specific predefines...")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 options.c                              | 58 +++++++++++++++++++++++---
 validation/arch/x86-bitness-override.c | 17 ++++++++
 validation/arch/x86-bitness-undef.c    | 16 +++++++
 3 files changed, 85 insertions(+), 6 deletions(-)
 create mode 100644 validation/arch/x86-bitness-override.c
 create mode 100644 validation/arch/x86-bitness-undef.c

diff --git a/options.c b/options.c
index 2de74afc5c35..2e6e2ce0c2ea 100644
--- a/options.c
+++ b/options.c
@@ -671,13 +671,59 @@ static char **handle_multiarch_dir(char *arg, char =
**next)
 	return next;
 }
=20
+static int handle_mbitness(const char *arg, const char *opt, const struc=
t flag *flag, int options)
+{
+	if (opt[0] !=3D '\0' || (options & OPT_INVERSE))
+		return 0;
+	*flag->flag =3D flag->val;
+	if (arch_target->mach =3D=3D MACH_I386 || arch_target->mach =3D=3D MACH=
_X86_64) {
+		switch (flag->val) {
+		case ARCH_LP32:
+			add_pre_buffer("#undef __x86_64__\n"
+				       "#undef __x86_64\n"
+				       "#undef __amd64__\n"
+				       "#undef __amd64\n"
+				       "#ifndef __i386__\n"
+				       "#define __i386__ 1\n"
+				       "#endif\n"
+				       "#ifndef __i386\n"
+				       "#define __i386 1\n"
+				       "#endif\n"
+				       "#if !defined(__STRICT_ANSI__) && !defined(i386)\n"
+				       "#define i386 1\n"
+				       "#endif\n");
+			break;
+		case ARCH_LP64:
+		case ARCH_X32:
+		case ARCH_LLP64:
+			add_pre_buffer("#undef __i386__\n"
+				       "#undef __i386\n"
+				       "#undef i386\n"
+				       "#ifndef __x86_64__\n"
+				       "#define __x86_64__ 1\n"
+				       "#endif\n"
+				       "#ifndef __x86_64\n"
+				       "#define __x86_64 1\n"
+				       "#endif\n"
+				       "#ifndef __amd64__\n"
+				       "#define __amd64__ 1\n"
+				       "#endif\n"
+				       "#ifndef __amd64\n"
+				       "#define __amd64 1\n"
+				       "#endif\n");
+			break;
+		}
+	}
+	return 1;
+}
+
 static const struct flag mflags[] =3D {
-	{ "64", &arch_m64, NULL, OPT_VAL, ARCH_LP64 },
-	{ "32", &arch_m64, NULL, OPT_VAL, ARCH_LP32 },
-	{ "31", &arch_m64, NULL, OPT_VAL, ARCH_LP32 },
-	{ "16", &arch_m64, NULL, OPT_VAL, ARCH_LP32 },
-	{ "x32",&arch_m64, NULL, OPT_VAL, ARCH_X32 },
-	{ "size-llp64", &arch_m64, NULL, OPT_VAL, ARCH_LLP64 },
+	{ "64", &arch_m64, handle_mbitness, OPT_VAL, ARCH_LP64 },
+	{ "32", &arch_m64, handle_mbitness, OPT_VAL, ARCH_LP32 },
+	{ "31", &arch_m64, handle_mbitness, OPT_VAL, ARCH_LP32 },
+	{ "16", &arch_m64, handle_mbitness, OPT_VAL, ARCH_LP32 },
+	{ "x32",&arch_m64, handle_mbitness, OPT_VAL, ARCH_X32 },
+	{ "size-llp64", &arch_m64, handle_mbitness, OPT_VAL, ARCH_LLP64 },
 	{ "size-long", &arch_msize_long },
 	{ "arch=3D", NULL, handle_march },
 	{ "big-endian", &arch_big_endian, NULL },
diff --git a/validation/arch/x86-bitness-override.c b/validation/arch/x86=
-bitness-override.c
new file mode 100644
index 000000000000..ac51ecb244a8
--- /dev/null
+++ b/validation/arch/x86-bitness-override.c
@@ -0,0 +1,17 @@
+#ifdef __x86_64__
+defined_x86_64
+#endif
+#ifdef __i386__
+defined_i386
+#endif
+
+/*
+ * check-name: arch/x86-bitness-override
+ * check-command: sparse --arch=3Dx86_64 -m16 -D__x86_64__ -E $file
+ *
+ * check-output-start
+
+defined_x86_64
+defined_i386
+ * check-output-end
+ */
diff --git a/validation/arch/x86-bitness-undef.c b/validation/arch/x86-bi=
tness-undef.c
new file mode 100644
index 000000000000..ab2434c1173b
--- /dev/null
+++ b/validation/arch/x86-bitness-undef.c
@@ -0,0 +1,16 @@
+#ifdef __x86_64__
+defined_x86_64
+#endif
+#ifdef __i386__
+defined_i386
+#endif
+
+/*
+ * check-name: arch/x86-bitness-undef
+ * check-command: sparse --arch=3Dx86_64 -D__x86_64__ -m16 -E $file
+ *
+ * check-output-start
+
+defined_i386
+ * check-output-end
+ */
