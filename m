Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380A311C10
	for <linux-sparse@vger.kernel.org>; Fri, 12 Dec 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765535913; cv=none; b=HtIYk1Dk7jbcQGV53QLUhfUZQX6ThKGzy0hPzSf3bplnz03T8AGALZ2s9la9Xut3ve2oKcr94gI5wo69jOGQwuWjjyWn3uzqhmr46MMLm+vTkBkqbbrTLZSvcr2uxTgHcD2Kg2GGp96cG5QTjqP+io2YU91wIQkY1JxG+WeUNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765535913; c=relaxed/simple;
	bh=nctQCqtW4QYyeaejz8PEb38w/v2g7uc6tb41WntjKNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXvb4fDjv7LdUOpMv9kOy8cWDtFvbJOUXyhkQM3EKG+kIc3B5G924fccP9bbTGa+WGU9+FPL7M7s1XF9yvuhiDuxeS/X5RUZxMGs7i60GeJ+sDJEeIfRuavbbh6NhAkIYbK+UiHtvVXP1eRF2/LnA5WaJHCJu/AtlfgqQCU8D4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWBV45nA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWBV45nA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f1bc40b35so10765185ad.2
        for <linux-sparse@vger.kernel.org>; Fri, 12 Dec 2025 02:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765535910; x=1766140710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nctQCqtW4QYyeaejz8PEb38w/v2g7uc6tb41WntjKNI=;
        b=ZWBV45nAwslwXNgSHG024c/Oy1RmaBreP/JPthjPK6Jn3HbrFhY/wFxrZTcGlUl/y1
         IS6CYLqUB1OtkjBoyRT7ra/01FbS2V1xFEGhQDGLun2iMirwgFf/D/bJ5Y3H6aKsjHJm
         bxk7aQuwkLRdpQ+JQgvYpMrvbsNQSQ91mBr94ywIb5UfQAUGOo75ot/0ykpD1NCrivgb
         Fsd/G8OtIM18F+PuPayPs4TkVif9WU0Mn5tXO6rLkdQ9bvpbkl+pVoGuSF9m8Z6obSID
         +7sWGc4mEzKG3LIAhrR0ynh93NV6ssWdE3dJW6XZLRzv4RvHHFFoIPDwwHs5uHOaPCzu
         Q9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765535910; x=1766140710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nctQCqtW4QYyeaejz8PEb38w/v2g7uc6tb41WntjKNI=;
        b=Qo0si04YqiDWvz1+zYML9Bv+QF2N8AaCq/JTl2Y8fCWyJUTJRohN0tuHMyyluHVmWW
         7N7HwpniKnA8W/PGyjms/P7X5DmF85hhXIVMUdyFp8Aq1RDWjFUu5dNh3fPjXJV7nmYY
         NDm7SzNnrPb/tE631oa4OBZ/oh0ghFa2CPb7fwMIbJhQnEy6FRsSHo1QvNIauP6+Pf7o
         cfMP0PLPIPhujl5oMD1Q0A8hCF2ByWpxDsMDO+ZtSdf2tqyOi2wLoWYEyr6OILBDr8kS
         hfRdpS7Sy9sVmTFn4PKdE4WvHj6HIHiT2M4vJQM1c3SfMKU7fnUB6FwSITTs2WPml229
         O0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN2zLKj61vh2oMbaTnOUEkjKTa/bJTsbx3522LCERn5dWnqzoPcVdl58KeDBRWoHC1Sopc/pfzMFCvPz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynKhU3/R58yRnXu1U7B1Dco1dmeM+kT9uU8D0i0Dyv9TELKE+d
	iphgC4DfSZr4T3FHvKuuWuFkPCuZUCmWva4kU0VoBRNQfXpMql9+WvASpghxlTSWzSxqnaQebDm
	xDNhRYKVoYuA/sH4eoH13zPWNnYCihxUFheHgpdBR
X-Gm-Gg: AY/fxX6W7QQq0udbE/x+/rLn2aSr33Sc4/S20NqiwtZGhZ6e7XUKYfbXBWG0x4XHMbi
	4Z/ZBDZFRHo/zi6MTiusfUwfJYT7iCv0PvX/MtTF3wj4gTFZYN+ePVsGAdXGq0Ovdb/pVmTwOJ4
	V4IR2P4O9Wr1gFtFaDU4Yr9QiHE/oVYkDgsKPacSuk+epB3+xoZtaDv4C/QLBtw51rpkxu/ar3o
	mN40DqYsnVrWnNgmW3eKVLxqqwHdLRkVLZW0TTs2X3nNMy1efDOXIXdApd7lyNz+15nxbR4cOqA
	3HmT9oFyxuJklnphBFrIW/gNwWA=
X-Google-Smtp-Source: AGHT+IHEQqbAgYefprbsSuiVLt7KDiCECxoW496oPYm+Bj8DbPCCV7ccSZXk9zoE7kqarbEHot35Mb+a9uphNkvnkwk=
X-Received: by 2002:a05:701b:2719:b0:11d:c86c:652e with SMTP id
 a92af1059eb24-11f34ac540dmr1125346c88.5.1765535910093; Fri, 12 Dec 2025
 02:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120145835.3833031-4-elver@google.com>
 <20251211120441.GG3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOyDW7-G5Op5nw722ecPEv=Ys5TPbJnVBB1_WGiM2LeWQ@mail.gmail.com> <20251212093149.GJ3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251212093149.GJ3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Fri, 12 Dec 2025 11:37:51 +0100
X-Gm-Features: AQt7F2qnWyV-H6zf6AeMnZTuFb_nb7UwLLraoghpFqSJ0q6RecRlENqaq0woPuo
Message-ID: <CANpmjNPcw5AnpLpaFvyRee7mH12Ym-NKTx331xXEusK5zpiscA@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 10:32, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Dec 11, 2025 at 02:12:19PM +0100, Marco Elver wrote:
>
> > What's a better name?
>
> That must be the hardest question in programming; screw this P-vs-NP
> debate :-)
>
> > context_lock_struct -> and call it "context lock" rather than "context
> > guard"; it might work also for things like RCU, PREEMPT, BH, etc. that
> > aren't normal "locks", but could claim they are "context locks".
> >
> > context_handle_struct -> "context handle" ...
>
> Both work for me I suppose, although I think I have a slight preference
> to the former: 'context_lock_struct'.
>
> One other possibility is wrapping things like so:
>
> #define define_context_struct(name) ... // the big thing
>
> #define define_lock_struct(name) define_context_struct(name)

Note that 'context_lock_struct' (assuming that's the new name) can be
used to just forward declare structs, too, so 'define' in the name is
probably incorrect. And to avoid more levels of indirection I'd just
stick with one name; if 'context_lock_struct' isn't too offensive to
anyone, that'd be the name for the next version.

Thanks,
-- Marco
