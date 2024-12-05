Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2D1E492;
	Thu,  5 Dec 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427304; cv=none; b=dKZGGFGxYL96d16TIwhNlSYa8gXRZnrJjCQPNcLZ9HJ3rJgNtwPSVQLVm3EnUGTslmE9pr08EX6TvI4ArfGBUNguTguKgWM1ggCrfIkbYV2WBU/Mz0E0dm14XZg1Mj+rwPl0z4wqRquC+0if6po6oOzScaGWQ2uzRXPRtokAfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427304; c=relaxed/simple;
	bh=l03ckjiHPorjA8gus97LZ3ryPn3/bYJ9+uD0vBgzyho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYN1UWXrfdxGhxVUPfcRr6k9e6eEIBn+hDzwOW7NlsVeeAXKLattkfiiYpblUzLHApLt+tnggPRqWUyrKBIfdeQ4iiKJSVeLgPZ9m5TNqPWCEyrbFxWErKFvalh//JZlXa1te4lq8IUXxzYKlw+Exth1lG3zE+VU125ntW5t0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=a8Z+qwPi; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="a8Z+qwPi"
Received: from mail-lj1-f181.google.com ([209.85.208.181])
	by smtp.orange.fr with ESMTPSA
	id JHbktUI5D60jWJHbkt0ASm; Thu, 05 Dec 2024 20:33:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733427233;
	bh=L5clrau1lRtsXlazqJvRaiJm9ebUB3H7RT0weXhH8So=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=a8Z+qwPiCiUyFdFAjZ1p/4rRaY16/Mhttd3Jwv3NDVPTMVQiQ8vw/PR6bJg9dMGts
	 XyKQLyjKXy4tB1A/sIQ34zX50ia+zK4DTKTZG4oCRWdgxDm6ib41J3iyoJwaQRgSNT
	 V/Etv+Zx3xOFpMK58TR3IUJLtC8HPwa3kMSNgYbUO7lGQ2Z07V+aDRn5FgdIjMsncQ
	 Xwua+rxuPaRoeoqH2uVYOmHP2sDb9MRMDUD3NXnj0FqbTy6+UIGELMB8KsIqBjy0zK
	 +q6vIISskryaz2OVnhHBnYJD9/OaeEReN5bGS6YjrwPheuRl92596NmII9BFKNTzCR
	 Z/4L19/bzYfUw==
X-ME-Helo: mail-lj1-f181.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 05 Dec 2024 20:33:53 +0100
X-ME-IP: 209.85.208.181
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30020d33d05so10578061fa.0;
        Thu, 05 Dec 2024 11:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOpZUTVCDcEmm86kZK1AJDk+hw2e0wEDJ2hhGu2qGXIcQJZ73LSNj5b4GUHtcm3eJsOm3GttmtcRLkbFi94Qc=@vger.kernel.org, AJvYcCWaKB8h9Ed0X82GP3Hp2pdwbWQ/RuQOrfy2jp1yCFCfgAOgnGoDs8TLVe56DsohktJaYqnY5R4iIjo2J16i@vger.kernel.org, AJvYcCXLOqVRTPtWeUIR0iBR7Vfeg2EHyGdy3VkvBbBq4x0oyORfGS+YawlxedqbjJkXL54gESW6RJflVWe4ez/w@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqmIpceFFgzMYxQ70DXNVhxaurS22eqRaujhLxqE6Wygv2wph
	qm6FynMw2YoA61j5m0SF8u+/8k+NB4KIouqjEPkiS9KXSQiSbEAbObf6vnTGiy7bN/wYbTS/CKE
	vkh2QNp9Po/ujhLcYGcmj8LH7wng=
X-Google-Smtp-Source: AGHT+IH7WYy/8Hc8H+vVCwhqalxjzlWUoqcEyoqkjWQBBxloHACrRQF+5k7EKnQaTMOmRJCyI12iNEP09nDvxOtT4aY=
X-Received: by 2002:a05:6402:358f:b0:5d0:fc12:79e3 with SMTP id
 4fb4d7f45d1cf-5d125063c34mr3565576a12.15.1733414047033; Thu, 05 Dec 2024
 07:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-6-4e4cbaecc216@wanadoo.fr> <ad4482cc835543578862051431f5174f@AcuMS.aculab.com>
In-Reply-To: <ad4482cc835543578862051431f5174f@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 00:53:56 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJMXKaa_xDcyweGwb+FqvANrpvrkRvnjh6_s-J1ApVmaA@mail.gmail.com>
Message-ID: <CAMZ6RqJMXKaa_xDcyweGwb+FqvANrpvrkRvnjh6_s-J1ApVmaA@mail.gmail.com>
Subject: Re: [PATCH 06/10] fortify: replace __is_constexpr() by is_const() in strlen()
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

On Thu. 5 Dec. 2024 at 03:58, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 02 December 2024 17:33
> >
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > is_const() is a one to one replacement of __is_constexpr(). Do the
> > replacement so that __is_constexpr() can be removed.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  include/linux/fortify-string.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index 0d99bf11d260a3482bbe46e35c7553c0ccfb8b94..e3f2f772c5439ef71eb4a904b4ce27956bc69743 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -254,8 +254,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
> >   * Returns number of characters in @p (NOT including the final NUL).
> >   *
> >   */
> > -#define strlen(p)                                                    \
> > -     __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),      \
> > +#define strlen(p)                                            \
> > +     __builtin_choose_expr(is_const(__builtin_strlen(p)),    \
> >               __builtin_strlen(p), __fortify_strlen(p))
>
> I'm sure Linus suggested a way of doing that without replicating
> the __builtin_strlen().
>
> Indeed it may be valid to do:
>         len = __builtin_strlen(p);
>         __builtin_constant_p(len) ? len : __fortify_strlen(p);

Then, wouldn't it be better for strlen() to be an inline function
instead of a macro?

  __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
  {
          __kernel_size_t ret = __builtin_strlen(p);

          if (__builtin_constant_p(ret))
                  return ret;
          return __fortify_strlen(p);
  }

I tested it and it worked on an allyesconfig. So if I receive no
objections, strlen() will become an inline function in v2.


Yours sincerely,
Vincent Mailhol
