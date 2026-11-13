Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569428;
	b=qRN8A7h7kNoP/WAVLR/Sm7UcdyztdhVfnRrF1huNLZRFZy1aHChVgVBIbZmjUy2UaRNo
	 XiaqO0EE/t6+N1EUe3XaU7nZuRa1CI9FSpQeMkcr9/F0QtwarzZavLg63CjFbPQJ7eImt
	 tPR3lFNeod3ZJ9qzvuW4Flyx3Aykx1u2+wgwadh/SsgVOOQZkhoTaa0RqXdqEIpKIv4bR
	 vsJy/Ald0jnsmr7TyI0G1vId5JRGW0Wcj7RTs361o6bmSdWXNb4v9QLXE6X81jgFXaJnn
	 7wXcqqkdvWyltqcrXRTMkRgTykdHx32CASD7MYFpDbv+l8BAV8poZn4Pbjt292UB2CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=8Je89T51T2LctLHyYFmc++OizS8/9zsUyvOTZbIhIaU=;
	b=f63VPZ33IGUOWRjdrw/xfbPAlii6SfvEnn5pcluz35Xmz3IMhn28rh+u5vqE/5bVdMmP
	 XIJi/OfI/KFG+/+c71VGTG6+33O9H1riC3RD1ZUx9++T7t4RDXx4e50TTY1oZN8BgM81s
	 zDKgOWFquO7AIr+aSuS5ZNTj4X1arpWW+2Vp4rPKRT+qtqzVWtq7wkY882bs9LG0u6VxD
	 gUNmOdU0S4ZBByBm4xgeK33THX7jGDdn7DrgRfvV57mx1cnJqO6JzQ5afLI2PSbPOtB43
	 i4dgDSH3vE/C9IWh1V2bQRADdoh6YZBJCxdFFYPBUhEBZcv4ivuZt4LQy2XeriBkltA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mUcLZpJQ;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8437606A339
	for <linux-sparse@vger.kernel.org>; Fri, 13 Nov 2026 11:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8437606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mUcLZpJQ
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14f6f58aeso994924e87.2
        for <linux-sparse@vger.kernel.org>; Fri, 13 Nov 2026 03:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794569426; x=1795174226; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Je89T51T2LctLHyYFmc++OizS8/9zsUyvOTZbIhIaU=;
        b=mUcLZpJQbYBWoHRUVtLPMCgY8QIdad1Yjt0R++LNr3e0CaMQmf/RoDYTdxhzxQN9wb
         s6g9V4pmR/41PmMuQ+SydSeGgVwIJH2AuV4jwBKESXb9mxyckdAqE/sv/m11w38u/cbd
         bOrGf8tIcWaqJZWgpqIf2eLrQvhze6SfN/zsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569426; x=1795174226;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8Je89T51T2LctLHyYFmc++OizS8/9zsUyvOTZbIhIaU=;
        b=cAgEWYu4JwND6/QsX6p0TINbOQSXK+KzrjgL+Vz1xGBSt4CtaLNHAUcD4JhGu3upbK
         UBZR/lCmEaMx15R0b0V05AZOdv1qy2sPzc42wwppCYGKeoB6dXYIyhgcTml/aEM+tety
         QN0O3jQhDW3stxjYgAYqBpD1MYUGMz9VFC2dFfa1HdwlPqOIV/dgugqoMhabeh0I0ZqO
         tStaEJ+wgepEq9U6g7nQztRW22e2lK6n/+dy3Wj42oU12BiYM/PM2gWONAelaGT4XxN2
         AHOjJSLeWODfa2ik8XJpxmrsw5dgSsQjwIjXofnmrVRNrS/hZTquKzUBL5EGbuUPb7wq
         Q5fw==
X-Forwarded-Encrypted: i=1; AL+hErHPvpTA6Zk41R0qBfOu8m/Ryus/aiS6U7wSmLeLsrzEPkXUR0yQEt5RsTCLyqnZRuJdfhO9aXgV62966Ms=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dhG6PA8PZ5Cccy09G/L2olWmvgJSVouDfTxXukmBeFlEnLMPY
	KaXgFWDAjxVvefUFkPoHwEqtK1NK9k9kSSR/ve4qRNvVgRoj2780uYo0zq0QGE8fiQXwqE1xJ97
	P/CI=
X-Gm-Gg: AYBFou0Sc9jUpwExDJVOk01UPFBCdfig24VMbyYhks3aRjngVRW3EwUtl9fMsy8k8tx
	1/wJ3tOFsIElSa+Itqzq3gqer3vcZTRpgrJmRpv+kN6Fbdw0GFeQAbhFY8/VFT82nxlfuOlROXV
	bKNPd3b6iCrOobDuc+Lh0i5BCA+doFHm0c61pZl9vijy3MIXggdudqhyrYmza745z/vM1EdifkX
	B/ko3F4UaXcTfffXsvf1FBXPUAp4u6gHEPmzXGEOSHIPPuK3KxCF4bUMwcU44n5MzX/3uKq0gEN
	OYcfVrynZhqXr6S2Kds1+MO0ePmTmyYOBBm2gCqA3CTSI9qWCBXArMQZGt4mMZ13a/TvxmKEcg6
	tvnw/bXdqycVJeH83YOkaNlIyh9tCDfdgt4/Vmn2PAekapuA5SPj4JE8UVeHfSEs/8jfhDJcceo
	vdTWIcD4jJDSzvWHOLo7bT0hWC1rYlVZMJlThqX8pCfM0h7zhHU8Bc1dO6NCzutj0+FgEfZp2j/
	64WD57fenWcCMKBMiUqqRR7frFpbz8KQIGBD8qENaVXhihhBnNh4ft/Ft4HufxmLPuKke2CqcL/
	9pEsxosDT0w2QmHS5sQjI/gb4q9c4xnJLbfXXyQ3WteYYs12qbiDsmkEMo2XReRyeNgobcBxNHJ
	agUJJsYyCog==
X-Received: by 2002:a05:6512:3b23:b0:5bf:d189:9e82 with SMTP id 2adb3069b0e04-5c17079b190mr936927e87.17.1794569425711;
        Fri, 13 Nov 2026 03:30:25 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712d9f5csm652154e87.4.2026.11.13.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:30:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 13 Nov 2026 11:30:20 +0000
Subject: [PATCH v3] x86/uaccess: Drop the address space qualifier from
 put_user()
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-unqual-v3-1-b32e19375202@chromium.org>
X-B4-Tracking: v=1; b=H4sIAMv09moC/2WMyw6CMBBFf4XM2prpWF6u/A/jotAWmgjVVhoN4
 d8tLDTR5bm558wQtLc6wDGbwetog3VjgsMug7aXY6eZVYmBkAqsKGfTeJ/klVGuaq1LYRRHSOe
 b18Y+t9D5kri34eH8a+tGvq5/icgZshJJmKbijTD1qe29G+w07J3vYK1E+po1Fx+Tklmg5AJLi
 a0SP+ayLG+B+yj22QAAAA==
X-Change-ID: 20260825-unqual-25d9ee74fd10
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Dan Carpenter <error27@gmail.com>, Chris Li <sparse@chrisli.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

__typeof__() preserves every qualifier, the address space included.

When we do __typeof(*__user *int), we are declaring a __user integer,
which is pretty much meaningless. A value in a register or in the stack
does not live in the user address space.

This annotation did not trigger any error until a recent version of
smatch[1] started caring. And as a result of that now we have tens of
warnings like:

  drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in argument 2 (different address spaces)
  drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
  drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *

Use TYPEOF_NO_ADDRESS_SPACE() instead of __typeof__(). Unlike
TYPEOF_UNQUAL(), TYPEOF_NO_ADDRESS_SPACE() only strips qualifiers when
running with sparse, while expanding to __typeof__() for normal
compiler builds. This preserves const/volatile mismatch checking and
has no impact on compilers that do not support __typeof_unqual__(),
which is why TYPEOF_UNQUAL() is not used here.

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f

Suggested-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/20260825-unqual-v1-2-7024fb81b4f9@chromium.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Recent versions of smatch preserve the address space qualifiers while
running typeof() [1]. This has triggered tens of new sparse warnings in
media-ci.

The RCU patch from earlier revisions has already been merged as commit
0381ade2ea82 ("rcu: Drop the address space qualifier from the dereference
macros"). This remaining patch takes care of x86/uaccess following Dan's
suggestion [2].

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f
[2] https://lore.kernel.org/all/CANiDSCuizbMt77XfrzGPMa3Biai5TF1vcs+C5qdhYoLrP=9b3g@mail.gmail.com/
---
Changes in v3:
- Drop rcu patch (already merged as commit 0381ade2ea82)
- x86/uaccess: use TYPEOF_NO_ADDRESS_SPACE() instead of TYPEOF_UNQUAL()
  (thanks David Laight)
- x86/uaccess: update commit message to explain why TYPEOF_NO_ADDRESS_SPACE()
  is used instead of TYPEOF_UNQUAL()
- Remove RCU maintainers and rcu@vger.kernel.org from To/Cc
- Link to v2: https://lore.kernel.org/r/20260914-unqual-v2-0-60a1407a0cd4@chromium.org

Changes in v2:
- Add TYPEOF_NO_ADDRESS_SPACE() in compiler.h
- x86: improve changelog
- Link to v1: https://lore.kernel.org/r/20260825-unqual-v1-0-7024fb81b4f9@chromium.org
---
 arch/x86/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f4700ad6b5ec..66186a642f26 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -140,7 +140,7 @@ extern void __put_user_8(void);
 	int __ret_pu;							\
 	void __user *__ptr_pu;						\
 	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
-	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
+	TYPEOF_NO_ADDRESS_SPACE(*(ptr)) __x = (x); /* eval x once */	\
 	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
 	__chk_user_ptr(__ptr);						\
 	__ptr_pu = __ptr;						\
@@ -177,7 +177,7 @@ extern void __put_user_8(void);
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
-	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
+	TYPEOF_NO_ADDRESS_SPACE(*(ptr)) __x = (x); /* eval x once */	\
 	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
 	__chk_user_ptr(__ptr);						\
 	switch (size) {							\

---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 20260825-unqual-25d9ee74fd10

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

