Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969232F7AB5
	for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650973; cv=none; b=nSf3Htafj83CE5GpSdpzLIv3GUmcHA9fqgUtE6Hb3DvMrXwVGBQVUTTBt+nz4ZoAkIQRgn0mLXJB4shYNvchGz70TuJEpFxaF13Q3dVPKpc6yc5t33AS5N9pXm8q11ogTyjmZ+AG68JIqpW7aJSg5bJSgSom3kXd3Hv6KKD+oxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650973; c=relaxed/simple;
	bh=g/pcRuqNqSJ9il1AN9uXiWPsEHGF2sqboQr2ZT1RndI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z01yWI9AR2FRIP97xz0SoAKV4VcsHvMioIztW8OQblY+58a/HHME8meJ51GcvZ0b8Jw6+3L/MjnMF8IJ3NkKInPyV0nj449lHBiR7NoSy3vFWiD4uNDW1zIvWy4+n3dZiYmpi119TQpjS7fvbyhzQlmbmbNCG6XM0k6I3SS+6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2l8HqkQ7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2l8HqkQ7"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47797caba11so4146085e9.3
        for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 07:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763650968; x=1764255768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xm08Oqaiz0C+41w88sCv4Knf0HeT4Y61beURoEgshc=;
        b=2l8HqkQ71zJDzTmEBSxYyjhjsek9KqM6EKRmA2DqPBhmWVaXIxDjonC+1GAO16KA5k
         McapSz6xQJu3X5ntV04jI/XKwWWs80RL7lFA/Wb1Xv5ngMBhkj0fWD6ki/kXIRPNGkZe
         JVkYaLz8SdZdFSBc1i/Oz2yFD1QMvrDLeePKo8LOz/Roqaniow0W3GSknfjBbgVB79H/
         zsYrLGjjuUfiPlpjXkpj3LiH9ORmrj6lt9X94Kyx0xZLs68QrACXUjIJ8v1Y0kdnAy6d
         REcqDh0qHyqYnSViaf2iQA0SgneatjkicvSEi2q2w0BfH/93+1YSu0PMgQbHMLy4Ycjl
         ArwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650968; x=1764255768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xm08Oqaiz0C+41w88sCv4Knf0HeT4Y61beURoEgshc=;
        b=nOE9PHdjWEQPNzYnQrnDHuECk/CWergTANo4sqiXJ76C50SmDow9kHrVbmtG6opP2Q
         Sn11Q1LPIjRxL9cbdiCVKNrJ1p/mmTpEMPRpWAZfVWypyxV94IInAoLZk4Z17yqOOxXM
         OMAMiKdaxFlxXJR807j7UwGz+F16mMRgNnnCPLex1yx+guMkRdjGsajq4sjkAa3f0hzx
         mD/1fJjjp9R+4YwQ0phbe7RGsSYEiamp6BeUPiawM4RbBisysevo6QIOtKTNm8oQ0UHl
         fQzPVzf1vD16gJNRwktX4AeWghoZ+EJ6M84GwFyqTR3NrEhxWmh6Pvh4YaZJUDvW1DGG
         vaMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4dZBRWGLnQhQvFtTE8jN9/fEa77rVw6r6IcKywRfUuEkvoYZLKmpCT6SuvvVi3Lbgf9n5pWkNek2FUgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqb6p4mQ0FMsq7LCr4Jxmbpak6AKpIrcKI/oG2dSxEzpiQVKJB
	YWo3NYipeLcg6bjylIOHsMSZkyFi2giy8Je8cprOonr29b+SrHHyQigm0g0arHoRkWISOr0ITyA
	SaA==
X-Google-Smtp-Source: AGHT+IGUHW8T7PbhGDmbj5YjoSY8aOAhL/hfcFkM7c1fjnxT41/dPSOy7IIJVzHNh1nc5oCgWusA4fLoNQ==
X-Received: from wmbd17.prod.google.com ([2002:a05:600c:58d1:b0:477:76e1:9b4e])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:470a:b0:477:1bb6:17e5
 with SMTP id 5b1f17b1804b1-477b8d8b887mr39140845e9.30.1763650967589; Thu, 20
 Nov 2025 07:02:47 -0800 (PST)
Date: Thu, 20 Nov 2025 15:49:03 +0100
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120145835.3833031-3-elver@google.com>
Subject: [PATCH v4 01/35] compiler_types: Move lock checking attributes to compiler-context-analysis.h
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The conditional definition of lock checking macros and attributes is
about to become more complex. Factor them out into their own header for
better readability, and to make it obvious which features are supported
by which mode (currently only Sparse). This is the first step towards
generalizing towards "context analysis".

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
v4:
* Rename capability -> context analysis.
---
 include/linux/compiler-context-analysis.h | 32 +++++++++++++++++++++++
 include/linux/compiler_types.h            | 18 ++-----------
 2 files changed, 34 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/compiler-context-analysis.h

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
new file mode 100644
index 000000000000..f8af63045281
--- /dev/null
+++ b/include/linux/compiler-context-analysis.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros and attributes for compiler-based static context analysis.
+ */
+
+#ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
+#define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
+
+#ifdef __CHECKER__
+
+/* Sparse context/lock checking support. */
+# define __must_hold(x)		__attribute__((context(x,1,1)))
+# define __acquires(x)		__attribute__((context(x,0,1)))
+# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
+# define __releases(x)		__attribute__((context(x,1,0)))
+# define __acquire(x)		__context__(x,1)
+# define __release(x)		__context__(x,-1)
+# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
+
+#else /* !__CHECKER__ */
+
+# define __must_hold(x)
+# define __acquires(x)
+# define __cond_acquires(x)
+# define __releases(x)
+# define __acquire(x)		(void)0
+# define __release(x)		(void)0
+# define __cond_lock(x, c)	(c)
+
+#endif /* __CHECKER__ */
+
+#endif /* _LINUX_COMPILER_CONTEXT_ANALYSIS_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 0a1b9598940d..7eb8d8db6c28 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -24,6 +24,8 @@
 # define BTF_TYPE_TAG(value) /* nothing */
 #endif
 
+#include <linux/compiler-context-analysis.h>
+
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /* address spaces */
@@ -34,14 +36,6 @@
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
-/* context/locking */
-# define __must_hold(x)	__attribute__((context(x,1,1)))
-# define __acquires(x)	__attribute__((context(x,0,1)))
-# define __cond_acquires(x) __attribute__((context(x,0,-1)))
-# define __releases(x)	__attribute__((context(x,1,0)))
-# define __acquire(x)	__context__(x,1)
-# define __release(x)	__context__(x,-1)
-# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 /* other */
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
@@ -62,14 +56,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-/* context/locking */
-# define __must_hold(x)
-# define __acquires(x)
-# define __cond_acquires(x)
-# define __releases(x)
-# define __acquire(x)	(void)0
-# define __release(x)	(void)0
-# define __cond_lock(x,c) (c)
 /* other */
 # define __force
 # define __nocast
-- 
2.52.0.rc1.455.g30608eb744-goog

