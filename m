Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BF314D3D
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204388; cv=none; b=hZ+VOFbwx7LUZktZamwmUVgCtvwQCATQzkHu5kOxZ/HOxDyzX6rkBVHk7o7vdpSencFjWcmRZBTkjtR5DEXcjaXzq8XhljAgzU0PLpveKoTR1Dm4STf53UfG9YH5a27kZQz2hy4hl9mWCa9Bq7qaJGmoSXXmf4sawZebOmYYVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204388; c=relaxed/simple;
	bh=DOVYYkUooifd4WMC9FlK4YiWuUY4p8vtxZ7kRIKV6k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gos7EcNH2zHnexfO31Yh3Qciz1yNgaIq3VWrHsbkVkkeqYIq7ESq0GdYxzS9pr+7TBZWwQvXaExyqv1tlPuVxY/HzgbZV+y86FLwqauSMtq0x25gdZ1heIy/H2N/QpfAeeDr6MgjDg8c1q5aSlysOUx1qNyVF55+AbPLnDu9s3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5dG77vF; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5dG77vF"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3eb72c3e669so654446f8f.3
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204384; x=1758809184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oanwb4AvefPzztLhk08gBpEPn5bxbhzZnwvICntunHw=;
        b=c5dG77vFNyxfvKw3cM6bjsTs6GWnqksB7+kwITSQeVcH0dat7rSp1xTDrWvvwdP76B
         FWjr1gxEyZDzXgBUx/SJB77WQ3ZRcPj3jOlsXDMMfTuQFIrMr86BQOrP4PPSxc1VZiqK
         3zkZjjZszHaIZf3bxF8+/Kz/Fynu92Ko38uWIWuNMFS5J3og2Yb2rt1OYhmlP1N1RbnA
         XI7xhhPQfZSXPTFg/e3jXdzWXGj0nzfJBpir9TMcxl2hMD71dzszVVQSUUYk6vJ6Qetp
         /A87ltwEISO1INQYwMv9FM9ZsCLd2WOCb+1QeNov9soOS9H9tY51w/dFsx2rsK4OGudy
         yWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204384; x=1758809184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oanwb4AvefPzztLhk08gBpEPn5bxbhzZnwvICntunHw=;
        b=CQF5A3bgoueTM0wjBeRenzq2Uad8X8Er0BWNtabCneMOm7iX1j7c8ZDMbI7/3k6l2j
         6BUC5vXFRqTIQgToqoR19FbBAJ/u6ZuoUw6J3yFH8X8ZPuEdqc7M0/WN1kySEIEqV/y8
         CHsorfq9ncVhI8vma+GCP97pMt7p5p8ndraPwx71y6gY1J3xPeneziA11leIROxDe5dO
         CVvKCZv5P5gTP2ko2lWNhn2BVKqXqSR764iW+69Xtytn6gw5Mb6HcsjcYGjU502EkFqc
         DisCsFCJm1NGq+TQa+OI9Ati/KchGI/8Z/WWWe7cy7lRQ2QC/h41CtEnKF1ZKQgP8pIC
         i/WA==
X-Forwarded-Encrypted: i=1; AJvYcCUxj7WT4Pg+wpatPx86y5vJAQYWtLIv4FH+MTMsRVZgZ7IpqS1D0AW5CtYh/8ouwvRwqpigyQkYAAsg5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIDA36Z0sVfwHi0q+7HyPahtAqJ5oSRa81AwfncvIi0yD4c/U
	zXYDSDYpqsqcXoQT/8An0C2UOuuhdRT29+cSZMmCWOOBaZacXwuCJl7ZlcIQSMPzgxs7QCFp/uM
	8Ow==
X-Google-Smtp-Source: AGHT+IFkViOrkTd7Qf740HpWB1Y+zHZAT/ov2XdutlPI/XGCPUkCb5+91SEAW6LMPzEdlyQcI8JNeQaNOQ==
X-Received: from wrbcc13.prod.google.com ([2002:a5d:5c0d:0:b0:3ec:df7a:666])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:438a:b0:3ec:db18:aa37
 with SMTP id ffacd0b85a97d-3ecdfa4b7camr5826204f8f.60.1758204383884; Thu, 18
 Sep 2025 07:06:23 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:32 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-22-elver@google.com>
Subject: [PATCH v3 21/35] debugfs: Make debugfs_cancellation a capability struct
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

When compiling include/linux/debugfs.h with CAPABILITY_ANALYSIS enabled,
we can see this error:

./include/linux/debugfs.h:239:17: error: use of undeclared identifier 'cancellation'
  239 | void __acquires(cancellation)

Move the __acquires(..) attribute after the declaration, so that the
compiler can see the cancellation function argument, as well as making
struct debugfs_cancellation a real capability to benefit from Clang's
capability analysis.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/debugfs.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 7cecda29447e..4ee838cf4678 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -239,18 +239,16 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
  * @cancel: callback to call
  * @cancel_data: extra data for the callback to call
  */
-struct debugfs_cancellation {
+struct_with_capability(debugfs_cancellation) {
 	struct list_head list;
 	void (*cancel)(struct dentry *, void *);
 	void *cancel_data;
 };
 
-void __acquires(cancellation)
-debugfs_enter_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
-void __releases(cancellation)
-debugfs_leave_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __acquires(cancellation);
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __releases(cancellation);
 
 #else
 
-- 
2.51.0.384.g4c02a37b29-goog

