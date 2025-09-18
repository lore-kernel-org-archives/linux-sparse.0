Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B004155A25
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211088; cv=none; b=Wt5d/1d8CfTAAOmwLny23E7RdZ4Zdgji5/RTywtoYLORwxPGCHtZIw3Z3KQdRqWPtV8kK5goR2KIESwrdzN7DmCpIZ5+QohUJ0tSUdb/SJ2t10UvWO5oJ9XHxOdsj/wVlnKHf3euYueNiEjKkkNwza20WdzJAodGisczj4rGXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211088; c=relaxed/simple;
	bh=XhR1h2E8azi9+Iqslf03I/SakVc5s2CaBmw/N8HkwwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZSjbpinH72mtzLaS2LrC+cXq0IbOlMxgrBFxkMEuffV8fC1TEaftDxLsnXrjRBqB4KRjSoiThVt4DyT5sz3BND4DFUZPWU8x1AhnxZZPdXGXht5agVlGpOcWu51jpO949FBJ42fZrlwunMYPfOUogDeGZ5uZCy6+C0QOCZDW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dC+ag/Lu; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dC+ag/Lu"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f98e7782bso1453306e87.0
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758211084; x=1758815884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=dC+ag/LufgIaY/EgLUyyM42/rWto4TuKKcCB2dL6oEOJB1VAePjxxdJlZI0kc+NnAN
         jeHXll5kdn5dWkK/epjHHi2X2pZTzGpe5EVv1svbEZfO1Ynf04ZmHF7HtPiu+PiA9VaQ
         BRUZ+RtydqED5ueOtlC5WEMAkNgHueb78cON4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211084; x=1758815884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=XjzCCluxpcY6Qp5mLx0/aMxNridqkIs3BbjFwnp8jzeiCqM7dHyoQzYeEASYfZWE66
         EXhy5/XOpdQv9GPZZ/7irNtMH35E0zMNKQdeo3oMUOsxiqeEPcnkfVeEZctQ6hw74OrY
         epd4qTanwtMVRAOU/MHaT30e+b4XANx5BzyHPvs5/W44bsdSBrsS0vRLZbjszOG7VHaq
         r7cuVx+a089XmZSSEGnH6c3W5TSM/cpNj9Ny78NKhgBlTkuomcfWpfHqUXD+b/3asjim
         m67x5Bq95zcibSVI/drbuAYO+WaH23UnP0jGCwPApZOXN4FqKC4DVWFyndy95pva7q6b
         lQCA==
X-Forwarded-Encrypted: i=1; AJvYcCWLYXETTRQQTbmvxOU2vLrF4wHB4tSRCQ/dUq/KjP7ddp2ZhtcLIlxdEDynxUj0Px3ggCmSWUm5blA9fds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgwIkgp5Ly7r0gkEG6xZ0qE4TWxWUX6JOsEUfcwyxIVklJBlq
	6pdBd99YEmeRbc+XGidaBcogAo+R9Tlv62VObjeiB8aFPAM+pdcEDQh5za9lit7+EP8/P4kjujY
	J0wunXFaGZg==
X-Gm-Gg: ASbGncvbZcQbr3/T/mPzHLd2k9U+PQbkkzu6OXEih6upSNZs8PdZcjNFNm/ATKeb6I5
	d0iNazXEF16DJadx+x/ddat6PPtdPNgTN4DRHn6dcirN6/8seuj/7FZO8V3zR6+hwvjePUfffay
	2ZfW1mLLv9DaDBT6Ox+PDmSeVizVcf9q3uvlYuIowFhjlwRe3EakxyVpyxERaHUDsuxSQbJdDIr
	gZItpXZruEX84/jeyRPvsU02G7g8n6Y+0iIHQb9oIt18DVq3GtvdojKkTpiFievq3K9mQjPge8t
	yJLz05qZ9fjr8gZArNDin95QuBe79gEvNOvJ4qRF4UPq/euxQQC2i73U4Q2DcoNYaCME+8KNr7H
	XMrHZmE+PfNmUFcXbaLA40G9N3CQFq7seb4+muNONOR1Es5qeuMR4JOjAvV7sP1FhAjJ5AOHXwP
	WZRbRCxY9SBOeFkMLt8so=
X-Google-Smtp-Source: AGHT+IHplfKxQhEx/+6Ot75LqcvLarbei/PS2Qou28Po/G1SuWleoFowltJd6r7B7EdG3QgoQCeKBQ==
X-Received: by 2002:a05:6512:3b0e:b0:55f:52d9:8e73 with SMTP id 2adb3069b0e04-579e3f2d3f1mr55645e87.19.1758211084276;
        Thu, 18 Sep 2025 08:58:04 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a6507259sm739597e87.35.2025.09.18.08.58.03
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:58:04 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3515a0bca13so25315251fa.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 08:58:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPu/iy2MjSmN2KAyNqMTBlRj8wyl+EpzAH+pm9oFP5QlYMvqu2f351Acn0M82YQ2XFQNyEpCso4S/7cmI=@vger.kernel.org
X-Received: by 2002:a17:907:9612:b0:b10:ecc6:5d8d with SMTP id
 a640c23a62f3a-b1fac9c9b84mr417765966b.26.1758210601571; Thu, 18 Sep 2025
 08:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 08:49:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
X-Gm-Features: AS18NWBk4u9ObN57KesSGhJyt-aPlWZgKdxYhvzpAyoaxlNUF53WHe4dSKjzUBg
Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
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
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 07:05, Marco Elver <elver@google.com> wrote:
>
> Capability analysis is a C language extension, which enables statically
> checking that user-definable "capabilities" are acquired and released where
> required. An obvious application is lock-safety checking for the kernel's
> various synchronization primitives (each of which represents a "capability"),
> and checking that locking rules are not violated.
>
> Clang originally called the feature "Thread Safety Analysis" [1],

So this looks really interesting, but I absolutely *hate* the new
"capability" name.

We have existing and traditional - and very very different - meaning
of "capabilities" in the kernel, and having this thing called
"capability" is just wrong. Particularly as it then talks about
"acquiring capabilities" - which is *EXACTLY* what our lon-existing
capabilities are all about, but are something entirely and totally
different.

So please - call it something else. Even if clang then calls it
'capability analysis", within the context of a kernel, please ignore
that, and call it something that makes more sense (I don't think
"capabilities" make sense even in the context of clang, but hey,
that's _their_ choice - but we should not then take that bad choice
and run with it).

Sparse called it "context analysis", and while the "analysis" part is
debatable - sparse never did much anything clever enough to merit
calling it analysis - at least the "context" part of the name is I
think somewhat sane.

Because it's about making decisions based on the context the code runs in.

But I'm certainly not married to the "context" name either. I'd still
claim it makes more sense than "capability", but the real problem with
"capability" isn't that it doesn't make sense, it's that we already
*HAVE* that as a concept, and old and traditional use is important.

But we do use the word "context" in this context quite widely even
outside of the sparse usage, ie that's what we say when we talk about
things like locking and RCU (ie we talk about running in "process
context", or about "interrupt context" etc). That's obviously where
the sparse naming comes from - it's not like sparse made that up.

So I'm really happy to see compilers start exposing these kinds of
interfaces, and the patches look sane apart from the absolutely
horrible and unacceptable name. Really - there is no way in hell we
can call this "capability" in a kernel context.

I'd suggest just doing a search-and-replace of 's/capability/context/'
and it would already make things a ton better. But maybe there are
better names for this still?

I mean, even apart from the fact that we have an existing meaning for
"capability", just look at the documentation patch, and read the first
sentence:

  Capability analysis is a C language extension, which enables statically
  checking that user-definable "capabilities" are acquired and released where
  required.

and just from a plain English language standpoint, the word
"capability" makes zero sense. I think you even realized that, in that
you put that word in quotes, because it's _so_ nonsensical.

And if not "context", maybe some other word? But really, absolutely
*not* "capability". Because that's just crazy talk.

Please? Because other than this naming issue, I think this really is a
good idea.

           Linus
