Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C52BDC28
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171531; cv=none; b=s5RfU4MbzGePjNCPdHtIs50DUj6JTdBmlw3Jc17lzbO/MBK+8h49+U99OVJ1ekN3cKDGgpIDoh8dMXf5ilBk4FS8UDRLmFsRNeYZ0BtWSV/4wgrpefpWphPHcr9bDwiFguE7Wd1WEJHknV0gS8I7gUBg0MLlpC35pdWSj2eMJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171531; c=relaxed/simple;
	bh=UocQTd03vlm/TCD4q+onIixekG5jfPJUbAZfFLkbKEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBqGl1mOtW6D0VZxwiemofJLl7aSv+qyiaNeXKQODnLIbA5NwK4/Z6aEDZ8GuebCERqVIq2XYUHZwk+MndOReQQ2mDCaBNTlVISpidvUQH2cz0dTiUi5/w/G1EBBqSwLP411Rvo1pw9cH4SnXIdXy8vHJMUmwN0WTB8308QwgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2jSe4bw; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2jSe4bw"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so21152865e9.2
        for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766171528; x=1766776328; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBMt69sCffmrONEUk9HcTp6E3Zeeun0qAoojziALA+o=;
        b=Z2jSe4bwiWOMMxyuiAMa/WODkoI+++yxyG0pHlNpJtjzpcwsHk7n9IoxSgVQIuw5Rf
         MZKh24pZ3HmDpmfLX9LWU0MdMyZLf8fu6wmLqIYpxV1nPcqWYiATJCH5fOd9bJzi27by
         JITMlFumAr4Hwq2YDz3SUsqaVhEN1ok46Ub/wdgX3CasWupArUGrRw6xbolfsYCyJTKD
         HB7hpoBqZJxw8QplBMsAvL/1K8jT3VJ8TtggPbTO7Q4qxg5uz3SaVNLfoTUQsTxobD+4
         74s6d88JU+S5/mfkzVMtzhwrXD1SGTN+eSJRHl0eCh2M/+GSI8KoypkQ5usFAaxhnkId
         Rpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766171528; x=1766776328;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBMt69sCffmrONEUk9HcTp6E3Zeeun0qAoojziALA+o=;
        b=eDmCS1Ljsfz3ihaYmHg34Wii3t1jxCRrUnbQ9+r0kyQjeTZtRHW77ws5bfVY+fMN6W
         bjO+gB5d1aO8uKnO/NhAW0dkz4aneq1PfqmLwgxiW3hqVDt7kARSvk2AOdD8qltmBhHY
         T06XvjYR2km7vQekNOXop1XHU4V+bLN2jGcksra4EGTgOAwMbTO20xmdkNJW8kyIeqql
         iW7q8x1ol/924PLWVFfPpJPw+03ZaFMBVCHofUcMVleYhyLW9IRXF3LpG0k9Ax5we9oW
         ncaigFyIP3DrywmJGxt3dEZ4bGCjpdej6C8mf4XV06o+Vm/aGk41j16xJ1Gs7j0zJ4a8
         yW3w==
X-Forwarded-Encrypted: i=1; AJvYcCVv1I1zmmGH5JnLpsc3/D69T/REyjGOhiDINnGHyxL2JeUQvSg/Xwk3binX6xsWZKkGumD4+1RYchMyyEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWq3zCvXHqoSz84GDij4IBf0s7C1E6SIDjuUMlVsvPDNO6xzcU
	ClmXiEwDNGK3lXuOK9H5/vdT8jxS03N7x4wywOO/yV7mvL2M50LKOgw7gmqAWDjQJw==
X-Gm-Gg: AY/fxX6gdO1T5YIwhM1IxA1AHwxrLSJNKtp1V0YqUaTbDddvmGzkeAhBcWuQd1fCgIt
	i8Ww/OmhskZaDsHRtS3iSIVQzVbH6ullRRgt8SD6KwJS8Nq/ycACabbyxuL9ObdCzqkgQSuUUmt
	REnt6sZ3Y3qV7//khqGqTAaC8sxoZnh2aQ25qH3bscVhSGKPx0/F+WwBzXnsu9TSfhrukjCqoxJ
	uj/itpF6e8iZAmMvAIkaRokPSuhoL39LBMhHJazskbkyX26NhortIfcbkUxk3478sfyPqEwmShn
	GIpgb5G/HnKKhqUrCscxRYdMknG2yCntCEChRoN035QPmqmY4TKZkB9ygEooO9+O9pocq3DX5oF
	T10TNtq80N/ThAzlDbNzMfL6TrG7AzfGkk9LqFtZ4bF2RzrmSF8j162tSU6AzA2YSQ4q/Q2oDPv
	qDKNeS2QPp3rAxep07Fsf1UNa1gwyFQ803LyW4b2lf+BXkb9QonuXJmPl0G0Y=
X-Google-Smtp-Source: AGHT+IH9HIskBRHlFIQr/Osyy9yIUKVMwuoBBZxTrb8MCYHFqdOsUtEusA5GjiNqRLtoiyidJxfWVw==
X-Received: by 2002:a05:600c:3506:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47d1953b774mr34567195e9.2.1766171527309;
        Fri, 19 Dec 2025 11:12:07 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:f7c5:1bb4:fb06:fd5e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2bdfsm6628486f8f.32.2025.12.19.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 11:12:06 -0800 (PST)
Date: Fri, 19 Dec 2025 20:11:59 +0100
From: Marco Elver <elver@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, kasan-dev@googlegroups.com,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v5 02/36] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
Message-ID: <aUWjfxQ1fIZdxd-C@elver.google.com>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-3-elver@google.com>
 <97e832b7-04a9-49cb-973a-bf9870c21c2f@acm.org>
 <CANpmjNM=4baTiSWGOiSWLfQV2YqMt6qkdV__uj+QtD4zAY8Weg@mail.gmail.com>
 <2f0c27eb-eca5-4a7f-8035-71c6b0c84e30@acm.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f0c27eb-eca5-4a7f-8035-71c6b0c84e30@acm.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Fri, Dec 19, 2025 at 11:04AM -0800, 'Bart Van Assche' via kasan-dev wrote:
> On 12/19/25 10:59 AM, Marco Elver wrote:
> > On Fri, 19 Dec 2025 at 19:39, 'Bart Van Assche' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > > I'm concerned that the context_lock_struct() macro will make code harder
> > > to read. Anyone who encounters the context_lock_struct() macro will have
> > > to look up its definition to learn what it does. I propose to split this
> > > macro into two macros:
> > > * One macro that expands into "__ctx_lock_type(name)".
> > > * A second macro that expands into the rest of the above macro.
> > > 
> > > In other words, instead of having to write
> > > context_lock_struct(struct_name, { ... }); developers will have to write
> > > 
> > > struct context_lock_type struct_name {
> > >       ...;
> > > };
> > > context_struct_helper_functions(struct_name);
> > 
> > This doesn't necessarily help with not having to look up its
> > definition to learn what it does.
> > 
> > If this is the common pattern, it will blindly be repeated, and this
> > adds 1 more line and makes this a bit more verbose. Maybe the helper
> > functions aren't always needed, but I also think that context lock
> > types should remain relatively few.  For all synchronization
> > primitives that were enabled in this series, the helpers are required.
> > 
> > The current usage is simply:
> > 
> > context_lock_struct(name) {
> >     ... struct goes here ...
> > };  // note no awkward ) brace
> > 
> > I don't know which way the current kernel style is leaning towards,
> > but if we take <linux/cleanup.h> as an example, a simple programming
> > model / API is actually preferred.
> Many kernel developers are used to look up the definition of a data
> structure either by using ctags, etags or a similar tool or by using
> grep and a pattern like "${struct_name} {\$". Breaking the tools kernel
> developer use today to look up data structure definitions might cause
> considerable frustration and hence shouldn't be done lightly.

Fair point. In fact, it's as simple as e.g. (just tested with mutex) as
this:

diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
index 80975935ec48..63ab9e65bb48 100644
--- a/include/linux/mutex_types.h
+++ b/include/linux/mutex_types.h
@@ -38,7 +38,8 @@
  * - detects multi-task circular deadlocks and prints out all affected
  *   locks and tasks (and only those tasks)
  */
-context_lock_struct(mutex) {
+context_lock_struct(mutex);
+struct mutex {
 	atomic_long_t		owner;
 	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
@@ -59,7 +60,8 @@ context_lock_struct(mutex) {
  */
 #include <linux/rtmutex.h>
 
-context_lock_struct(mutex) {
+context_lock_struct(mutex);
+struct mutex {
 	struct rt_mutex_base	rtmutex;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;

So the existing macro does support both use-cases as-is. I suppose we
could force the above use pattern.

The reason it works, is because it forward-declares the struct anyway to
define the helper functions.
