Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F973391851
	for <linux-sparse@vger.kernel.org>; Tue, 17 Mar 2026 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733308; cv=pass; b=EUKnnPi7iB1KDxQstC7RvJW7CrLTt9GnyGHEl2KG7phDspQWYtrjhE23GVf6myb4GNj20MnkyF9KCj03SW4dLlOSxwuivi12rFniciiB/HriyNu/QHOHmK1fMVLJd3JDsg1DEDGwL0E+6vT9YB8K6yrEMMuoMIra5LhwL+WA/8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733308; c=relaxed/simple;
	bh=Ymu7de5y8mcBQQOlPNt0KMmqVo4DoRmu788FlMpGsWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeV2jfDxe0Q+YGriaPxJXnmO3hb2i7HCCmxS0sYPPtFMvh3qL0Ve1hhSKva7VoJ7yTdRENLh4G8NpozJpkvSOMxohmQtf4h5xYV1xGRN8OTebf0ByUYT3Ne8V3W6YsY5d1Ybg2oM2jCsy1KGYwx5Q2+IYSuNqOeR3KcQRpeOH0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so4402705d50.1
        for <linux-sparse@vger.kernel.org>; Tue, 17 Mar 2026 00:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773733305; cv=none;
        d=google.com; s=arc-20240605;
        b=cUY9hqywpj8UKXiEahhrL8WEA0sYYB2YNtqhXShIvpl+9V25nJ28WBYZ7VPTiaTSr5
         WHWWPV2zxEQdmCUPTGpxRi/dAvJxcGtnsU/gAi9GviQxNtv2H0GuSfT4OBTRK3eXYndf
         zSok0xeof9WoFiZ/vjOvdJLMEKCn3p6VaJlkCCNNtp6Nl4Gky7VmOSZOpumNT5ExLgup
         kOgcJkpwe7cD0wk/RT2/ZmSLtV0NBQUb6rjkg7ePgp+/gsNLAdc3/ANR7vl/8nPHSaKD
         hrPxtEf1NDEIUlT+fDCQbPUTA+hDNZ2lRNCKuUYBIEL6PL6t/q5NwbRUmwZ6qIpkAQdD
         BZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ZPpGzYc4GCttXVc1yqHjURbRGWKUg6RCSuS7T/D/h6o=;
        fh=qsSc/XqWbtnzfbBpHjNDHpsg0eeBytGT55ZUiaWq93Q=;
        b=PTDmmqEAd9wZoDPMc6dDo7qZY1btaiY2PS3qWVeN/qwx/rrivBIGQs3wHNy3/REkgS
         eEf54WPJNbqKtG13h6yLdG+bbmKQMFOEjmrzuZ6r8L0h+RuMcZqjoqSyJZhOZ98dCWwc
         IPUkFhZZj9JgCd+wXGb+5+DnY/VHleXv7gKDPkr3vBfo8EknyohwjnuiaTk9V6JKC6BU
         IUbTnF3jIIBIuG4/P7r4sjw5Y4g0Yr0GkBspck2rHsAv7pdTcrRRY98hiK6j6QEIKNLS
         hSIUtrIaFA1T/Gfqol5Z3Ip83bjbFkB76sbqv5XqeWqufYibp0MrL8g1+ZeaOlS4DxS7
         Uvjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773733305; x=1774338105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZPpGzYc4GCttXVc1yqHjURbRGWKUg6RCSuS7T/D/h6o=;
        b=mXIdrTazn/nKLUGQwTg2F4V8wrvMFiimHguE4URT5gMaYO3ZCGgoc+Qby8gqa5WFol
         iu3D6/zp1HLu0l7XruO7YnWOiuZ+Hu2JD+Ik/MeJ+RsO1tUlccnvCXzv4wfxuh8ZH3QA
         XTuJKc5GoYivdH4knqDbowRQFOcBEZ0oUcdnQuLSQoBkjuesP0ujeUzw/MNqUE8OiyGC
         hD6sOIeAeDH7wNzIwWT+DzMd9idGx9icYj5zpd825KvtIW4+GCDx0TfZCssLWqAoM5uq
         Vx0xxvtpMyKOWH2pkZKmOPvv0+5NIOOSv1iSCeoxVhgVWY4eWmmQmshnhPFDgl0l2oWp
         kiKA==
X-Forwarded-Encrypted: i=1; AJvYcCVpwqfX3ltdwv4H2VgwdQW4guLMnGrX9iQ6bXc4RllTRO/oddrwkfN72MOKzInP3EJkBuJKw/HYh+gRFCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEz4qOVWo3pDAvfColSSt+Xcr8FtS/iJbwuHAXWBx+Y8hd2sNi
	/d8P0y83iQV/jNAq9u+QKA0dv1aZVNcKdvIhHqWeIU7vDgcVa3+8B0pyk8yjVauM0/rAv809LPY
	Z3MLmY3zRxBRmHH08kzt9gVSMQuaDrEj4SZ8NT4cAFQ/zkgFCBeXa20vHQQ==
X-Gm-Gg: ATEYQzxvDDsFB4QD1wYai2SvRwRpPWfazVcWKE9DSlYtrgFXL1pyOvXaMasiiQylB4W
	9OlvvB5ruu8jd/Vs2neCmGYA8EEyAHjsU0DZFD1baMNklMRJjmuaQyaypPajPSjeBgXj3GqILrc
	zH8uTqs7MXGeUlZOGGYLcCxCZ474HqQYYOXYpUy/MTILAUIBs9pbCDKto7Z50RmYb4k0iLwMA83
	odt3E01B8G0WOEXrKwpAATMWhYmDqB2gdaFIxsI7MciRqsbU5OLgX1vbnl9d5KonSw61WepoFp7
	qedTxnO5H/uxVUKklzLhXpmqhwVjiVEVCgThgQ==
X-Received: by 2002:a05:690e:c46:b0:64e:8748:38a2 with SMTP id
 956f58d0204a3-64e87483c78mr3206307d50.78.1773733304955; Tue, 17 Mar 2026
 00:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072731.GA3093958@ZenIV> <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV> <20260226072945.GA4104757@ZenIV> <20260316065622.GA607739@ZenIV>
In-Reply-To: <20260316065622.GA607739@ZenIV>
From: Chris Li <sparse@chrisli.org>
Date: Tue, 17 Mar 2026 00:41:33 -0700
X-Gm-Features: AaiRm51xzvjIBwF6uhI52MJt5e9qa_vmEnznuBTy_gy3LZVZMfpEzQnVt5eJiJQ
Message-ID: <CACePvbUQtojHiCmGo+R-64W_yrofxc_J5TDTQ8--WWs+4y0aEA@mail.gmail.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Zhang <zxh@xh-zhang.com>, linux-sparse@vger.kernel.org, 
	dan.carpenter@linaro.org, chriscli@google.com, ben.dooks@codethink.co.uk, 
	rf@opensource.cirrus.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 11:53=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Thu, Feb 26, 2026 at 07:29:45AM +0000, Al Viro wrote:
> > On Wed, Feb 25, 2026 at 10:18:51PM +0000, Al Viro wrote:
> >
> > > NOTE: substitute() is the second hottest loop in the entire thing; on=
ly
> > > tokenizer is hotter.  And gcc is too enthusiastic about the inlining
> > > around that function, ending up with bad register spills, along with
> > > a bunch of stalls.  Worse, decisions are sensitive to minor changes i=
n
> > > places textually far away, making it a real bitch to deal with.
> > > Makes for fun reordering the commits in local queue... ;-/
> >
> > FWIW, looking at that thing again, I wonder if we would be better off
> > with doing argument expansion on demand rather than doing it in
> > expand_arguments().  Should be doable with a bit of care - we'd need
> > to mark the TOKEN_..._ARG with several bits to decide whether we
> > want to duplicate or not, etc., but that's worth doing anyway -
> > better than playing with the counters.
> >
> > Note, BTW, that collapsing TOKEN_..._ARG together, with "kind of argume=
nt"
> > moved into bits stolen from ->argnum improves code generation - that
> > switch by token type is _hot_ and it reducing the number of cases
> > gives a measurable speedup.  Sure, we don't want heavy work at #define
> > time - most of the macros are never expanded at all, but AFAICS this
> > kind of processing can be dealt with while parsing the body, with no
> > extra passes needed, etc.
> >
> > I'm going down right now, will look into that tomorrow morning...
>
> That turned out to be trickier than I hoped, but I've got something that
> works.
>
> See git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git #va_opt
> (or individual patches in followups)

Nice, I applied the patch at the sparse-dev repo:
https://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git/

I will push to the stable repository and make a cut soon if no issues
are reported.

Chris

>
> __VA_OPT__ supported, AFAICS behaviour matches C23.
>         * expansion and stringifying of arguments is full-lazy now -
> done on demand and at most once.
>         * va-opt-replacement parsed at #define time, handled correctly
> by dump_macro() (i.e. -dM), comparisons when redefining and at expansion
> time.
>         * arglist mangling is gone, so's the argcount kludge.
>         * it's no slower than it used to be prior to that series.
>
> I have local followups (tentative fixes for whitespace handling in prepro=
cessor
> and optimizations in tokenizer), but let's deal with that one first.
>
> Shortlog:
> Al Viro (21):
>       split copy() into "need to copy" and "can move in place" cases
>       expand and simplify the call of dup_token() in copy()
>       more dup_token() optimizations
>       parsing #define: saner handling of argument count, part 1
>       simplify collect_arguments() and fix error handling there
>       try_arg(): don't use arglist for argument name lookups
>       make expand_has_...() responsible for expanding its argument
>       preparing to change argument number encoding for TOKEN_..._ARGUMENT
>       steal 2 bits from argnum for argument kind
>       on-demand argument expansion
>       kill create_arglist()
>       stop mangling arglist, get rid of TOKEN_ARG_COUNT
>       deal with ## on arguments separately
>       preparations for __VA_OPT__ support: reshuffle argument slot assign=
ments
>       pre-process.c: split try_arg()
>       __VA_OPT__: parsing
>       expansion-time va_opt handling
>       merge(): saner handling of ->noexpand
>       simplify the calling conventions of collect_arguments()
>       make expand_one_symbol() inline
>       substitute(): convert switch() into cascade of ifs
>
> Diffstat:
>  ident-list.h                                |   1 +
>  pre-process.c                               | 929 +++++++++++++++++-----=
------
>  symbol.h                                    |   1 +
>  token.h                                     |  32 +-
>  tokenize.c                                  |   4 -
>  validation/preprocessor/bad-args.c          |  18 +
>  validation/preprocessor/dump-macro.c        |  13 +
>  validation/preprocessor/has-attribute.c     |   3 +
>  validation/preprocessor/has-builtin.c       |   3 +
>  validation/preprocessor/va_opt.c            |  54 ++
>  validation/preprocessor/va_opt2.c           |  34 +
>  validation/preprocessor/va_opt_compare.c    |  28 +
>  validation/preprocessor/va_opt_parse.c      |  37 ++
>  validation/preprocessor/va_opt_whitespace.c |  14 +
>  14 files changed, 797 insertions(+), 374 deletions(-)
>  create mode 100644 validation/preprocessor/bad-args.c
>  create mode 100644 validation/preprocessor/dump-macro.c
>  create mode 100644 validation/preprocessor/va_opt.c
>  create mode 100644 validation/preprocessor/va_opt2.c
>  create mode 100644 validation/preprocessor/va_opt_compare.c
>  create mode 100644 validation/preprocessor/va_opt_parse.c
>  create mode 100644 validation/preprocessor/va_opt_whitespace.c
>
>
> PS: as for the interesting uses of __VA_OPT__, consider this:
> ; cat >test.c <<'EOF'
> // based on a fun trick from David Mazi=C3=A8res
> // see https://www.scs.stanford.edu/~dm/blog/va-opt.html for the entire s=
tory
> // No, it's not unbounded recursion - up to 256 (4^4) elements in __VA_AR=
GS__;
> // more with trivial modifications, just add more levels to EXPAND...
> #define PARENS ()
> #define EXPAND(...) EXPAND4(EXPAND4(EXPAND4(EXPAND4(__VA_ARGS__))))
> #define EXPAND4(...) EXPAND3(EXPAND3(EXPAND3(EXPAND3(__VA_ARGS__))))
> #define EXPAND3(...) EXPAND2(EXPAND2(EXPAND2(EXPAND2(__VA_ARGS__))))
> #define EXPAND2(...) EXPAND1(EXPAND1(EXPAND1(EXPAND1(__VA_ARGS__))))
> #define EXPAND1(...) __VA_ARGS__
> #define FOR_EACH_PAIR(macro, ...)                               \
>   __VA_OPT__(EXPAND(FOR_EACH_PAIR_HELPER(macro, __VA_ARGS__)))
> #define FOR_EACH_PAIR_HELPER(macro, a1, a2, ...)                \
>   macro(a1, a2)                                                 \
>   __VA_OPT__(FOR_EACH_PAIR_AGAIN PARENS (macro, __VA_ARGS__))
> #define FOR_EACH_PAIR_AGAIN() FOR_EACH_PAIR_HELPER
>
> FOR_EACH_PAIR(F, t1, id1, t2, id2, t3, id3, t4, id4, t5, id5, t6, id6)
> EOF
> ; cpp -E test.c
> # 0 "test.c"
> # 0 "<built-in>"
> # 0 "<command-line>"
> # 1 "/usr/include/stdc-predef.h" 1 3 4
> # 0 "<command-line>" 2
> # 1 "test.c"
> # 18 "test.c"
> F(t1, id1) F(t2, id2) F(t3, id3) F(t4, id4) F(t5, id5) F(t6, id6)
> ;
>
> and the same output from sparse, modulo the # ... lines - sparse -E doesn=
't
> produce those.  Our (fairly brittle) analogue is __MAP in linux/syscalls.=
h
> and if nothing else, unlike __MAP() this thing does not need the number
> of pairs passed as explicit argument.  Would be interesting to try unifyi=
ng
> SYSCALL0..SYSCALL6 into a single macro that would bloody well _count_ the
> arguments...
>
