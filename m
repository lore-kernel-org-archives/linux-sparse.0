Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D613D8AC;
	Sat,  7 Dec 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733562913; cv=none; b=mh5CMy/ZL2ekT1IZ5nuc8CgpFYKc4OK85kY1yfNPnpZKsBrsdSr9RR1jGkR/ZZnCaobGNFLSqh3M6AejWTv23ygeEAEG7xT3hignLf1ngTJCtNZSLu9CBRoI8EX49Pkgi8obLkGNJcJOkO6UYXosf2vXzAijL50hbnB9QfU121w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733562913; c=relaxed/simple;
	bh=huRGOuA6sHnabOZJpFhgi5lSLIFcZ3aSkaFlHFukdTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAGCN/00/MWQenyqJcxTQiTv66ZA3pbtVgIDaHGNAyHjreGg9X2DlwaUJ+3wVeq8gYZmyQM0b32tvQ4m2l2gP5SHckR2ZxsQYyLgjAbD4/caNNJZ15QrxPNV+l9ReXWTrYK6T0E0NWCOMyaBxGJRxOtvrug0EFh1K0YLz0RBVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dhWDFwds; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dhWDFwds"
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by smtp.orange.fr with ESMTPSA
	id Jqu2txNv8hfQMJqu3t1LwF; Sat, 07 Dec 2024 10:15:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733562907;
	bh=WL9xGcicUYweWPrIZdM4obw40wyP2AJI744Zi36nKfc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=dhWDFwds7RWH0fN/bRBBIvm8+Zp98bDNugCssGvA1RVZ83ilvP+Ez7EMvYmB9AOxC
	 LgjmGO3LcyX7TWdQ6JPJeyDeG9qlaYlM//SSNtJUC/DOxOehzf2KRYnr52D9Br/WX1
	 VxgPBHzokRIoex28Ow8lArMZHT5BlqbeKnc/juow3vz5JeWr0GkfdPCVqczJyMZM31
	 nYG2dQbn0fIwsS4WaCczxB8IFJvNUMIF0oRvZBlhYKiTdj54OZFYD1gUOsTe6jv40d
	 16BL8FnKEcgUdle067x4HC39C/hzLd+QwKQs6kKmfS5K01FytuRTmZMkyRRrhqA3fH
	 n7K2NPhphgGnQ==
X-ME-Helo: mail-lf1-f49.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Dec 2024 10:15:07 +0100
X-ME-IP: 209.85.167.49
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so2583648e87.3;
        Sat, 07 Dec 2024 01:15:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwUjpZftLT6U0QTUxMDif2CJcfY6PgVRC3wX2aZCwKYmDJYUKBfY/xJ2KE4mWKL2MHfhToS13asZama0f+J/o=@vger.kernel.org, AJvYcCVi+r6vULMHAOFjsYslAGlDkDJMBpB6IbqxSptocYtgt2riO9fC89lGLlUMNErru/fD/K5b4lNqISA+xU2a@vger.kernel.org, AJvYcCXO2MITLQCtg1yksIM3c0nHoDGEH9q9tYV0B8o0n03XnrczhGoF7IUYzIQdFSsaO4xqzKvZUhDbu8gXnhmv@vger.kernel.org
X-Gm-Message-State: AOJu0YzrlkYBFCpPyM6VRXBQS8g9rWkce4lZ9L7mXqnNmYEf8r47/ZDE
	8Zc/MokQ+NjywBk24w8+MQ7hpT1kAPRHLy0Q1LCZGDNKE1WQYSLiBKNoSK84n9HiIHaQ0KZ/iq1
	RxZckxOf9nNrb1zTB/g6mDQnllFk=
X-Google-Smtp-Source: AGHT+IF0UkbZeO6DhnG4OpInkasGFbpfvjfWezi2XR8vGYhVDKgOfxRspF7qPi3YhfQ2NuvOk/LKXDlfFe/grz4kS7w=
X-Received: by 2002:a17:906:b399:b0:aa5:33f0:c50e with SMTP id
 a640c23a62f3a-aa63a287c66mr153642666b.57.1733474989334; Fri, 06 Dec 2024
 00:49:49 -0800 (PST)
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
 <CAMZ6RqKLrDB-xkm2G242yU7L=tzxCR9NTwca-1yuWSSEHAOrxQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqKLrDB-xkm2G242yU7L=tzxCR9NTwca-1yuWSSEHAOrxQ@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 17:49:37 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJzPqfY4Uy3EWTTqRgN2Gq0hDr2R4zSDMEaMT_CS=05tw@mail.gmail.com>
Message-ID: <CAMZ6RqJzPqfY4Uy3EWTTqRgN2Gq0hDr2R4zSDMEaMT_CS=05tw@mail.gmail.com>
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

On Fri. 6 Dec. 2024 at 16:19, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On Fri. 6 Dec. 2024 at 15:14, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Thu, 5 Dec 2024 at 18:26, David Laight <David.Laight@aculab.com> wrote:

(...)

> > I may have liked "!!" for being very idiomatic and traditional C, but
> > there were those pesky compilers that warn about "integer in bool
> > context" or whatever the annoying warning was when then doing the
> > "multiply by zero" to turn a constant expression into a constant zero
> > expression.
> >
> > So that
> >
> >   #define is_const(x) __is_const_zero(0 * (x))
> >
> > causes issues when 'x' is not an integer expression (think
> > "is_const(NULL)" or "is_const(1 == 2)".
>
> But 1 == 2 has already an integer type as proven by:
>
>   #define is_int(x) _Generic(x, int: 1, default: 0)
>   static_assert(is_int(1 == 2));
>
> So, it leaves us with the case is_const(pointer). To which I would
> question if we really want to support this. By definition, an
> expression with a pointer type can not be an *integer* constant
> expression. So one part of me tells me that it is a sane thing to
> *not* support this case and throw a warning if the user feeds
> is_cont() with a pointer.
>
> If we just what to accept pointer arguments but still return false
> (because those are not integers), one solution is:
>
>   #define is_const(x) __is_const_zero((long)(x) * 0l)
>
> This would be consistent with __is_constexpr(): it does accept NULL
> (i.e. no warnings), but does not recognize it as an integer constant
> expression, e.g.:
>
>   is_const(NULL);
>
> returns false with no warnings.
>
> > Side note: I think "(x) == 0" will make sparse unhappy when 'x' is a
> > pointer, because it results that horrid "use integer zero as NULL
> > without a cast" thing when the plain zero gets implicitly cast to a
> > pointer. Which is a really nasty and broken C pattern and should never
> > have been silent.
> >
> > I think David suggested using ((x)?0:0) at some point. Silly
> > nonsensical and complex expression, but maybe that finally gets rid of
> > all the warnings:
> >
> >      #define is_const(x) __is_const_zero((x)?0:0)
> >
> > might work regardless of the type of 'x'.
> >
> > Or does that trigger some odd case too?
>
> Following a quick test, this seems to work and to return true if given
> NULL as an argument (contrary to the current __is_const_expr()). So if
> we want to go beyond the C standard and extend the meaning of integer
> constant expression in the kernel to also include constant pointers, I
> agree that this is the way to go!

I just came up with a new idea:

  #define is_const(x) __is_const_zero((x) != (x))

Similarly to ((x)?0:0), this seems to work with everything (including
with NULL), but arguably a bit less ugly.

> Side question, Linus, what do you think about the __is_const_zero()
> documentation in
>
>   https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr/
>
> Do you think I am too verbose as pointed out by David? Some people
> (including me and Yuri) like it that way, but if you also think this
> is too much, I will make it shorter.
>
> Thanks,
>
>
> Yours sincerely,
> Vincent Mailhol
