Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2E3398A;
	Sat,  7 Dec 2024 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557376; cv=none; b=GWxHhAGILxZ11LvItqIwP6kXHeZoP90xYwUMKBpCRHCEDERJ5lhpCpSZuCJvQnzFlFY1w5kMMS3IpWu5vvc+s0DJAx9mYOeL7h3hGHKksC8QQSi3g4cPEpVFqvwbokL4f4WSQJ+u0qArDu7nxidWt6TUXQSGwbZeKy6ZuzkbfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557376; c=relaxed/simple;
	bh=zXC701XlS+Mku5aOxt11GhmVlqiDr7cEZoBagLZyIo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMSjvpkQDdOrPtt+vg4ahs/a/iNdrhlbFRjS8RqOuViTSYigrm6z/Rin2RptjqyaQWWRT2NUOY1IZHfZ8cwNmDKHRy+bY88KnORldZW+hR+OlxsyWHx3rKLBcvtcpr4nT8HM6O/TQTH8KLMdghK6BZob7F08N6p+ba0O9z8BzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUrg3Bg+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUrg3Bg+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa5500f7a75so372254566b.0;
        Fri, 06 Dec 2024 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733557373; x=1734162173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd+JXxg1Trx18tJn2WFf9QCw9lSZFwBnHLKDbtoBF3M=;
        b=hUrg3Bg+3lRP9T3Yd3/S7fOPJ373gHskUmgMijO7KF4ciZ05aKt9brje2NvUmwi4xU
         ladK+uxtGxesPmq22czwHRCchIVZWpFkt3J7QcvHahXvEMiKdjYN/2lS3s1JTdfV1H5s
         Wv3pJGNl3NX5zTQG4HyoQJq7KRCLk/+gFO5kRpjW5SyD3XHRLsDc/S0Bo1mFFnDEyqym
         gAlSbvaL+a5z0zcPf6AuVkRr3R7CHCLfzVWUoJqTrWy2eSMJeXkzOBlUQtxH1ySfwfdz
         2UT1ofv+XoWSW8fbtO+EgoN1Eh7yl7BiFz1057oDHz4j8nZIy9UYrmVH5f6+p/gCK9AK
         3P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733557373; x=1734162173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hd+JXxg1Trx18tJn2WFf9QCw9lSZFwBnHLKDbtoBF3M=;
        b=SonasElSpw4HnsuzoC6ML6Lh//HYO9b6PAPy6F6WVxgP4RpAjiy59QrZ6LChnnXhiD
         6E4M55dZbXi6uYjQEKqEA/KOZPaTaSjjSE8lX8AUw5dnWyiJtGoEMvyVL88svFb6pNKh
         uR7KXGMGFXxbGpFCye1/R0rZejWR4nVDpeCTfdJcaHP7ChpOMpnNV/KSptmV3g2hTuhf
         jXlNQfkfNT3OIHNzd7iiKUoEAgz7QGK91Kz7BAjjWqbRQfjPenDjrQ9Rd63f7kLADDrM
         J+qwLQ+bs+g5K83Oj4KV1rFcbJ6Kz98LUyEq8XxLcTvOod5N1XT8g034p6fGiurxH8vx
         27jg==
X-Forwarded-Encrypted: i=1; AJvYcCVxDKFRSPmYeuwJYeI3Nl9jr88V2IWuKaRzLw14OCdxFArYOLXX41ZC9KCaeaUv2rEjKFwmoYz9am9jlJRA@vger.kernel.org, AJvYcCWFd7CBqBPD2wry5LfY43Tj6DJh/u+m6dtS6Pk2aD9kJBgO/wCjYnGx9k8nKcwYE4RRS1XlmhF0te/zXqGoX04=@vger.kernel.org, AJvYcCXAmTSp7xCu+U8n1zsxlZl9HijKTUCLifGVHySl8e3hlI/TZKyILdfEvrLoOgeFV79hUO1M1OcRKQQNuHpF@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVQErRNanC9MOp0MIS7vzIeOaRROxo28aFSD9EF/KYVC6eoGu
	9160Rv5wrjQl1qZsVOGpGiUAhaKkIta9kDcFaVKP1nwfQR1uHacV2uHXIdHh9u93CJMjk7C55kt
	W2OcU1+rh693zQSz8RifGYbXfOz0=
X-Gm-Gg: ASbGncuN85PfeSmt5pCODsKRUmPPRmf4WGeVnWsrev9GczOLpjoBmXgXaT7Gnik93nA
	l/xW8BsFhWc9JSTQ8e4KB6lPbGOx7ztE=
X-Google-Smtp-Source: AGHT+IFtbq3U+qyH15cm3qJcpaS8xIxfktbIH2S26u2IkmcJ4yPTJg9aqWHgPR/Bx1zVWKXpdweVI0tjzLEF2jmrRv0=
X-Received: by 2002:a17:906:31d1:b0:aa6:62d5:653 with SMTP id
 a640c23a62f3a-aa662d50b73mr25238766b.54.1733557372613; Fri, 06 Dec 2024
 23:42:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
 <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com> <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
 <0f5c07b827c3468c8fa3928a93a98bfa@AcuMS.aculab.com> <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
In-Reply-To: <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Sat, 7 Dec 2024 16:42:41 +0900
Message-ID: <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: David Laight <David.Laight@aculab.com>, Linus Torvalds <torvalds@linux-foundation.org>, w@1wt.eu
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"uecker@tugraz.at" <uecker@tugraz.at>
Content-Type: text/plain; charset="UTF-8"

On Sat. 7 Dec. 2024 at 05:24, David Laight <David.Laight@aculab.com> wrote:
> > > > #define const_NULL(x) _Generic(0 ? (x) : (char *)0, char *: 1, void *: 0)
> > > > #define const_true(x) const_NULL((x) ? NULL : (void *)1L))
> > > > #define const_expr(x) const_NULL((x) ? NULL : NULL))
> > > > I send this morning.
> > > > Needs 's/char/struct kjkjkjkjui/' applied.
> > >
> > > Oh Christ. You really are taking this whole ugly to another level.
> >
> > I sort of liked that version in a perverse sort of way.
> > It does give you a simple test for NULL (unless you've used 'struct kjkjkjkjui').
>
> Except const_NULL() really doesn't work at all - so you are lucky :-)
>
> So maybe the slightly long lines:
> #define const_true(x) _Generic(0 ? (void *)((x) + 0 ? 0L : 1L) : (char *)0, char *: 1, void *: 0)
> #define const_expr(x) _Generic(0 ? (void *)((x) + 0 ? 0L : 0L) : (char *)0, char *: 1, void *: 0)

This still throws a -Wnull-pointer-arithmetic on clang on const_expr(NULL):

  https://godbolt.org/z/vo5W7efdE

I just do not see a method to silence that one. So three options:

  1. is_const() does not accept pointers and throws a constraint
     violation:

       #define is_const(x) __is_const_zero(0 * (x))

     This is my current patch.

  2. is_const() accept pointers but is_const(NULL) returns false:

       #define is_const(x) __is_const_zero((x) != (x))

     This keeps the current __is_constexpr() behaviour.

  3. is_const() accepts pointers and is_const(NULL) return true:

       #define const_expr(x) _Generic(0 ? (void *)((x) + 0 ? 0L : 0L)
: (char *)0, char *: 1, void *: 0)

     David's latest proposal, it requires to remove the
     -Wnull-pointer-arithmetic clang warning.

I vote for 1. or 2. (with a preference for 1.). IMHO, we are just
adding an unreasonable level of complexity for making the macro treat
NULL as an integer. Would someone find a solution for 3. that does not
yield a warning, then why not. But if we have to remove a compiler
check for a theoretical use case that does not even exist in the
kernel, then it is not worth the trade off.

Concerning is_const(var << 2), the patch I submitted works fine as-is
with all scalars including that (var << 2):

  https://godbolt.org/z/xer4aMees

And can we ignore the case (!(var << 2))? This is not a warning
because of the macro, but because of the caller! If I do any of:

          if (!(var << 2)) {}
          (void)__builtin_constant_p(!(var << 2));

I also got the warning. The point is that the macro should not
generate *new* warnings. If the given argument already raises a
warning, it is the caller's responsibility to fix.


Yours sincerely,
Vincent Mailhol
