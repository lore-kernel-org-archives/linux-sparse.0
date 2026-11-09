Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256408;
	b=0mYfPVE7Q12LtV+phQTQKw4DLexsQR1IUe4f8t0habvJcCZkYX0Ra9r/qS4PFOrrst1y
	 zdM8TXIs1AOFJaSB7vRbJ+gxohHjf09cPRylPo9kyNLHt8FAR5ECVvW2gu8zIbG+o//Cz
	 mSMoG6Ra5qOwt7feb6+0H6e0bOHhTup95kJpXVAQn4BrqiQdy07zBjPueHOJKdZgsYl1P
	 Il1krGYDHdipi40uE0pwq6zyM7UVng/bxkYBuVXapBmEnBjR6rAOJsEwACnN8vR1AZnDP
	 NNcQutcKehO11+wcT9jBd6IVRaPH/ZrGCzjSBZqKCcdMbl7CybWyv65GAafaWX0RVNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=rehh1i2Hs7hCRkmBz03U7J71YOeTjeE5B0URGHjj7EA=;
	b=MCCeLrfsY/hpdl32TtnVkKd0OCUABi9V7oPO+lLgq8CKcmX1cveDzQMS9XXdRPAIWFpL
	 FzdG2ptykwNHHoeeQWSU4zBeTF6ZA625e5ZQ4JFdG/KOR4/SgDdEh91Uem3YDoUxhzQFS
	 mDL2OgDSPrhqCEi3vNPwHYXcf+FuYIl7I24ShNQuzOO1batnm+N2qzou38TzVTxb7Fzqm
	 8cD02RVVW50jvRBQrHSaP3/u1SjZf2KAJ2ieMlAlRG3+JCzi+ZtgnvVe2WQRs/CD/QM7X
	 J9NFbXRPPxgTzSmLI69U5VfJFR9wEx440kcp4VcUtiFnd984ZyrbfMgihxEJmismPDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=YFVTrcKp;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BA606A321
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 804BA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=YFVTrcKp
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLv0mrCz1XLwXN;
	Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256405; x=1796848406; bh=rehh1
	i2Hs7hCRkmBz03U7J71YOeTjeE5B0URGHjj7EA=; b=YFVTrcKpuajQ3mI/eA6Ni
	J8e9XXILNc4+Hp6hp/uOtCjBi74YQ7k9clDHhzDq1HcUt6S4e2OB5r0AZwC9JGIc
	a7CltOsvYocxMzuvWHZy/mawQTQEsEyHTLc/7fKJzKx0/4tBrQxbNfKMsh7xynuV
	lnXOLigAJSS5AZt0m5fANEJsM66MpfxMF21bnnRv84o86lCbiXLqW1/4cLASAt0W
	oHej2RpGfAV7kFtuDj5tocYVM6un6fNn5PXI7imWbSzNzSE3wzG32BX4ShXGRzfA
	MdoT4ijr5vngvIdMm5p3TKkKBPt6JQQ5Y1CAMDiReBoR9CJXGvP4ha+nS8+iuQk/
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iZlZxZ6-3hW5; Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLr5DGjz1XM6JF;
	Mon,  9 Nov 2026 20:33:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 02/73] sparse-llvm: Use LLVMCreateBuilderForModule() with LLVM 24 and later
Date: Mon,  9 Nov 2026 12:31:48 -0800
Message-ID: <20261109203259.362845-3-bvanassche@acm.org>
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

Call LLVMCreateBuilderForModule(module) instead of
LLVMCreateBuilderInContext(context) in output_fn() when building against
LLVM 24 or later so that sparse-llvm builds without a deprecation warning
after LLVM commit 46db5f8ab053 ("[llvm-c][ocaml] Accept Module instead of
Context in IRBuilder bindings (#234209)").

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 sparse-llvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index facce6f745ff..c422a13ce2a8 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1182,7 +1182,11 @@ static void output_fn(LLVMModuleRef module, struct=
 entrypoint *ep)
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
 	LLVMSetLinkage(function.fn, function_linkage(sym));
=20
+#if LLVM_VERSION_MAJOR > 23
+	function.builder =3D LLVMCreateBuilderForModule(module);
+#else
 	function.builder =3D LLVMCreateBuilderInContext(context);
+#endif
=20
 	/* give a name to each argument */
 	nr_args =3D symbol_list_size(base_type->arguments);
