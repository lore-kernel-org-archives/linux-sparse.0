Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103892E92B7
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179036; cv=none; b=Q6ZJ6uiTkAhFnlNf3TcBjFRCHzc/DfzJK6SHVsc0BUFyye6DXca9sMbi+fIDZc63qRtk/xaSP8pJd8xYYD0YCHZuQl02K4YvlBDFwF30IDqdTw28HmmMyqyDSoA+02aeE7IeHKZojtIsaBlY63kfMywJdD6ivhPcFWqEDROXqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179036; c=relaxed/simple;
	bh=LLpGwIKkDXp5hVROlTCKeGGUdVbJKYXE3k+8i7znnho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alaXIFC/D9/oQA9W1STMtCAQebdOMrC/0Oeau26n6uDtnwxMARuh24TzCl9lR7+TfPrym3zdBW+oGcwRELa4+ExsTBWk7Gf6F3p1ZzdeJbRVoaiTZojchgh9EgIJUrCopHY1aNjlXSv+ZXxpbLV2Z+Rq5XOjUYciZ4+MISG4gIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4YzBbXd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4YzBbXd"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1495920b3a.2
        for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766179033; x=1766783833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0rK9w1Snx+IiOS1yyTvDXywJSRfl2rZ6jIui6kPmEaA=;
        b=V4YzBbXdfQIieJZp0VnJGt7qtfMwAH5MdmJkO310lDFFybaA8U60ZNjsxN6/IZSzS7
         0e2qn2Z+fBWU5xP3BM7w5n3pXYSwgSMZDqeKAOy1/Ieq3osXSfFZicc/cjmRAJm5hgcY
         WwxXyWb10AlioOt0yEp97HC5f+8qPDZZMXNQZdAUfOatV07/4XN2TWT3GxvERX+75qNc
         AnV/axgAmieubX9aFeSXXMKKyHDX2aCGdOAGa9IRQH9vgxqylvXBRNf8TPwD1JcBhix3
         XHIDvHxoR4rnPovp7zplMG8xmY8peZwSt4QqRH3RLGBQMGvFLUvz3PNMPSAkSRg+IIpE
         CgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766179033; x=1766783833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rK9w1Snx+IiOS1yyTvDXywJSRfl2rZ6jIui6kPmEaA=;
        b=wpnzcCICGtWRHp1PK9O8lf+1WxZLzMN3oc8VOWZVL/jRbWQ4qvoq0MhBoNhwVmVhZH
         HjmEUNpIJTpulhVrEXCZDxZOMHqJFCEIxK+9m+Py7suCTdxgv//UlpROkpIKKZ7Dlw2p
         DXPrPahV33jeLUrzvB5tRZ5rz8xC/BOZ+PgrFH2X/3J9rbc9GbNwxhVvLKMb/gtqCcia
         BehvKwCrz9+VZnhIoJGlUoD/IU/ZnVF4znO/5HWksGAsIVyyU0hYl9FBdpTT6cJaE7w9
         XETC0HkvB2Zk7Ogih44usi/J4+kCdvfnaRpFAmJoO8+yvhxQCeqXynTvhXvDZ6A7fHT7
         cKqw==
X-Forwarded-Encrypted: i=1; AJvYcCVOhaXDJq+SGRob/dzo1rKMCTLrfp+zNgZ4QF3j8YOkTO+XRkjwJjzJOjdy95Yb1Ho85CFMRn75facMqTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFRztD1B3EVUdkbSmQdeDmZ7qsVZUo41m8EGY1Lk294s02PvM
	enNiyOqUVpXZQwH0GrB1FEfChUv+vJWlBCerqKemfqZlY73og9lpiwxTY2iWI0SEPt2zlXvVe80
	RKJlQdQzHFtPCrOeVk99lTImieShSKCsSnC2Szjsx
X-Gm-Gg: AY/fxX48yIrdZ7oFdZq7yyV0XYOpp1PSSdxPHkGug4TsHUle4CVwiiIQF/DYKHaq7Ki
	ZDnqc1fErWheWBiGR1qe7zM6NqPJHGoVPPVwuaVwPif4Zjn47ENmGxquAvbf9CWXPn5GlBnTVKj
	jSDEJfTAyWHc7D6cTR3YQ4dGX8eu3S1AZ8wUm0y8Ey6EgI2pDDG54aVqdD5Iomg9YtmyFVKyiMn
	DXEYBwgUwfcrvVAAZkbHTNeVZ3OJ93vj7t4d/NyK0JIN3TsJTgGVH4Xt16krFumlQMH2CXH2gIz
	S/fS/LZxef+ChmXNQpw0Yg+Ba20NvBbhV5Htqw==
X-Google-Smtp-Source: AGHT+IHpiDrn99m7x0uN4estdHNLC96nljKxP9R6JbsteT8HXtfNtk+xeDdUnA0onYdjgh5ezU9+Po7MHQlADcjwb9o=
X-Received: by 2002:a05:7022:2586:b0:11d:f037:891c with SMTP id
 a92af1059eb24-12172311ffamr3088830c88.44.1766179032817; Fri, 19 Dec 2025
 13:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-8-elver@google.com>
 <cdde6c60-7f6f-4715-a249-5aab39438b57@acm.org>
In-Reply-To: <cdde6c60-7f6f-4715-a249-5aab39438b57@acm.org>
From: Marco Elver <elver@google.com>
Date: Fri, 19 Dec 2025 22:16:36 +0100
X-Gm-Features: AQt7F2oJirW61gdd7JR_kO6v8Pm8LYFzp_d0WJmR_my_E34K94emt-YaA94Rukg
Message-ID: <CANpmjNPJXVtZgT96PP--eNAkHNOvw1MrYzWt5f2aA0LUeK8iGA@mail.gmail.com>
Subject: Re: [PATCH v5 07/36] lockdep: Annotate lockdep assertions for context analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
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
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 21:54, 'Bart Van Assche' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On 12/19/25 7:39 AM, Marco Elver wrote:
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index dd634103b014..621566345406 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
> >       do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
> >
> >   #define lockdep_assert_held(l)              \
> > -     lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> > +     do { lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD); __assume_ctx_lock(l); } while (0)
> >
> >   #define lockdep_assert_not_held(l)  \
> >       lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
> >
> >   #define lockdep_assert_held_write(l)        \
> > -     lockdep_assert(lockdep_is_held_type(l, 0))
> > +     do { lockdep_assert(lockdep_is_held_type(l, 0)); __assume_ctx_lock(l); } while (0)
> >
> >   #define lockdep_assert_held_read(l) \
> > -     lockdep_assert(lockdep_is_held_type(l, 1))
> > +     do { lockdep_assert(lockdep_is_held_type(l, 1)); __assume_shared_ctx_lock(l); } while (0)
> >
> >   #define lockdep_assert_held_once(l)         \
> >       lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> > @@ -389,10 +389,10 @@ extern int lockdep_is_held(const void *);
> >   #define lockdep_assert(c)                   do { } while (0)
> >   #define lockdep_assert_once(c)                      do { } while (0)
> >
> > -#define lockdep_assert_held(l)                       do { (void)(l); } while (0)
> > +#define lockdep_assert_held(l)                       __assume_ctx_lock(l)
> >   #define lockdep_assert_not_held(l)          do { (void)(l); } while (0)
> > -#define lockdep_assert_held_write(l)         do { (void)(l); } while (0)
> > -#define lockdep_assert_held_read(l)          do { (void)(l); } while (0)
> > +#define lockdep_assert_held_write(l)         __assume_ctx_lock(l)
> > +#define lockdep_assert_held_read(l)          __assume_shared_ctx_lock(l)
> >   #define lockdep_assert_held_once(l)         do { (void)(l); } while (0)
> >   #define lockdep_assert_none_held_once()     do { } while (0)
>
> I think these macros should use __must_hold() instead of __assume...().
> lockdep_assert_held() emits a runtime warning if 'l' is not held. Hence,
> I think that code where lockdep_assert_held() is used should not compile
> if it cannot be verified at compile time that 'l' is held.

That's not the purpose of this - if a function or variable should have
a lock held, we mark them explicitly with __must_hold() or
__guarded_by(), and we don't really need to use lockdep_assert,
because the compiler helped us out. In an ideal world, every function
or variable that requires a lock held is annotated, and we don't need
to ever worry about explicitly checking if a lock is held (but we'll
be far from that for a while).

The purpose is described in the commit message:

> Presence of these annotations causes the analysis to assume the context
> lock is held after calls to the annotated function, and avoid false
> positives with complex control-flow; [...]

It's basically an escape hatch to defer to dynamic analysis where the
limits of the static analysis are reached. This is also the original
purpose of the "assert"/"assume" attributes:
https://clang.llvm.org/docs/ThreadSafetyAnalysis.html#assert-capability-and-assert-shared-capability

Without this escape hatch, and deferral to dynamic analysis, we'd be
stuck in some cases.
