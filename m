Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12264746C0
	for <linux-sparse@vger.kernel.org>; Mon, 14 Sep 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394021; cv=none; b=RqgW7lxiM7F/JlvBvc48GqJcM+WoDxJPE4E9D3jM0iq0tbBwRgprXFEhfJNZUcMz/QhSI3Yz+Z+BxGz2nQJXa4uU20WpZ9mfUPXRk5BTSv4BBIWj/gQcXgKO6o3c/ZdSGfx0/sg8EC8cPBOCPPrCBBqsBx2FCQ/JQ3w5dFt8tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394021; c=relaxed/simple;
	bh=64NapLqxHH6tJSEV83TdJWZtANu5nmqRrk1E1ae8QJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPUdQi5/czcfdcO7zJ2pW1QxNk5UMKzOZj2gyR2zF5Y9Q1moL0Qvgdepe0QL6HC9rQR5Wvw54Ofw37KebMjHYM6Db6AhAIBTgMhNhnbYbLU/yRdtQ1y6oJv0SeTibfVEOh/driwl8qveekBeAYg2mq1zpvcweePR0kz5co0thT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jsLNzZwb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsLNzZwb"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so27178901fa.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Sep 2026 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789394016; x=1789998816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tS09zB4gsK6IH3J6tb9FICxkiH+S9C9kJxAP8cTa3+U=;
        b=jsLNzZwbV1cnyavFdXs/JmbpvPHoVN/XRVbDz39qeT/DJMVvWOI4P1xOsXIWCWeK22
         q0CHVB30PvzPuNIonSd/WDbms0SZfrmhzsO1tON8PT+KvXBNfO5fkKUc9yVj0kYADRrZ
         6cJ7kp4hUkXZKo/CYREJWgh63E0ebbeNzOK2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394016; x=1789998816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tS09zB4gsK6IH3J6tb9FICxkiH+S9C9kJxAP8cTa3+U=;
        b=mT0obfZjVm+8pmGxIwSJrwUSJoVl5W4CjK1eq+xkowNJMf8Klx5f4JAVe8bFaLNk/t
         6YiZhv2ymoTSsltvAxWm6uBHqdyDFdqZbniUYyns3El5XR8L6V1DgjUX0k12kWMUBkRJ
         zf7Ny+n2+razhhTHxthaVo/ppmPQz47ZcyHUpVEes7AL5R/VArzNOPP5nYfoYzAAN6Fu
         6jbCK/lueBcUM41kgWWiTjyIP5sdf+9ldriWWy1OuLUj/yo6vDLTUTCBPTWuUev0WFfG
         pFRifbPkoGlXiulwSaxLIhdIHF8vqKVRrDmH12Xmk7S5yzBy1lNlSLSi6G/gxpBDH8YQ
         dWNg==
X-Forwarded-Encrypted: i=1; AKwUvBwYz7ZtbKcInMEcq3qlpK6EZpQuoVQHlTWarahybQThJQCgPR1Emraq1LYRBwfIXkvwUPRnR5KJ2wWFXRU=@vger.kernel.org
X-Gm-Message-State: AFuF++k8ERD9ISLxCYVtPATMy4j3OhnghAJ7LVtnjX3lpe4m4shAmDnX
	XR1XII6iDItQVf/s+NCnSCWaimljMlOor6mNTcRrPE+9YVnJw4fVGiVp8jvhq0KCjA==
X-Gm-Gg: AYBFou3uD0oV31/ZfJtxdqy6kRBYW1dm2I78obswyFFOsB5oHcwWdXihUgIOfC01XKn
	gjUGkcKOUbAkq0LecuO6J4SCKinhfzverHQH1WtiO36tfqTOzVORoTEospzg17d9XhHH2ZizLkh
	yyoJh84fI3T7EDGjMr5nsV8YwV8bt+DmhiwIdL0KqBoFGMkvoZIM7AD1yv3x8OO/Jw5nC6WjD62
	SYAB+XCdUbUpCFqK6SkJCxWGwgVP1vh7+mgd00/TISpgydI07n2bRvjZFi2BHtx8l6bEAInimdw
	G8cYRTsIL7I4NkWMcKF6k6/n9YjL2WE7ge9HdMZLxSYd5qNIHeMdQUpcY0jNBKNYOi90MbOEyGg
	hJteii2bFsC+3jGgXDzu2rJibmemQt2vx3796JpQEOIz6/AIt17HhdiPgJoMBFHRzd4YCyPifJA
	73KtLfLdi6qAJZgibPnym3nSwvQNc1ESBUZrLSLuEM+BNljO9V/YXzn+hdpxnCzaw8IFtVpfI79
	Zpuig3LQ5LsiqnFFzEWMAsipEyhmS1hkRuZ9HVk8RRr9jGO3Q==
X-Received: by 2002:a05:651c:146f:b0:3a3:61ec:43bc with SMTP id 38308e7fff4ca-3a5be1ea6a3mr8393601fa.13.1789394016399;
        Mon, 14 Sep 2026 06:53:36 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3304b38sm29433921fa.13.2026.09.14.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:53:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Sep 2026 13:53:32 +0000
Subject: [PATCH v2 2/2] x86/uaccess: Drop the address space qualifier from
 put_user()
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-unqual-v2-2-60a1407a0cd4@chromium.org>
References: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
In-Reply-To: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Li <sparse@chrisli.org>, Dan Carpenter <error27@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, rcu@vger.kernel.org, 
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

Instead of __typeof__() use TYPEOF_UNQUAL(). It maps to
__typeof_unqual__() in recent compilers, so the address space annotation
is gone.

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20260825-unqual-v1-2-7024fb81b4f9@chromium.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/x86/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..4e576c0b9131 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -172,7 +172,7 @@ extern void __put_user_nocheck_8(void);
 	int __ret_pu;							\
 	void __user *__ptr_pu;						\
 	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
-	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
+	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
 	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
 	__chk_user_ptr(__ptr);						\
 	__ptr_pu = __ptr;						\
@@ -231,7 +231,7 @@ extern void __put_user_nocheck_8(void);
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
-	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
+	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
 	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
 	__chk_user_ptr(__ptr);						\
 	switch (size) {							\

-- 
2.55.0.1007.g17ff1f9808-goog

