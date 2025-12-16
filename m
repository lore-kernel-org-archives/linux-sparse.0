Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156B33CEB9
	for <linux-sparse@vger.kernel.org>; Tue, 16 Dec 2025 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882875; cv=none; b=VGvuy9r28nh1k9JEquaNAhesvod04PDct3if0mbIDFr25hoJ/R6EG0VTImJ35cSA2zi3Smu7x5uU/BLq4j6AobnC8MoaZl/havIn4NlWU2AR+a02yY18XoQnoJGGuvZLiyZ03j8dQh8zvkBhcfSAkSiLU6di/qtfTDOAtfg+YBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882875; c=relaxed/simple;
	bh=mOm64EM4tgjM1MXcHPhVsoMKtGcavhpQka6kUnBhwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4H4f9PNdJju9bU3zR+Swnf7Ub+vs8D6pn2dXP/HZyoX1/O0U4tbIbsG5zan3afaMojrAcRBgJCSgvSPrpwW3l1kXUbYNIyM34J4Kcj0ChKqh9R+t2c77Yvr9EEfvE50OoOpNc/nSTDrKilncN5Y2AQm6LKivvo/Utmx8JIWTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpviBOjD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpviBOjD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779a637712so29808515e9.1
        for <linux-sparse@vger.kernel.org>; Tue, 16 Dec 2025 03:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765882871; x=1766487671; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fwbXvgWn6Nd0xRDLnbqnTLufRK/0AjdBlMA+CLIc/0=;
        b=ZpviBOjDfIsPR/XLfIKK+E0LIxfXjaTtVEH5dh2NuZoghJq5XN47vDA9xiaqnrcHWW
         EnOS1JV1hbBUhWh0NVgF4UOpTm+TdwMOl6ljVwzHAQp83Nlo4u7SeTLoNigK7QIahXTv
         qoP/kMr/yPJD8DF2mghOx0N0hZKx8GX5ArUQB3NtLwKcrPiW+9Rmjtod5+ooHKGa8ykf
         ZYAt9JIaU4zdF6HShCHWD/ElcjWSd0IvTUE63gEX9ZyUE5xwEBIexAIMeXNVu2/zr3Ib
         hmANx7BFkha7D6hca0s+i4hT+H4E8wwd08e81wNQwvDx+ll1BnNFs5hFyCbDLEZo1KbN
         a8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882871; x=1766487671;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fwbXvgWn6Nd0xRDLnbqnTLufRK/0AjdBlMA+CLIc/0=;
        b=MXmoOCHp+dO4jfGXMuh4RgsnYcJxeuwWp6GE7l+LFE3VnA+z3AxF3t8Hp4axavGf1O
         9a0d1Z1HJyxAMpgmjLvnWDN9FLVANHAkLqe7v36EXiHJqMVuBFqvVnC3nAFBCE56g7EY
         TUed7CUQTi7O2YznRECN2T66WYqOFQNjUJ51NjXhz2FG+TUu1TzjVZvTll1151IG0DHj
         aCxRPY7RA/8QLMYu6Pdr0KzBN02Ytn4/6jEwKxfdN0zHsHQBeL1nf3IAqV5Bsd4pKG3C
         fZO++0EbgVpDSQQTOLuFd6QjZXZlysRMzMvo4svqExBu5dLloD+gH4mkBnDOP4JKBhsh
         LvOA==
X-Forwarded-Encrypted: i=1; AJvYcCU97ztXNq33pjQV6lj4LvBi3jlYtfi6qz6ZlUuYNyJ4vPQ94305Rwb8SE/SjJqLqfAEnKRmppqSbIOQzdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUMgvJy+ZFZ7Hv9OYwH8J/9dmK2ZA8bEMWc9FmtieURZBiVHu
	am1Qa9T5bae+KMjxMnskN91sVdqHW5xiFlGmBOKtTjAdLOHMtU21ROZFUvjRjpjR0g==
X-Gm-Gg: AY/fxX7770I9Xruxe5jTzpwCID+YM1H40bPlMnhL1zh7HntWuR9RG4PqrUv48OXAIPb
	h2pqCx61tLRXFuM+jaV8BNUC3pg8aeYYTfoJW+cUQKI/fzifeJ6q9lR7u21fEoDcjBfBHzKPCUU
	siR8jWpBQoomvM6QN2amPcZ/J/kuDcVmVbkjzDCYvgruS94XZKWEBkIDSw66BM7ifoU2My1DExt
	5+NrUOoV7+F9RBoEi4tWq3XcFbwKcuP7h7YeCEZhSh9Cq4Sw7goB7VqKASVPjKacTSi8DN3/iuW
	Z2lWQY2YeyEkFpW0W5a0+kuRdcyk62hhXIAnOIAmyKP5wCpJofC6blNcVFj6yt3EglHyJcIQfn4
	Q8oIdMOyJW4WdVSwZEP9Elw4by7txXJObDccFwQWeFMpN61LrmbkrAPITI36MgkimoQgNrle9Zs
	3hxRDTZTEPfDmb+0TvE3uJYI2jqKrnTSHeXqTOPC40tVzJc2DkcAjfWVTlEjo=
X-Google-Smtp-Source: AGHT+IHPMwFoz32u9J3kCO+8mIIo+dWtYExr149Lgk7NY5BncmGMC4iCyfwqqX0j0PAhtkij+iZr9A==
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-47bd3d41de0mr37923685e9.11.1765882870450;
        Tue, 16 Dec 2025 03:01:10 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:ea4c:b2a8:24a4:9ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f5f6ede8sm17789236f8f.4.2025.12.16.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:01:09 -0800 (PST)
Date: Tue, 16 Dec 2025 12:01:02 +0100
From: Marco Elver <elver@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
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
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context
 analysis
Message-ID: <aUE77hgJa58waFOy@elver.google.com>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
 <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Mon, Dec 15, 2025 at 04:53PM +0100, Marco Elver wrote:
[..]
> > > So I think as is, we can start. But I really do want the cleanup thing
> > > sorted, even if just with that __release_on_cleanup mashup or so.
> >
> > Working on rebasing this to v6.19-rc1 and saw this new scoped seqlock
> > abstraction. For that one I was able to make it work like I thought we
> > could (below). Some awkwardness is required to make it work in
> > for-loops, which only let you define variables with the same type.
> >
> > For <linux/cleanup.h> it needs some more thought due to extra levels of
> > indirection.
> 
> For cleanup.h, the problem is that to instantiate we use
> "guard(class)(args..)". If it had been designed as "guard(class,
> args...)", i.e. just use __VA_ARGS__ explicitly instead of the
> implicit 'args...', it might have been possible to add a second
> cleanup variable to do the same (with some additional magic to extract
> the first arg if one exists). Unfortunately, the use of the current
> guard()() idiom has become so pervasive that this is a bigger
> refactor. I'm going to leave cleanup.h as-is for now, if we think we
> want to give this a go in the current state.

Alright, this can work, but it's not that ergonomic as I'd hoped (see
below): we can redefine class_<name>_constructor to append another
cleanup variable. With enough documentation, this might be workable.

WDYT?

------ >8 ------


diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2f998bb42c4c..b47a1ba57e8e 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -518,7 +518,10 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
 
 #define DECLARE_LOCK_GUARD_1_ATTRS(_name, _lock, _unlock)		\
 static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T) _lock;\
-static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
+static __always_inline void __class_##_name##_cleanup_ctx(class_##_name##_t **_T) \
+	__no_context_analysis _unlock {}
+#define WITH_LOCK_GUARD_1_ATTRS(_name, _T) class_##_name##_constructor(_T), \
+	*__UNIQUE_ID(cleanup_ctx) __cleanup(__class_##_name##_cleanup_ctx) = (void *)(_T)
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
 __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8ed48d40007b..06c3f947ea49 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -255,9 +255,12 @@ DEFINE_LOCK_GUARD_1(mutex, struct mutex, mutex_lock(_T->lock), mutex_unlock(_T->
 DEFINE_LOCK_GUARD_1_COND(mutex, _try, mutex_trylock(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(mutex, _intr, mutex_lock_interruptible(_T->lock), _RET == 0)
 
-DECLARE_LOCK_GUARD_1_ATTRS(mutex, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(mutex_try, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(mutex,	__acquires(_T), __releases(*(struct mutex **)_T))
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_try,	__acquires(_T), __releases(*(struct mutex **)_T))
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr,	__acquires(_T), __releases(*(struct mutex **)_T))
+#define class_mutex_constructor(_T)	WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
+#define class_mutex_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_try, _T)
+#define class_mutex_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_intr, _T)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
