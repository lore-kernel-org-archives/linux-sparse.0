Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A32F39C4
	for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662496; cv=none; b=fUxzmU9DGrVydLwRn6BwMgoHR6RkSTN/SdQQ2wYtDTzxtUgjpvLplZYNv+SMBsAUuPN4cQHSnUnvHGq3RHCOjVmaSJzQGWJDDQNXxGpPlr55UAgbRANMKGMdEc2JA1g57HPGxdq2lYn1vTL8XcFqnO/etjAxsv69rnO+5uvmwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662496; c=relaxed/simple;
	bh=wecZEUleM2pVH/ldG6VyoxAP3Tx+t9JIJBh2fst1eeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBFrSfjgUm6nbmvVqk5uklBvaVPVwEe2AnffdgmyTOgo5ECF4Z4csisKX8H8zhEalp/aMn5e6K9bF9LKcJcq+kEpy+euPaUQgOY3cNEJs/UYt31MN0VaWVb31LygVV00PcMjYUOXaOsnTnKuHF03Gb7Bc1aSyuNcIXSN7dDq7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KXAEFF/f; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KXAEFF/f"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso1689926a12.2
        for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763662492; x=1764267292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=KXAEFF/fwj0FDCQG8K1fzqtKe+83MpK0CRPgZXsyIgOQFYb50+u0XPjr2A0skFvYRX
         97YflPDRN19ae4IgHCp4v2G70PuzguWjsRis661FPd+aTouWI17CNwP/+S0HfuLt6BYQ
         ssk+XbDSF/gYCUHQr5/JYjbFSb0YJdoo37gs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662492; x=1764267292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=RLGUKFVb7L3/1JeQD6Tbcb4v5IYWVoLRZCH3hlKQQ4u2fndoKFCJ3xK5g4VUvjSGxA
         5HQkUl0lcoanHSE8KwxE1jHtsDJ2ZK7l442uoPxWVl6VSQ+S6LtsdHTmqeoQWXvbf5Px
         HahBoZHpDkXgRG60PVGjBLNR8eHD2bF4a243PYy7zG5Tm8Sz65D0vLM39tjXlbV88a3z
         RRMcA0wbza6kV6kOocuFgUsMAPUB08PTgiTSQ1VjBtyDmGz8h8dREOucktC3l0Z5jfzO
         fGa3FX4GKAUtJkN3lkx1NMG1h8gd/k8Qpe1zD8b1rMt7cVJlHamuzYRHp+nr7RiZSnEo
         RmyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlNE5DJRP9c3bBMAgwAX0mAlHxSMw20T3M3lHAYn8uQjnjdZnv8e9jg14/d8BAlE6+TkyTVLDprdrmLV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqbHP/Xwjl3AcGBmYuNgklmUj5nzV1J/8e8vFv4YPtAORGY9Wz
	LaziLnJJe0dMTzTynnLFVdLU24MaPulGFFPWABATSwoBSB7m9D+1gMdXL4HVefurk1FXTDiXuoQ
	Q/Fy4
X-Gm-Gg: ASbGncspk9B/WsieBHV5YO21XLI6YtMgA7+RRqXaJdllFl0iZ/gspbIV7KONVNDoeB/
	2E1FXhtjxoy40kyvR9c52h803o9YAF8JA9NrMNy4G7OWxAuL6jWr6dtM3Tiv1F8NBM56D3Bmra4
	YGWO6F9Rk6wLIAnPYGy4OA1pjegMg6GkxzIOBv+iix69sFaeomSKhRC1PS4xnKUpYCFKTgK1WeB
	1kgDF/wpu6X8ti8uLayv0slQrJSF6oxYD/J6QREIOSDNGMYkDRvCaOPf/prDajGSRADorbgYDEA
	1C+ZzcEfIWLwonEdNDEQVK3bUUuseDuiEX38r56P61E84bJIpZU5vGhgDCNMYh0WqN1m0GRjiPV
	9RRCnU1Hgna83Q8/QmCfpONAMJhOVW0ODdW1FnAwZ5GUtk9ZGKm5g8GNJYNH6hi/DOTWgi17dqX
	rflJ1rYstO9wDkda5+D4fMMlL/dMOqS4Oe6wMaY219x3d3WYcdbYp16pyApW6H
X-Google-Smtp-Source: AGHT+IEp/syGJQnZ5JVPQMAyKfmxj+AE7XFlelLIHk+OpFfGTSmd6u7gH61BC4U3mghIWNpJAHzMKg==
X-Received: by 2002:a05:6402:35d1:b0:640:be87:a858 with SMTP id 4fb4d7f45d1cf-64536445fd9mr4230975a12.27.1763662492013;
        Thu, 20 Nov 2025 10:14:52 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm2615225a12.20.2025.11.20.10.14.50
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:14:51 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b737c6c13e1so227082066b.3
        for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 10:14:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV28mjUHAV6ZWDvRuQOFcEm/H821lc1eAHgo3TfaLpgEgpW3yiM68l6D0/l5EeEU9vuvx3eEazXPWgWfYo=@vger.kernel.org
X-Received: by 2002:a17:907:7f0a:b0:b70:b71a:a5ae with SMTP id
 a640c23a62f3a-b7654fe9b97mr482177966b.44.1763662490181; Thu, 20 Nov 2025
 10:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120145835.3833031-4-elver@google.com>
In-Reply-To: <20251120145835.3833031-4-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Nov 2025 10:14:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
X-Gm-Features: AWmQ_bk-my8wSL6P8yRhTUREdDraem8VrQQmjD7uS2S9oN6T2mRX46ftlS1ytQU
Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
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
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 07:13, Marco Elver <elver@google.com> wrote:
>
> --- a/include/linux/compiler-context-analysis.h
> +++ b/include/linux/compiler-context-analysis.h
> @@ -6,27 +6,465 @@
>  #ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>  #define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>
> +#if defined(WARN_CONTEXT_ANALYSIS)

Note the 400+ added lines to this header...

And then note how the header gets used:

> +++ b/scripts/Makefile.context-analysis
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +context-analysis-cflags := -DWARN_CONTEXT_ANALYSIS             \
> +       -fexperimental-late-parse-attributes -Wthread-safety    \
> +       -Wthread-safety-pointer -Wthread-safety-beta
> +
> +export CFLAGS_CONTEXT_ANALYSIS := $(context-analysis-cflags)

Please let's *not* do it this way, where the header contents basically
get enabled or not based on a compiler flag, but then everybody
includes this 400+ line file whether they need it or not.

Can we please just make the header file *itself* not have any
conditionals, and what happens is that the header file is included (or
not) using a pattern something like

   -include $(srctree)/include/linux/$(context-analysis-header)

instead.

IOW, we'd have three different header files entirely: the "no context
analysis", the "sparse" and the "clang context analysis" header, and
instead of having a "-DWARN_CONTEXT_ANALYSIS" define, we'd just
include the appropriate header automatically.

We already use that "-include" pattern for <linux/kconfig.h> and
<linux/compiler-version.h>. It's probably what we should have done for
<linux/compiler.h> and friends too.

The reason I react to things like this is that I've actually seen just
the parsing of header files being a surprisingly big cost in build
times. People think that optimizations are expensive, and yes, some of
them really are, but when a lot of the code we parse is never actually
*used*, but just hangs out in header files that gets included by
everybody, the parsing overhead tends to be noticeable. There's a
reason why most C compilers end up integrating the C pre-processor: it
avoids parsing and tokenizing things multiple times.

The other reason is that I often use "git grep" for looking up
definitions of things, and when there are multiple definitions of the
same thing, I actually find it much more informative when they are in
two different files than when I see two different definitions (or
declarations) in the same file and then I have to go look at what the
#ifdef condition is. In contrast, when it's something where there are
per-architecture definitions, you *see* that, because the grep results
come from different header files.

I dunno. This is not a huge deal, but I do think that it would seem to
be much simpler and more straightforward to treat this as a kind of "N
different baseline header files" than as "include this one header file
in everything, and then we'll have #ifdef's for the configuration".

Particularly when that config is not even a global config, but a per-file one.

Hmm? Maybe there's some reason why this suggestion is very
inconvenient, but please at least consider it.

              Linus
