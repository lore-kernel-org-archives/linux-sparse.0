Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65117591;
	Sat,  7 Dec 2024 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549974; cv=none; b=bwDDchGghG4+Vidix1Xl30s3hLjeE6LbO0rHMVC9ZwERRUBg9k9lhiyQ+4Yr9A3yExVyT9W5WkBatevcTGr0Eo8wdTwvryMSKCnm0NZN7v14mrVoG9J+brX6fcvOLXjMF2NCSwM8QL3XPkIpxsuSFtss00as7FHa9nlmovqMm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549974; c=relaxed/simple;
	bh=gG3hzY7MHlAi9KcZyaLalqsMDvFVa2GEYwMxbrVqTi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJdHTqj2UR9547qJJytX3alOnBtv/tJEDPkgNG1Ptnu/32HXQbTMwVSIejCKXSI5ksXxVFkIbfNMD0bHt4uZDcSGy64YM+/aULXCsMGxETDi1Hn201gGW2wbXJY1S7037eEd3FcYDbadp7ZMpJPsxU+onybqpGMC+ID9IKLKEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JmvvEx1U; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JmvvEx1U"
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by smtp.orange.fr with ESMTPSA
	id JnXGtNdLxrVFvJnXGtI2No; Sat, 07 Dec 2024 06:39:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733549963;
	bh=GBRrBlRLVT7TL533lKb1vFLdI9Y/T44KcDVsiEUWS/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=JmvvEx1UPqRlipXPGnEc1HLuLgslUqQld1j/8im5ifw3b3FIEKt+j0rkjGffyvtJ0
	 1ZFX8MX9QQIYRu6CEWzPUWXI8Lcb7LPLMxbAjVm3DXNFSaYRWyKho1e18M4LH9M6w/
	 QwU3cpkhD7Wi5wn4GbHuLxwwc6ILkca2CWzmMnwQP5B6Js9dTKD1oIGtPG+0efVasg
	 cE1sNjGNSTEF3LBb7u266RyIK2K/JDdz+NqxwIO/bt1uRibcKmPMWG17ts0H8o/vJr
	 /tBPZaPy08d08bknX0zwHq7KgPilp4uZP+qI53zzIu0/44j0uoaUIuAlGYwnxiB/i8
	 +MkdZkLVkJYjg==
X-ME-Helo: mail-ed1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Dec 2024 06:39:23 +0100
X-ME-IP: 209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso3189879a12.0;
        Fri, 06 Dec 2024 21:39:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4WB3vP4YImrIVbQ3L27CP7IKcmVvelScLvxD+x4CdsBwwr81RanUolgGLEUvvJSzZ5DYC3nrDwO1KrI8D8Ug=@vger.kernel.org, AJvYcCX5gLPKoIQHuGxfyvZGLWq7qdQaWW4MCFSsEmQRgjPhfa5cuPyLIX7MTC3tF3MGUcf1Chb2lHHaA3Gq1RCz@vger.kernel.org, AJvYcCXoRxdefqWTSrhZuUqeXouznCVMrSaJarO7/9lmif1ezQCkCk6swPRQBKXTgKtGhUUtJUeCpTAV2T9Ljnu5@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9p4RbtEwo/wCUaOUwQsX73iALRgMQMitwoucgcDH/UDSNlwt
	dT9pcY9I1dEFNqJO5m6jOl9emy0W/bwLXLttwTYg8Mila8njx9NIu2ceti+vf0TDoOubkjYKAfx
	6+6iBTPNAN17J3AM8P1ZvZoBtsto=
X-Google-Smtp-Source: AGHT+IFeJU5P21g2+KpTjso/RWJ0896W/J65sLmbtkloH76ZizTy87kZbTnF4kB92tm0ezpnDi5dm2fIynDl5PgBmTs=
X-Received: by 2002:a05:6402:5253:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5d3be661fc5mr3945565a12.5.1733469604117; Thu, 05 Dec 2024
 23:20:04 -0800 (PST)
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
In-Reply-To: <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 16:19:52 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKLrDB-xkm2G242yU7L=tzxCR9NTwca-1yuWSSEHAOrxQ@mail.gmail.com>
Message-ID: <CAMZ6RqKLrDB-xkm2G242yU7L=tzxCR9NTwca-1yuWSSEHAOrxQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, uecker@tugraz.at
Content-Type: text/plain; charset="UTF-8"

On Fri. 6 Dec. 2024 at 15:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 5 Dec 2024 at 18:26, David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Vincent Mailhol
> > > ACK. Would adding a suggested--by Linus tag solve your concern?
>
> I'm genberally the one person who doesn't need any more credit ;)
>
> > I actually suspect the first patches to change __is_constexpr() to
> > use _Generic were from myself.
>
> Yes. And David was also I think the one who suggested something else
> than "!!" originally too.

Ack. Then, I will add a suggested-by tag to credit David!

> I may have liked "!!" for being very idiomatic and traditional C, but
> there were those pesky compilers that warn about "integer in bool
> context" or whatever the annoying warning was when then doing the
> "multiply by zero" to turn a constant expression into a constant zero
> expression.
>
> So that
>
>   #define is_const(x) __is_const_zero(0 * (x))
>
> causes issues when 'x' is not an integer expression (think
> "is_const(NULL)" or "is_const(1 == 2)".

But 1 == 2 has already an integer type as proven by:

  #define is_int(x) _Generic(x, int: 1, default: 0)
  static_assert(is_int(1 == 2));

So, it leaves us with the case is_const(pointer). To which I would
question if we really want to support this. By definition, an
expression with a pointer type can not be an *integer* constant
expression. So one part of me tells me that it is a sane thing to
*not* support this case and throw a warning if the user feeds
is_cont() with a pointer.

If we just what to accept pointer arguments but still return false
(because those are not integers), one solution is:

  #define is_const(x) __is_const_zero((long)(x) * 0l)

This would be consistent with __is_constexpr(): it does accept NULL
(i.e. no warnings), but does not recognize it as an integer constant
expression, e.g.:

  is_const(NULL);

returns false with no warnings.

> Side note: I think "(x) == 0" will make sparse unhappy when 'x' is a
> pointer, because it results that horrid "use integer zero as NULL
> without a cast" thing when the plain zero gets implicitly cast to a
> pointer. Which is a really nasty and broken C pattern and should never
> have been silent.
>
> I think David suggested using ((x)?0:0) at some point. Silly
> nonsensical and complex expression, but maybe that finally gets rid of
> all the warnings:
>
>      #define is_const(x) __is_const_zero((x)?0:0)
>
> might work regardless of the type of 'x'.
>
> Or does that trigger some odd case too?

Following a quick test, this seems to work and to return true if given
NULL as an argument (contrary to the current __is_const_expr()). So if
we want to go beyond the C standard and extend the meaning of integer
constant expression in the kernel to also include constant pointers, I
agree that this is the way to go!

Side question, Linus, what do you think about the __is_const_zero()
documentation in

  https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr/

Do you think I am too verbose as pointed out by David? Some people
(including me and Yuri) like it that way, but if you also think this
is too much, I will make it shorter.

Thanks,


Yours sincerely,
Vincent Mailhol
