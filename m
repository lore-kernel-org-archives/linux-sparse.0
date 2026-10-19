Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432617;
	b=FaEm2cFz01hiAOsLOCzidOEgOf93uknSqucI8R/xUPOy3Y0GZoJ9jXgnER7F2UIBfPIb
	 uDqgYo7D9I0IiGo5YdTlqu0+UW0hNRxyaxy35X+zWOaLBZOGfajDVQ/JWNlCW2sKyHHgY
	 tR50+XFqqlJZz6X83gveErNtTWsDwr+30T3VV9RifNHBWhfDoo0MXAnkVDVwrqeT/19MO
	 nfZZJd/bH1y4IruHrMsd+cKNsefutEqRgxwTt9yQVwAaGLj7HPbm3TMNYASpHyu7VtF25
	 MHMH6LL3SUIs+M63bWh/FNvZ42UaKVQK6bO9h5Rh3dL5vyWC2cQI9GBQJMtCeTjVScg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=YHD1vvnVw5T97cutN0Z3Ms/DvuDnyWeMfpQ1N4g8Yrs=;
	b=jXpzlOXDo+zMBq/tYILX0QOGFTOvGWiy7sjcYue6LmIYEVIKYF94Izxt8XPxuY+0Uf+a
	 2fhw9BWrxZKDDRRAnlU+YFSAutX4LB22UNsraHPbMaeePJ6K3OB+V2Jka8WuiXnp6Z1cW
	 JKnxs3paW8zn0pW/mWo0ExwjwDdjCvr5WO2blX9shDUbMQ0FhHzTTNdSLNK2HPohWIT56
	 Qgu+TmZDJ/k/44eWeOXVZHyBahgjfF8vGcfo0q3BOxrDspFI0UVUF6A31UzksgFDqSCmv
	 7AVgEoBh+sEhtglVWZVgsTzFZ+8BichUQoAAl00Bk+LA35Pz/Azx/JIRBoulNHY4TUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Op4qoxo4;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3E606A327
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD3E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Op4qoxo4
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsr3F0mz1XM6JQ;
	Mon, 19 Oct 2026 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432606; x=1795024607; bh=YHD1v
	vnVw5T97cutN0Z3Ms/DvuDnyWeMfpQ1N4g8Yrs=; b=Op4qoxo4t2zBIxdqaDSYR
	TYeEx8EmKiCOov69qutbgY0Z6gKZM8s+8Bxc2XxgGqH0mId7WQc0EURj1/1j0yS0
	CgVsPkg9SNoxB3KMCQBO8RCI+x+N4TZ0oyOXbSMjC5Dmjd/XfHdqcsdG/AIYbetX
	8nbrdJTg64wuyHUKyznT7mdPCDbocHVmhyBi+KlWbek4AVNpilxoqaN7xRyFgFxS
	GnbzRGSZpxm5yaRsWh37HVTTzswJaq+H/O5D8noDVWOmHR6SRAk+u5omeZO+uKv4
	lsPe3Zz3tl7QP7uQTzV1Rp3LlpwG4YEdPIy/90WDBpi7795VJJJmag08cIn+T7fh
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2HLOHw8DTLRR; Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsn6B8lz1XM30g;
	Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 16/20] llvm: Stop calling LLVMConstGEP2() for string literals
Date: Mon, 19 Oct 2026 10:56:29 -0700
Message-ID: <20261019175633.415493-17-bvanassche@acm.org>
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

Return the string global variable directly in get_sym_value() when
compiling with LLVM 15 or later instead of passing it to
LLVMConstGEP2() with zero indices, and restrict the indices array
definition to LLVM 14 and earlier.

Avoid the LLVMConstGEP2() deprecation warning on LLVM 24 and omit the
redundant zero-offset constant GEP call because LLVM 15 and later use
opaque pointers (ptr) and fold zero-offset constant GEPs back to the
underlying global variable.

Fixes: 0544c547682b ("llvm: fix LLVM 15 deprecation warnings")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 sparse-llvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 90a931b76a0e..1155c2341251 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -311,7 +311,9 @@ static LLVMValueRef get_sym_value(LLVMModuleRef modul=
e, struct symbol *sym)
 		case EXPR_STRING: {
 			const char *s =3D expr->string->data;
 			size_t len =3D expr->string->length;
+#if LLVM_VERSION_MAJOR <=3D 14
 			LLVMValueRef indices[] =3D { LLVMConstInt(LLVMInt64Type(), 0, 0), LLV=
MConstInt(LLVMInt64Type(), 0, 0) };
+#endif
 			LLVMValueRef data;
=20
 			data =3D LLVMAddGlobal(module, LLVMArrayType(LLVMInt8Type(), len), ".=
str");
@@ -320,7 +322,7 @@ static LLVMValueRef get_sym_value(LLVMModuleRef modul=
e, struct symbol *sym)
 			LLVMSetInitializer(data, LLVMConstString(s, len, true));
=20
 #if LLVM_VERSION_MAJOR > 14
-			result =3D LLVMConstGEP2(LLVMTypeOf(data), data, indices, ARRAY_SIZE(=
indices));
+			result =3D data;
 #else
 			result =3D LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
 #endif
