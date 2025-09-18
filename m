Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3772D7DDE
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232569; cv=none; b=fyRya+cOFuWSc7MDRFYxkks/UtMAFQ5nmEG48q3FvaP8RiOKF3vKcQgHwkeqHw2uRmbdtwTEKToFvCVgppJ6MVTCPQ/wkKqCmccZqTebEmFxI8uLA25uu10Ph9D0Si0DzJQsHXKxjjKMjZ8PH7yqnXoQQsLpZ11QLfA5lT76mDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232569; c=relaxed/simple;
	bh=OBdCMGeWv7G/tkOmZiDbcUQKLH/CnWF06gVEbnVu89c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uK8uM78azWhUwhen9BB4+KqjeG11hDPEJ4HoZzZZaWDdXMQ0unllvHGQw+wLfcilg26FSQMaBLg0vfjrEFqiQ3+dWHa7K4XWCyETBkpD3L8Do22QxjizQWTb9HcVPiAMQdrLVuXIyRkdH9uRBEV88voqJVhfZGD4/C/37MfXF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V6gniugH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V6gniugH"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-34fed7add35so10248911fa.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758232565; x=1758837365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=V6gniugH47GzHYxUyOkShL430z/r1HaPUnwS/n6Hi2d4GL1W1SiGkpaxQljOD+NKon
         BvEFl9RkMF5w4MqXDiFMYC4dmKJANcWOL5pBy9jH0RRxOdgZWp4iBkfM07X6m/dYAjOB
         O4kpQ2sMdcBlf4pZBUx9hr8u2lGPd5/8LNE6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232565; x=1758837365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=t75uyfvFvPHjVFbLl27xERHqNgl9pt0rgSpGOdO2GvTcxlt6PGMd/0NBG8WeVQSMzS
         XM2JT5Y2XT84Bu8q7tA4qjjVTDuG/x8luJ/ID4EX5XcldAZCfmRsKOf/1KkCq3HT0Ryk
         V6grC4pK+brv/iDLWdpeQnh5ia/jz0ERJ6DU5imOCh3ZPu1EsKuB8lISBFWIJboL6rUi
         x0oadFy/8ahcw6DY36T2w+Kw9GEaH0hlYAsY959g8zMpnjeuHLzNOidD75K4Xn5GS94N
         E4KBxccETivfVWbvqCphIFhaMjXrSjRXKKC3FxTGCpi73qwaOrJe+0Rg4G6Z98tImvWA
         Yv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXowFH/a34s5BhVlaZep6tWE+EeU7JcRnqDI5WlMvw1ZLsnS6EJ5aG07QqFvquD24kEhieVLxUStekSU+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwGBieIoB1k5HyGcnwcxsyTx/oPBtUIsOLou0Axe6cSIbAs0P
	9PTxIN1ektf+AucXzHLEEwX9eH9f7wzqjM+d7FtMcMev4/wTviwFdgTDWvEhOCWMjgEnYRPfVFB
	mFW2L1j2obw==
X-Gm-Gg: ASbGncvNSpEfHf4CeKVr0DRhwzdLB3g1sTu7NS/A6GG0owox90lZzP431wLvrSHheK3
	5UkE6EBv4V05NylZ9CwFlJjdcHjeIrksa8thLXdb2PJhX+D/+z6OTFps3/UwjaNade/3jGqQNdT
	wo1w93+jgq2Bo98FYccI9J10piBpJYVFi4gt4eWJZrNrK5wATga9Dl8/jGtxxOKNfwtISvh1Ure
	vI17m5rASCcwutj2utlaKbwhcngM+P1XEZxYHqNVyCN3O9ZCj5XQlwKJezctb0AooQSQmmREFGb
	wEN1pD/s0QGFVlYKA4hf8/2sPVl/VDMx4jz7HJmKKqcMS9W5BMUukgQU4VsR4aDtSFj0jFjG/Wf
	5NJKgP8RenNXKFU5JflIHsV2mGaxSVGTRLnxdgERKxBoRGb+/hanFZeh3CLl+AM5AipjvV8c0l/
	KvZtKpsyDssf3CNx8=
X-Google-Smtp-Source: AGHT+IHY/kNucWUHzJBra3a+MSGDQQEmlz6vatDMZkIKXOhgiC9TKtZZkgTTyicYdSye9R61kqowDQ==
X-Received: by 2002:a05:651c:20da:20b0:336:6481:1549 with SMTP id 38308e7fff4ca-3641709c3a7mr2569101fa.12.1758232565234;
        Thu, 18 Sep 2025 14:56:05 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a8e61bf5sm8794661fa.44.2025.09.18.14.56.03
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 14:56:03 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5607a240c75so1526360e87.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 14:56:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVH1oOj+gsH1frNmtVO08Nhz1iCr6DYsDJK/H8zb9+nrq7JqLt2fvRtdkLkOBxWE6UtB9nSXWK25ECl3aE=@vger.kernel.org
X-Received: by 2002:a17:906:dc89:b0:b0f:a22a:4c30 with SMTP id
 a640c23a62f3a-b24f5685fdemr62738866b.47.1758232077501; Thu, 18 Sep 2025
 14:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com> <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
 <aMx4-B_WAtX2aiKx@elver.google.com>
In-Reply-To: <aMx4-B_WAtX2aiKx@elver.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 14:47:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
X-Gm-Features: AS18NWBxHuMwwtU-EoNbPFA3uJ1YRJkAKqdurj12n-PWNJgH6ecKwZ8QZrX3P28
Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
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

On Thu, 18 Sept 2025 at 14:26, Marco Elver <elver@google.com> wrote:
>
> Fair points. "Context Analysis" makes sense, but it makes the thing
> (e.g. lock) used to establish that context a little awkward to refer to
> -- see half-baked attempt at reworking the documentation below.

Yeah, I agree that some of that reads more than a bit oddly.

I wonder if we could talk about "context analysis", but then when
discussing what is *held* for a particular context, call that a
"context token" or something like that?

But I don't mind your "Context guard" notion either. I'm not loving
it, but it's not offensive to me either.

Then the language would be feel fairly straightforward,

Eg:

> +Context analysis is a way to specify permissibility of operations to depend on
> +contexts being held (or not held).

That "contexts being held" sounds odd, but talking about "context
markers", or "context tokens" would seem natural.

An alternative would be to not talk about markers / tokens / guards at
all, but simply about a context being *active*.

IOW, instead of wording it like this:

> +The set of contexts that are actually held by a given thread at a given point
> +in program execution is a run-time concept.

that talks about "being held", you could just state it in the sense of
the "set of contexts being active", and that immediately reads fairly
naturally, doesn't it?

Because a context is a *state* you are in, it's not something you hold on to.

The tokens - or whatever - would be only some internal implementation
detail of how the compiler keeps track of which state is active, not
the conceptual idea itself.

So you name states, and you have functions to mark those context
states as being entered or exited, but you don't really even have to
talk about "holding" anything.

No?

               Linus
