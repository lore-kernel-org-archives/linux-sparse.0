Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AB220F2A;
	Mon, 13 Oct 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346735; cv=none; b=ShPDL+r9g+yQGtM/unaTehdjyn1NBzYJU+07gbmkOTMosVJ1WKmqzFB6PG32HQeU0/DAXVaKgLn1BLXh02/Y41VxT7OE4EH8USpgY2IS5d3+GbfIdFu1Z7zhfiGd3bGTRKPPNxlfU1r/cQCFOOjyRIrFtat2uq7TkkjRJfLmGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346735; c=relaxed/simple;
	bh=M8W+Wb/k76OFOUM9UgBamnEToea682kSXMrBJ0ukbFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NyEIcLA6scVUcJRSAsPkjqo+Z71rVPw0AXLNW1km1/ri5k4N8NuqJiaygTuePSgKUlyxi5xI18scoq87JAX6tB0lHvuYPiMYHwN+TQBrYOnFWxrc2puAkNf5kiY9bURmm1XOq9Q3UecMetRJqWV5JBchlplkeq3ifMG+WfZvqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nuDvZ2Ty; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8Ov/3r0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nuDvZ2Ty";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8Ov/3r0"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760346729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZK4MecEgmGNpR7Ho9yBfqoHrQQsss9GFbmPkcKt7iNQ=;
	b=nuDvZ2TyCNnYAcZtz9wg4tgUhbFl8w0FIf1jjac9laG65TMfw5W/2/1hihWigSwU+gcVit
	ABmzr1CRmy4+nhYIiwlfUnHPwbZJZK9GdMttJ8Y1SjPKZQlrSktgpoqLNbBL1AOKeFGzSB
	hn8Xq8aiL3kpP9t26/OOSbtgQlscf8f/+cX8EymW2DyQPexOH1FRq0ffkqSjmkvtJvbUhT
	JJw9eKMXDiNfrpruza1V02SJ8c18ZX9rJm4XDOC+DpSfOKPJPY+f5e+JupYXkAgf0NQ9Jh
	VKbzJxCr0iTdxT1v0sL5+u7/a09Dz+2P1EUL8kYPZ9ZPtWvqrOxpj0lcXxVybQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760346729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZK4MecEgmGNpR7Ho9yBfqoHrQQsss9GFbmPkcKt7iNQ=;
	b=t8Ov/3r0E4Qgs26/n+znn8CLkr+N9h0d7WEftC4lZjgZtItnwm3EEQ0nwSyGixO/H9wWJi
	8m/jheDAHrnlpUDg==
Date: Mon, 13 Oct 2025 11:12:02 +0200
Subject: [PATCH] compiler: remove ARCH_SEL()
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-arch-sel-v1-1-7eef9b22ceb0@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGHC7GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNL3cSi5Azd4tQc3SQLw+S0NEtzUwPTVCWg8oKi1LTMCrBR0bG1tQB
 T/eppWgAAAA==
X-Change-ID: 20251009-arch-sel-b81cff97505e
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760346727; l=1015;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M8W+Wb/k76OFOUM9UgBamnEToea682kSXMrBJ0ukbFw=;
 b=zOJlK3rirUFX63eCm18Ar6v8uhBK4Wifw8cnPKiGLy4eiT0y6vwXdEQ/Uy8CYOaYNAmiHLgbI
 frRZCQCqZ3gCxOIfkiQypBTZtkAlXR9IGuRq0CtMKOqzQ14EFJfAOog
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

It's last user was removed in commit 8ea815399c3f ("compiler: remove
__ADDRESSABLE_ASM{_STR,}() again").

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/compiler.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5b45ea7dff3e50160afc37d22f61b9d2146e15d4..a9a2f8aae821311da253bf065c49b7c69aa3af17 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -269,12 +269,6 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_64BIT
-#define ARCH_SEL(a,b) a
-#else
-#define ARCH_SEL(a,b) b
-#endif
-
 /*
  * Force the compiler to emit 'sym' as a symbol, so that we can reference
  * it from inline assembler. Necessary in case 'sym' could be inlined

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251009-arch-sel-b81cff97505e

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

