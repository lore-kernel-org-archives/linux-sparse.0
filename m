Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0334A76A
	for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651001; cv=none; b=tRbTf0LGgnD9LR0gXlPgf5aQiLG2hNvhLSUg3MT+6bButRzTry+kR3IE3wfNGeb6vPHBVsZkIFepaSqjTHXZ9jrFk2v9+lG9gWrNdFKJJEZjcQ+RCOtqVBn8WKBQumhKeHevtEkR/QEy5AuPLWuLQwHDCEMsw0M/6Obdww+fhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651001; c=relaxed/simple;
	bh=eBDUdyy/+hf0zNW0yP0X5FX5kRPqZGLn6VJLXyEfqFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cS2XKMr7EBKaaAAUONch5zUntcYaYSb6P7BSzqdSG2iuQYbQGvE4gQkvhyzZIVKKZuDUE/I3QFs4DqkF911AZW86aD4VsmQMAkv4E7j96TQTQgylUgbtQRVJPB51v1nhxFlkja6wATegYenrPd42gW+j8lc0xaLKqUg5JXiZ304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Us7Hk1RS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Us7Hk1RS"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775d110fabso9479855e9.1
        for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763650973; x=1764255773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIkqaT4GZQQ8I2xtRoztfiZr8q25ife+cBqIcslh3gQ=;
        b=Us7Hk1RShmc30uTXgR3INbaySaUA9KT4NJoXfduOpGY5/u6z9cFYcnISLbRnpNGSoQ
         ukqj/IdxlwM3BH1e9bRcTdHml126/z8CSQz0dBIoMvPIndNOXza7ixlzGoLVU/lu65DP
         +S9QkcHuNDE/jFRymy726C7ppg2/z/8OZkLsUdIqwWZW5gredZsdEl6FArODeVX0UKEF
         94mtGLrEpzVssD8/VuNbqjIbAjESlJkNKruoDlQpTOC+eFJFsRyNyOqtynus0EIWaBIo
         ur6w8p+4BW6lMDP10IFNwMtgF0YMNLP+nJjqg0UmdstSiSiIOfrDG2ZHNnmoWgMhWDLK
         Ug+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650973; x=1764255773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIkqaT4GZQQ8I2xtRoztfiZr8q25ife+cBqIcslh3gQ=;
        b=w8cz0TOZvQgJ6u2eih2VtezPuRgUVZUJxiXzTq+BU4L6z1iMcc/7uxzD9kiDkvKAnu
         5ET6NF5POx2GP0l/HJZ4b1r9uSWkZ5XWsgVlVsbZ4IYbO0L0JFp2rbNOtzbt7sEg7YNH
         r0b8fUxmNHHd8XE0YLuqiSE+x6qVNPpez1gTT2qnwjzzBLPa2qZ4AlnsQ8u25VAxdSry
         SORumlufjYBGuqQm9oBQv+MFk0RRCd2kDnZXQuThY3NQpMmw31rNGc40g5CBy7mSZHJG
         pRmqhp9n/mbLCRbNBwGw5HtFLMIrxO77YKUV7yCKlGw/kKcJPV16cEz+2aTutCnJFWYm
         lemA==
X-Forwarded-Encrypted: i=1; AJvYcCXzvH0MWYubN0s52DGHTka//2+YJHHnbkBkzvnhT9w92obuANbUmAk+2e3KjRhqKgZYx3DujSrL+IUjjTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytutF7GG+orJyoMdlnfWO0NDhtKRzUFbhjVxuyB273hADLIO11
	SpJATY5daI9qz0RAqE/LT0QVqX2vg1WUCJkkLAijbltXfCcou4sr8Loh4CQNHlYvtVBPx9Qfs+c
	a4w==
X-Google-Smtp-Source: AGHT+IE7SKgiCw/02hArGI9zujP0xPyrpw65qFKPWhHBeestq9lQVOSID1Bw6HemoDi2xS2ktBePcnke9A==
X-Received: from wmrm14.prod.google.com ([2002:a05:600c:37ce:b0:46e:4c7c:5162])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:470d:b0:477:9cdb:e32e
 with SMTP id 5b1f17b1804b1-477b8a50e80mr28447795e9.9.1763650973180; Thu, 20
 Nov 2025 07:02:53 -0800 (PST)
Date: Thu, 20 Nov 2025 15:49:05 +0100
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120145835.3833031-5-elver@google.com>
Subject: [PATCH v4 03/35] compiler-context-analysis: Add test stub
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

Add a simple test stub where we will add common supported patterns that
should not generate false positive of each new supported context guard.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.
---
 lib/Kconfig.debug           | 14 ++++++++++++++
 lib/Makefile                |  3 +++
 lib/test_context-analysis.c | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 lib/test_context-analysis.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 696e2a148a15..0c499d22407c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2833,6 +2833,20 @@ config LINEAR_RANGES_TEST
 
 	  If unsure, say N.
 
+config CONTEXT_ANALYSIS_TEST
+	bool "Compiler context-analysis warnings test"
+	depends on EXPERT
+	help
+	  This builds the test for compiler-based context analysis. The test
+	  does not add executable code to the kernel, but is meant to test that
+	  common patterns supported by the analysis do not result in false
+	  positive warnings.
+
+	  When adding support for new context guards, it is strongly recommended
+	  to add supported patterns to this test.
+
+	  If unsure, say N.
+
 config CMDLINE_KUNIT_TEST
 	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 1ab2c4be3b66..59ed5f881bcb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -329,4 +329,7 @@ obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
 
+CONTEXT_ANALYSIS_test_context-analysis.o := y
+obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) += test_context-analysis.o
+
 subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
new file mode 100644
index 000000000000..68f075dec0e0
--- /dev/null
+++ b/lib/test_context-analysis.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Compile-only tests for common patterns that should not generate false
+ * positive errors when compiled with Clang's context analysis.
+ */
+
+#include <linux/build_bug.h>
+
+/*
+ * Test that helper macros work as expected.
+ */
+static void __used test_common_helpers(void)
+{
+	BUILD_BUG_ON(context_unsafe(3) != 3); /* plain expression */
+	BUILD_BUG_ON(context_unsafe((void)2; 3) != 3); /* does not swallow semi-colon */
+	BUILD_BUG_ON(context_unsafe((void)2, 3) != 3); /* does not swallow commas */
+	context_unsafe(do { } while (0)); /* works with void statements */
+}
-- 
2.52.0.rc1.455.g30608eb744-goog

