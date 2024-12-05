Received: from out.smtpout.orange.fr (out-11.smtpout.orange.fr [193.252.22.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8FA224EA;
	Fri,  6 Dec 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492074; cv=none; b=dV3LgnT9XaUqqz+tgBMZsuOstPWi4leW0blQwkzetx3RiqH0fNNACCqbWE54ShrpfHJOFBe4w6bR0YqE7ccRHP81prqY0dQNTCzFBXFdxqPxiyIFKlQDW3fHErVLnyOAxdtcPuG+NT7AHuqR/baSSmyrLQl8XH2SNUnEGsxNsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492074; c=relaxed/simple;
	bh=xIpQAgKEraRSL0RoJOcbUawoMAYTVxlvxGt2v08UmTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4G/c3+jB/ocARZIJk+cY6lbpLeBPNIoC2p8T7FwKfpKPWItOW/q13/LxescvprnydzsTIYOJ7vWQZNMFrMitwpBMIeujWfXtfD2hUS4bsVHIjenolc7EzKaBf/ehIWhCO3C8rLoHx6lXVZdbo1wAZfoSahz5aBwD2T3On2vcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sHukvqds; arc=none smtp.client-ip=193.252.22.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sHukvqds"
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by smtp.orange.fr with ESMTPSA
	id JYSKti5we3wKNJYSKtpHXW; Fri, 06 Dec 2024 14:33:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733491996;
	bh=j52yWXL33J+b9C4aQGdxSf0Rg4c/99LnqEiKjLeaVbc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=sHukvqdsLXBdLCC5GSHxe4+Sj1vU0ZsRurb1o1Mq2+tn3RhZ3R7GpUIXHpHn2wFli
	 0rTNoYxthc7Ed2W6bwo/OYXm+joSd4ndyDnvQu5ydTx5TM32IOTHdiGmk9angdrbbk
	 cpIDbusRfnlfUmM+oLIPWglkGg2HOiI4np0co39Ri1maHzPT+ln9U6BkTISjsl4UIH
	 BZYzKIZuLLsMc/SHnuoi2gQFFCGbPpMj4APEMh7aLDvc3ayzgbHtOcBhNkNJUErU24
	 GAXssA9EBHEubZmiaY+HAji98LKpDjFSDjCYHpFKCqnSZVdvKnDWD92qgMVrZVNJ4S
	 mopdAIBu5Qryg==
X-ME-Helo: mail-ej1-f44.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 14:33:16 +0100
X-ME-IP: 209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa643eb7f24so54020566b.0;
        Fri, 06 Dec 2024 05:33:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUraftUwawQd3uQWCjKA+zQYXrhG/TRKrgSeTQiBRgv7Ob3LlKumE1bQj+Ci880hia4lyJtZplo/VewDSN717o=@vger.kernel.org, AJvYcCWllUVGgEbW0QkzTdpy8V1DmhddFwrbnBAmFhDXfI23JdKGonAVUIKRR6zxA++J2qtYmJV6PjCaOAlq1Wd8@vger.kernel.org, AJvYcCXxfOsNNqfCMjif79mgECjKqNJ+zePLM8j62A7z0m4ws8ccTVH/iCeEvO827DRH7QuutvSLzHmphmm2IdBS@vger.kernel.org
X-Gm-Message-State: AOJu0YzMp0rq3zUQmhlcqnRwx6LaNrxfoh4t9JDqO/HxQr+zOD3hMKnE
	obbL0lkzPBDIMUhQ2+nrmEGIbKoxgGJcFacmuV4UT2Yh8PwrsqHilPq9ddcMXq+IE6f02wm0h7G
	yrigmFdpTZUT/X9d+Q05vCBi1IKM=
X-Google-Smtp-Source: AGHT+IFPV3ip3SYHkyJAtAl7kySK0yuNHOCaaw0rmFlBgQknleAfhI1fXHmOk07U56ZQY/Lp14i5paMJiLtiZFuprbE=
X-Received: by 2002:a17:906:2191:b0:aa6:2d5c:29ce with SMTP id
 a640c23a62f3a-aa62d5c2a3bmr190097866b.52.1733413722571; Thu, 05 Dec 2024
 07:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-3-4e4cbaecc216@wanadoo.fr> <c617483816b54096ba4b30bea595da49@AcuMS.aculab.com>
In-Reply-To: <c617483816b54096ba4b30bea595da49@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 00:48:31 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+=-d0_v3Xqj0CpaPbNuzQuv1SouTkc3Ew5vc5Sb_DUng@mail.gmail.com>
Message-ID: <CAMZ6Rq+=-d0_v3Xqj0CpaPbNuzQuv1SouTkc3Ew5vc5Sb_DUng@mail.gmail.com>
Subject: Re: [PATCH 03/10] compiler.h: add is_const_true() and is_const_false()
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
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
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 5 Dec 2024 at 03:48, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 02 December 2024 17:33
> >
> > __builtin_constant_p() is known for not always being able to produce
> > constant expression [1] which led to the introduction of
> > __is_constexpr() [2]. Because of its dependency on
> > __builtin_constant_p(), statically_true() suffers from the same
> > issues.
>
> No, they are testing different things.

OK, I will remove this paragraph.

> > For example:
> >
> >   void foo(int a)
> >   {
> >        /* fail on GCC */
> >       BUILD_BUG_ON_ZERO(statically_true(a));
> >
> >        /* fail on both clang and GCC */
> >       static char arr[statically_true(a) ? 1 : 2];
> >   }
> >
> > Define a new is_const_true() and is_const_false() pair of macros
> > which, by making use of __is_const_zero(), always produces a constant
> > expression.
> >
> > Note that is_const_false() can not be directly defined as an alias to
> > __is_const_zero(). Otherwise, it could yield some false positives on
> > huge numbers because of a lost of precision when doing the (long) cast
> > in __is_const_zero(). Example:
> >
> >   is_const_false((u128)ULONG_MAX << BITS_PER_LONG)
> >
> > Furthermore, using the ! operator like this:
> >
> >   #define is_const_true(x) __is_const_zero(!(x))
> >   #define is_const_false(x) __is_const_zero(!!(x))
> >
> > would yield a -Wint-in-bool-context compiler warning if the argument
> > is not a boolean. Use the =3D=3D and !=3D operators instead.
> >
> > It should be noted that statically_true/false() are the only ones
> > capable of folding tautologic expressions in which at least one on the
> > operands is not a constant expression. For example:
> >
> >   statically_true(true || var)
> >   statically_true(var =3D=3D var)
> >   statically_false(var * 0)
> >   statically_false(var * 8 % 4)
> >
> > always evaluate to true, whereas all of these would be false under
> > is_const_true/false() if var is not a constant expression [3].
> >
> > For this reason, usage of const_true/false() should be the exception.
> > Reflect in the documentation that const_true() is less powerful and
> > that statically_true() is the overall preferred solution.
> >
> > [1] __builtin_constant_p cannot resolve to const when optimizing
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D19449
> >
> > [2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output f=
or max()/min()")
> > Link: https://git.kernel.org/torvalds/c/3c8ba0d61d04
> >
> > [3] https://godbolt.org/z/E4r7EaxW9

D'oh, I used some old versions of the macros in that link. The link
will be updated to this in v2:

  https://godbolt.org/z/E4r7EaxW9

> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  include/linux/compiler.h | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 30ce06df4153cfdc0fad9bc7bffab9097f8b0450..165aa5b9bc484376087a130=
a1ac1f3edb50c983d 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -357,6 +357,29 @@ static inline void *offset_to_ptr(const int *off)
> >   */
> >  #define is_const(x) __is_const_zero(0 * (x))
> >
> > +/*
> > + * Similar to statically_true() but produces a constant expression
>
> No.
> It tests whether a value is a 'constant integer expression' and
> the result is a 'constant integer expression'.
> statically_true() checks for the value being a 'compile time constant'.

I still would argue that =E2=80=99constant integer expressions=E2=80=99 and=
 =E2=80=99compile
time constants=E2=80=99 are *similar*. Not the same, agreed, but not
drastically different either. I picked the term *similar* for that
reason.

> Most code really doesn't care, it all got added to min() so that
> a very few places could do:
>         char foo[min(16, sizeof (type))];
> without triggering the 'variable length array' warning.
> But that just bloated everywhere else and (IIRC) Linus replaced
> them with a MIN() that was just an expression.

What about:

  Return an integer constant expression while evaluating if the
  argument is a true (non zero) integer constant expression.



> > + *
> > + * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
> > + * which require their input to be a constant expression and for which
> > + * statically_true() would otherwise fail.
>
> Use a different BUILD_BUG macro instead.
> Look at the current definition of min().

Do you mean BUILD_BUG_ON_MSG()? That one, at the end, relies on the
error attribute:

  https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-=
error-function-attribute

And the error attribute logic relies on compiler optimization. So
BUILD_BUG_ON_MSG() is not a valid example here because it does not
require its argument to be an integer constant expression. It works
well with other compile time constants.

Another valid example would be _Static_assert() but as a matter of
fact, it is more common to use __is_constexpr() together with
BUILD_BUG_ON_ZERO() than it is with _Static_assert(). So I think that
BUILD_BUG_ON_ZERO() is best here.


Yours sincerely,
Vincent Mailhol
