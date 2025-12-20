Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC494281532
	for <linux-sparse@vger.kernel.org>; Sat, 20 Dec 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235172; cv=none; b=OuKZ2Yc7nK4qHIPYfpBfaqhhP8cyARMeHnZFIdLma+60VjlaM4o3/10dexsJ6TSFgYBLskUG4kZDBIaqHTDY/DLthkaDnZEAgtWiXfFNWLp3SOTC5z5BztV+Cy2c54vuhUHa8AbVqv+osJfcFcYrJSOIncJQhJIODsxugRg5hQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235172; c=relaxed/simple;
	bh=mfOXg447RAZ1jn16CEUFd8WZttm8IVc21yuyK4Wgy4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPjdSBYpHkt8Kw3+bsnFR/KEiZwVOed1mJ8Thwa+q7gn1qEDarEGhroYHd1QdB+baH/YQFrqfNHr7+VUwnGhfjp3pDYfXoUkwRAG+tw4kvonBBtBBY+puMpBLn1Smg67aoAJO2XKqIJ/fFWS9qm+KVPFS54igpBjT7K+eO/mg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPzgDfq9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPzgDfq9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so22890415ad.3
        for <linux-sparse@vger.kernel.org>; Sat, 20 Dec 2025 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766235170; x=1766839970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbJUZ0xTndCf3VdowDat4Wdfn4Fu9I8D0dKSNYqhcFE=;
        b=bPzgDfq9fMDn8+Wn6skuS1G73sQ7mE/xuR3bGKFzGvscKj8iRm0krkBQC4xdEiAPxV
         ZgEPCvrPT2Arb/NySSwQ8QY7P/pNlxxsZ39TCWDGVlX0JAfv2rMtl7PXOfFmE3N3wUGi
         SD+OdfZIgvaxPIXDF2CL862Vj6b4GgMJZW5jW5BYu5yxJMW1ehcAPXSv73kkyTPQolwA
         XjvfeSm9iU/cCN1Bqf04WXgqf6kZtWVfMNLWto5sjqhp1BB/ksyKF7nwz/oaBh80+Eqg
         suwEhsZ3pfiPNoO8lC3KPrBhJqFsIdRNnSdloBwNQtZSLmZJuoWdwljVoUg/gdhozOh1
         WhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766235170; x=1766839970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbJUZ0xTndCf3VdowDat4Wdfn4Fu9I8D0dKSNYqhcFE=;
        b=mnrqaQHedEDT2+nFJA7czBwebrH8OI0NVTCFy/gRDMQH43WOXX9XXXhh9xqHIVes+g
         oPgvWQmAHRhVHBxBjHwCrUQUqlAAKef7GK/2uctOCKfIbrHNuNJpOEWpm9uc7DKuzuNo
         5VS5At0/P1er+eql9cYvONAqCEfsPexpPwXYjJLpTeHgBmezg2wapQTlhLNhWkuUntAL
         q3YC9168qcxHkxPTsjoIM1d8dZFx/acRejIwjWLbfYZRr4zzSmYdV05PnCI1tUeYKcSa
         VUTtFmlB/fjHK46oXvLN+n4SrmLFAS39W/vk3wuL7uALZh1H8eH0iozIs++6+G98S/v0
         84+A==
X-Forwarded-Encrypted: i=1; AJvYcCWjDGLuEttxm4iIdj+y48poE/CuNL1pyTXsRxKVW88BNrwAVcKxnxaP8B7dx6wl+nzGjngEGl+qP2QYr3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJqD52CtvheYSZy3CWEe3JFOKcKCQGqcOj8JZNe4OgfZpLQm3
	RTOeB7ts8c6cIO/OEJFXLR4TEmAlU7sUCI1Z9dhMqspljKCpDCG7He43MpMMhASbBu1lOk6Ra3B
	YGYRHtW2sL43cGxgPdOt/R8v9vtuic2OqfG+pIR5Z
X-Gm-Gg: AY/fxX56KrsjiOjl4i/jQaCQo7G+wHLLdbsL7iCJHE8UyleqyqCSgCY1B50jupMewzB
	pvKbUM7g1KGwKz4koymP5Sb+XY7DXYlAegbWDFngwflry0H82RaUC3zkpo0tBRAttpBi193X0le
	PT6BLVEze+cTYxlGrvGjpCr3XhK8GZNKAmbniAnl68iBwId4oSiDeuPe/FUrHZEm8WVzlyYEh6l
	k8V8m7Tw+7xJBQiYWxDFx6sqIrnQOi4EYqrJR3Qc1M+VWtryd5WNDdqllsIaqygcFvOfFBbxXiH
	7/QnptdyggakHvT0Cuj6bSc1h3E=
X-Google-Smtp-Source: AGHT+IETmgOAcDHbF6MqcLCKTf5epOZwA9tGllY35Ia+ZmQjsZsBscMmnIOEXdoPmuZFimi3nJyivgIHK6DMRk5k25A=
X-Received: by 2002:a05:7022:6722:b0:119:e569:f626 with SMTP id
 a92af1059eb24-121722e0444mr6670285c88.31.1766235169708; Sat, 20 Dec 2025
 04:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-18-elver@google.com>
 <81d2defc-8980-4022-a464-3d285aff199c@acm.org>
In-Reply-To: <81d2defc-8980-4022-a464-3d285aff199c@acm.org>
From: Marco Elver <elver@google.com>
Date: Sat, 20 Dec 2025 13:52:13 +0100
X-Gm-Features: AQt7F2oG2tk1HNWJ4txFgkKVTgQOAoxLExF81nhreitjIuVCBm-zQmVADhDjpfw
Message-ID: <CANpmjNMAGYeFK-jYafSihmA+T7wi3zC8Sb4fJ+ZjzDK5jGuMvQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/36] locking/rwsem: Support Clang's context analysis
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

On Fri, 19 Dec 2025 at 21:55, 'Bart Van Assche' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On 12/19/25 7:40 AM, Marco Elver wrote:
> >   static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> > +     __assumes_ctx_lock(sem)
> >   {
> >       WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
> >   }
> >
> >   static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> > +     __assumes_ctx_lock(sem)
> >   {
> >       WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
> >   }
> > @@ -119,6 +121,7 @@ do {                                                              \
> >       static struct lock_class_key __key;                     \
> >                                                               \
> >       __init_rwsem((sem), #sem, &__key);                      \
> > +     __assume_ctx_lock(sem);                                 \
> >   } while (0)
>
> Just like as for lockdep.h, I think that the above annotations should be
> changed into __must_hold().

My point is the same: we use it to delegate to dynamic analysis where
we reach the limits of static analysis, to avoid false positives [1].
Code should apply __must_hold() or __guarded_by() to called or
protected variables respectively, which is both cleaner and the
idiomatic way to use all this.

[1] https://lore.kernel.org/all/CANpmjNPp6Gkz3rdaD0V7EkPrm60sA5tPpw+m8Xg3u8MTXuc2mg@mail.gmail.com/
