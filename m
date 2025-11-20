Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F195364053
	for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651645; cv=none; b=iYCytb7yHk6xiz8VzzXdXDTlAPW1oLqNCKeVR4Xey5O4J+CngMKv946GsvFPNAnkvKu0zSUvNNUf/BxhMlI/hsJLu/wvayE48vt3f2+YHiHzEUk/3KLGohCThtjN437WPoBTkNPxGtbFGvGyG/PzN3NJ0EOJk3EfSe5InvyCt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651645; c=relaxed/simple;
	bh=JCnKk5smTgE5T0ItBQ90SmrKCWmUzu/R/X44B8ZE77w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=keEze/Odiq3MfTBuOvQDSHZqo3YwPn3whrUObZ5fwN2gAEfbVlkj0GYlyOX57vSTKUZXhiTlAlJ8nGT4VGkj1Au8JWBOB9WfbRXJ9gcMFN0JDWnPCtn4fGo54U0pRye1PVZAr+x6UD7b92fwR+JgeJNNzJ7ijM1z92DDQ2AGdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRE8Kjm0; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRE8Kjm0"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c7b0ae36so658572f8f.0
        for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651604; x=1764256404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0QY5sCjABQs82s4Ju3ZdPJK85+Pyg+eamRrTOstnfs=;
        b=gRE8Kjm0kvEWnd7CL1VSLZiere2y7G5PwxdfKH7gBgU2P/MnepxcHKnQFRPBK8tw6q
         caP9AvS0bzdestKcrXTzhn0XyY1zAz18kNlJ7H8xlZsVack1pc0rWSVc5Zv0gLpJ7Gn0
         CDQROf//bEeLJhCFStvJ+2TamjtNbiE+FWpl5ZYWTuxfOtgn3quywyNx5pIIOgeHnyqf
         TH1R5nrDpNKiq8r+lLnsbKRgJ93ncO++H2oRsWdG+l2oLj9rJB2sGtnozA67S9oc7dbi
         YSTRYR01Atfu2JyT37RKjd4Jp1v6gvQMEv5D04BOAf69OmDOlwr87l/eroueEmtULPw5
         KoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651604; x=1764256404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0QY5sCjABQs82s4Ju3ZdPJK85+Pyg+eamRrTOstnfs=;
        b=KPaCIksFfmxKViqQQJqLO5MN50Z1thUEFc4FtZp6hjbEdTbV4NbnvQEPn/l5e+H0m+
         UDezMKGyGlomi7x3Kr5CxhJOncp0WoqPIu3x4qr8cTkZkn+AtcD3NeAXSlIYDc+E1KYj
         n9x1qx0kXk3JIn7APLLlqW+NMGsrlFWjh3PzTpIjH2YS7X5RSyVn9Jaij3oN8aSJ1+HE
         veNjd5t9m5VOAK8j5sozgYGanSjEWojyd3AA9DMok80iV1y3Fmj1Cx4yS/yuCOsaOEU1
         stLFVZQzJFlt0Fr+khxol1G5BM55Xa/uRJveLrVPR6WOFj7MyOwGqiNSLKfCliH8PlwR
         bJtg==
X-Forwarded-Encrypted: i=1; AJvYcCWGULLVlaXusPXtk3Bma94Vw9UHOzFkNZMD26W5lfSoX1fF1EyLyNRHpKiubmye50mkHeXVqg2bCa6nClc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZNvLiMgcxWVX8kXHC09K8bD/0h2sNIJI1uAwYHnE2mdfMuMz
	1W7ite2GU9OxgCRdDKSquOSrGVhqfvi16S/+0UDMv9U5hjbt4cyJxuy/hLHdkcSSUD5sUCAy4Bh
	EGg==
X-Google-Smtp-Source: AGHT+IEwTiVA/c7ivK4PcZYzQTIU6yfpqSY2nHpvc3eMP1mZxx+HGAMnAzVRYoTvuPwgEuO1vhoD29fTuQ==
X-Received: from wrbfq12.prod.google.com ([2002:a05:6000:2a0c:b0:425:6f4f:8f67])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:adf:f8cc:0:b0:429:b8c7:1848
 with SMTP id ffacd0b85a97d-42cba767dd8mr2702228f8f.19.1763651604278; Thu, 20
 Nov 2025 07:13:24 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:49 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-25-elver@google.com>
Subject: [PATCH v4 24/35] compiler-context-analysis: Introduce header suppressions
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

While we can opt in individual subsystems which add the required
annotations, such subsystems inevitably include headers from other
subsystems which may not yet have the right annotations, which then
result in false positive warnings.

Making compatible by adding annotations across all common headers
currently requires an excessive number of __no_context_analysis
annotations, or carefully analyzing non-trivial cases to add the correct
annotations. While this is desirable long-term, providing an incremental
path causes less churn and headaches for maintainers not yet interested
in dealing with such warnings.

Rather than clutter headers unnecessary and mandate all subsystem
maintainers to keep their headers working with context analysis,
suppress all -Wthread-safety warnings in headers. Explicitly opt in
headers with context-enabled primitives.

With this in place, we can start enabling the analysis on more complex
subsystems in subsequent changes.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.
---
 scripts/Makefile.context-analysis        |  4 +++
 scripts/context-analysis-suppression.txt | 32 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 scripts/context-analysis-suppression.txt

diff --git a/scripts/Makefile.context-analysis b/scripts/Makefile.context-analysis
index 70549f7fae1a..cd3bb49d3f09 100644
--- a/scripts/Makefile.context-analysis
+++ b/scripts/Makefile.context-analysis
@@ -4,4 +4,8 @@ context-analysis-cflags := -DWARN_CONTEXT_ANALYSIS		\
 	-fexperimental-late-parse-attributes -Wthread-safety	\
 	-Wthread-safety-pointer -Wthread-safety-beta
 
+ifndef CONFIG_WARN_CONTEXT_ANALYSIS_ALL
+context-analysis-cflags += --warning-suppression-mappings=$(srctree)/scripts/context-analysis-suppression.txt
+endif
+
 export CFLAGS_CONTEXT_ANALYSIS := $(context-analysis-cflags)
diff --git a/scripts/context-analysis-suppression.txt b/scripts/context-analysis-suppression.txt
new file mode 100644
index 000000000000..df25c3d07a5b
--- /dev/null
+++ b/scripts/context-analysis-suppression.txt
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# The suppressions file should only match common paths such as header files.
+# For individual subsytems use Makefile directive CONTEXT_ANALYSIS := [yn].
+#
+# The suppressions are ignored when CONFIG_WARN_CONTEXT_ANALYSIS_ALL is
+# selected.
+
+[thread-safety]
+src:*arch/*/include/*
+src:*include/acpi/*
+src:*include/asm-generic/*
+src:*include/linux/*
+src:*include/net/*
+
+# Opt-in headers:
+src:*include/linux/bit_spinlock.h=emit
+src:*include/linux/cleanup.h=emit
+src:*include/linux/kref.h=emit
+src:*include/linux/list*.h=emit
+src:*include/linux/local_lock*.h=emit
+src:*include/linux/lockdep.h=emit
+src:*include/linux/mutex*.h=emit
+src:*include/linux/rcupdate.h=emit
+src:*include/linux/refcount.h=emit
+src:*include/linux/rhashtable.h=emit
+src:*include/linux/rwlock*.h=emit
+src:*include/linux/rwsem.h=emit
+src:*include/linux/seqlock*.h=emit
+src:*include/linux/spinlock*.h=emit
+src:*include/linux/srcu*.h=emit
+src:*include/linux/ww_mutex.h=emit
-- 
2.52.0.rc1.455.g30608eb744-goog

