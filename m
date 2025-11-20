Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAE35B14B
	for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651562; cv=none; b=LnNEOL5celZ5moGD9mB0upwTu1G48gmNQ0xncuWdWpv6Vb20Qe7ZLVt8vgVBm5CSkSDl7sJNp/1W4p0gnB1EgLsSwNtmQMdcIvhBiHIx4rPrudur/JcILGoazE1xJbRJtN55a35L5/IIhG0rhjO3582iHPWXzBJLAJnhJb3PAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651562; c=relaxed/simple;
	bh=JsRVhDxMTESFNC0k9j5iAV1EVftZ5NwIrNhmhZrLX5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ew2Uc7a2drt6ZcvLXvYsQ25nTC1+TOCpUtzV2TJRfKCyfpOivzRSWwqCiQsppCJKFD/LRo99t8xqRpPLZpSixyAIA+DVRRty5zQXWnv7UOP2c6rC5BHYt8nd1PxId/y4UJnNJbId0TpKsAvQ+5AIkwho/4lzh3igky218omjlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVfukvmr; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVfukvmr"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso1058373f8f.3
        for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651543; x=1764256343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhzmKujL7bNVWf02jAjaSOrp3urplpV1YekSTYKrBiM=;
        b=fVfukvmrtlZIh4E5wGUGJEuC5vPOv7dihBhfAbI5aQz5c3kDA3luttWFvQ20epfX4R
         sy1L2NGUzJJ9E4CLFA8moK9/63iPtg72D+v2+iSQVM/gO83xXzliQ9xRKx1EXiWf83Vb
         dFWHRV8xlFwnw3Mj0HYNrmAszRt2pUknH5pk/eVLqXcfCzNw2hgSNrwt+M8k0STZ98P7
         4bpchl8Skgut/02et0r3gtweQK6mORjU+BY7YP3iNqtVpEX81Kjxl7cUgHQZo6mA5ClF
         r9rN2f7Hz5iV/DC1MqYQAj/CMg6VrtkKXpVCxbioheE0Y69YMnLLBew1kCErdSAuFMSz
         F3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651543; x=1764256343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhzmKujL7bNVWf02jAjaSOrp3urplpV1YekSTYKrBiM=;
        b=HbtbSPytWtOhubSotrMzvDxb6AFD+5GUqTqjspma60ffsz7BmODnqYgEK6EYy3XUlz
         y9jQbIzUbpTGQEJLI3XRrJvFPZI6bZWTusLYTdhrwO1cU+QGOCtDXGupXwZRePBVmqyV
         CNAYov5wjfg8ZTgVicEoRzuL5HWUl4sVjfk2Mr6N1IYLmSpzikzSPFQj+ipIPvDAI7M7
         xXGFZKT4QTXUdZLhwFCniSHZ63nQ4BG+cAngEGxBQy6+vXbGC4NoBGH2H4USJXf54uVl
         mI8VondBo6l5bHt0hfDpGlWtwfveYWYFJ77Do0iediUhbv+okLsFM3OdljZfxr1bN1oh
         BHkg==
X-Forwarded-Encrypted: i=1; AJvYcCVHY6aEYsF/m0vZ+MFNqaaez3GN9LpGaIT1KOcM0nsd2pptchHm9E5fbcJHkYEgThMjERAvXeN4jbvQD5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROCF5d7bMCivdSs4LjtmHWZYTydZzkeJ+Gy8qlf0Tu2fNOnB/
	2yrNaiIVw5Ydhnse+QOxxZl4aoAvscDBczbCZ3ztaEa4/rvl6HHM796CD+K5QAVpOUvqMlP++Xi
	UAA==
X-Google-Smtp-Source: AGHT+IFL0EI2FVZUMy6GZbaXFPeZWxMdszC7G+QJPxJYJ5Tt54juOMlly5lP2pxtgOuHE3Qi1fA/jEG3bQ==
X-Received: from wrs17.prod.google.com ([2002:a05:6000:651:b0:42b:328d:1994])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2287:b0:42b:3bd2:b2f8
 with SMTP id ffacd0b85a97d-42cb9a603f4mr3376737f8f.46.1763651542984; Thu, 20
 Nov 2025 07:12:22 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:37 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-13-elver@google.com>
Subject: [PATCH v4 12/35] bit_spinlock: Include missing <asm/processor.h>
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

Including <linux/bit_spinlock.h> into an empty TU will result in the
compiler complaining:

./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_relax'; <...>
   34 |                         cpu_relax();
      |                         ^
1 error generated.

Include <asm/processor.h> to allow including bit_spinlock.h where
<asm/processor.h> is not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/bit_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index c0989b5b0407..59e345f74b0e 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
+#include <asm/processor.h>  /* for cpu_relax() */
+
 /*
  *  bit-based spin_lock()
  *
-- 
2.52.0.rc1.455.g30608eb744-goog

