Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCB2236F0
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204344; cv=none; b=FHLaHmUMtmYlW5GIlToWS/iM2CuLG07uchWaAhCHxG1E2AIFkSu68emDlah7mWWOx0JhN6W0co9BXOZh0QChM3fZvPpC79sfVPoQSrJWc87hxoMtvj0O0+UVOj32Ey2YWJhKnRifnfImjoHjd7znZBk2ywgGpSQzMypofJlMsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204344; c=relaxed/simple;
	bh=7I7deiu7A0VftYnHpa9uRS6VLyQWs+z9QnxKOZtlYJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxAENqm/wz3ilrk90Csy7WXDOCZixFLLkam5R8gmpDmu0fi5qd5xzM8ndaSl4Oi4JXYZY84IC9EhG6y8FjvpSQ6v7rjBhtW6EHp8BiF25uzYtMwwF7yXfgnGpkUi3Fqe6Op72VshnbX5dZmz88h56J/3mdxs3HQ/kZbl5PgVSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3M/nceBE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3M/nceBE"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45f2b9b99f0so6238835e9.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204340; x=1758809140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkIaNFjZ8EE9t4JDBPeqGMTocvjIYd1EXgJAVVa8hvk=;
        b=3M/nceBEa87KFh1n+WL3qEalRkVQ13m7oH6Ia8aWdIx0QltlUsbllSOcftCJx/30zR
         nh7Zy0820Asj/gAgo0gZGaaPkT7vPQtIZlfVLVIFdwKb6XOqkVto8v/uLZuAoUwyNKVt
         5+iovOQm+3Oa0iJoDfwUXrKBxja/asH2rnMUN2B24qT+FcYe0xP7grgQF6eGcFuyWRbY
         MiSRxlVmjZGituH8Mld/t+fqvAgKn0wx0QOUnl14o09qyUiPFfC6DJrHUB+fZCZq9Nq+
         m7EZQkPsOWZtuOQSt5jpzQz5l9qCJ6r/RBH6hT7FbeoFyjQvvsYWQWziS4R0mvRCuJQz
         G/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204340; x=1758809140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkIaNFjZ8EE9t4JDBPeqGMTocvjIYd1EXgJAVVa8hvk=;
        b=GlF3tnni7tz6Glk99vMQSK91YCOL+jCi6VHIKGVE6TbGn1gizs04tKluvQmUPGYC7k
         Az495mSC0p3b+PWf9u1A+KNwgls6kl7uVcxZGCC9Ouu2mW+jU2AJqcW+iwQRfcngUEkQ
         MsStiZywpgBaGWluQ/NjQs/pGGeQkMvNgQxhOjNTEAaSAVPciB6i8w/0HQoB5F6vLyVL
         po5tzcbqmzxUR5u89qN/mUsjeBLOFdui5ul115xSucZOZS7ZsL3w7n6MSjwJj977MGoL
         KYu513ChtV5ZA25glSXy/OiCqzjNFJ/ZR/cqtXBwLTd2asFFjnvKwIrqFdF9sK3fE/rO
         0WWA==
X-Forwarded-Encrypted: i=1; AJvYcCUhqU5hiUcfv+uA+TK2d9kBTetd/hbGl4sVt9MwmpKN3WI5ZSNV+VwtUoepusNzswaFUNyHcPqSg+SiPvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzjx9kke9FzppMYGkWskVeHhBsuwCDfED2eOAz578t7FkzAgo
	WLV9fsU0lZ3RYVJlF5kBIeKoJkuriB1w2R2zgblWyGM4PF1j7xYhTqGpWHCOpVGx3vbEOajAEee
	kKg==
X-Google-Smtp-Source: AGHT+IHQzPo8Mj0thMXjE5t0fY5CTZzNk1DcpYE8xx/Ej+3pN7Wv3jLT0CrPQrr0ioychSRPw4fXch23mw==
X-Received: from wmqj11.prod.google.com ([2002:a05:600c:190b:b0:45d:db34:5091])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6018:b0:456:942:b162
 with SMTP id 5b1f17b1804b1-4650503b3e2mr26525245e9.11.1758204339995; Thu, 18
 Sep 2025 07:05:39 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:16 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-6-elver@google.com>
Subject: [PATCH v3 05/35] checkpatch: Warn about capability_unsafe() without comment
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Warn about applications of capability_unsafe() without a comment, to
encourage documenting the reasoning behind why it was deemed safe.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..532075e67a96 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6717,6 +6717,14 @@ sub process {
 			}
 		}
 
+# check for capability_unsafe without a comment.
+		if ($line =~ /\bcapability_unsafe\b/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				WARN("CAPABILITY_UNSAFE",
+				     "capability_unsafe without comment\n" . $herecurr);
+			}
+		}
+
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.51.0.384.g4c02a37b29-goog

