Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64F2206AA;
	Fri,  6 Dec 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509873; cv=none; b=TJddpiKl3HoV8sIZWNtjL30B3h6py2jX8YVOZxO1aKvqg12Y0eHrKyawoal1vtm0RSunNUT2OK4kDmrOlKE0yr9XpDJqoxnQq6EuM1/aHO4ZL2f0CunrG+PuSYkFKZd2fRXIw84doK/DSnj6TEhWyjaxxOlON/BNEH7IcmGVdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509873; c=relaxed/simple;
	bh=+2N0lSYv+NBz4Y6vr/lNiuvfJV7RX8RYoJK6s9GX4gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu8oF91OAvlUVOqUTvN9aUit8B7i/nuiDtuWdMXDO8AFtgMFal7GSSlbRaE+mgsUTD9jSMYc+pfRkoku105tHAmiYki3DxYVhXSjqv1jcX0iWphx+OvovhWMPE7GSGq6iK0HGB3cJ/kt2sINtwa0xRYpWz1lYIaFXro+JDtzsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAB3cP5n; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAB3cP5n"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so93253366b.0;
        Fri, 06 Dec 2024 10:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509870; x=1734114670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7buzdn3/PR+OZ7E9SojfZrudu0PKQFtLTRAFouRbM0=;
        b=HAB3cP5n48M+C74hHmh0ZmzPikkGLr7W6X0e5OjefouJmDGSUXywTNd5I+0i324Ugf
         yfCjgkfN+ETLhQRZ4Ys+jUjUdqkHXNioDxIMGDIDqFDYLjX/y2jRHxw7OvVxM9eofqew
         QW0p84FKJiZUWBfdFFW5iH0/o6R4H09z1q6UyMvDueyXJYT+24RizpqInZrrUDedKebq
         CU+/8DJUKYHbJkPjPndSxYfAUfQG78Yrfa3EDsRLXSZDloL18WSgIw4wwqgUvIMri1xR
         rI2F1PykG7VJ/vyjPLCCFpCAF5X+EVMTItNedawzEj64ktPiCSGiDlRGMdc6gbkxhhCL
         4Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509870; x=1734114670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7buzdn3/PR+OZ7E9SojfZrudu0PKQFtLTRAFouRbM0=;
        b=h2obUv0JVnhzDGBZ9vgMP/ZxrsFWZTsxeceAfQvJp+tSKe/86JQQZUSlCvB9OFLJDV
         TsxSD6y3YjUUq1s2M0fwBAbWkZPeAyaiVhpHigPyE2Q88C2X23xRIQi3j9qMlCF6RHXi
         FcfsycTTxZTuKB6vBbVp0Ifp64UG4qvcL/qh6NEIu1wcDEJxhee+L7c0PAjyqqPsQMw3
         D+qXHYfW5TpciCI+ohz7CNl33ZzxS24EzHcGPwmGsyG/P8FboTN1CIu5t0A0msx9EaAX
         13tkF2XWQr64GK4nKcF9OONaxJcD46T8cIMYoYdqEdjZsNoUpHlW0ZcXvnHukYjM7eR8
         z+kA==
X-Forwarded-Encrypted: i=1; AJvYcCVXQZAs5k6whasUNkuYgeKyUIDvSIbKFijngOCc6mNvVryn+K+pIwb8Jc2Bc+v1mmh8F2SerH1z0fo1aWtk@vger.kernel.org, AJvYcCWyYxzAXA7KdeikVya/MpUTlAWnFkys43LdRknTgb4r1StXO08lg9AsdpJWp2iuqiqE72BMiKy3xA366nDg@vger.kernel.org, AJvYcCXA1BsnBVLeV6UCRKu1M9iVfKs4MuXF8fTenRXiuAi1SR9m+ek1mVtvHZDIzqGCE2E1ap5aWkzRxU1bHPG8sn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncDg7soEWJn3bJsmFhOz9D5PdWWNie1rgtP9zbTB6o3ciCO+V
	tkvTm3bdCPadudVQkBXjQ3+2Thipkrjq2MawXInd5CMeYoNHK7/rov1vys15NSpK0y/HAcdQUDj
	s7X+CbWxkFDRzbCpDUVf12lWZK4c=
X-Gm-Gg: ASbGncvMT5+iVgfpl7P+hKhmtKTDMYFgj+fCa9LYdZNkQM+JlpPmnlU+/BRPU4c93Vs
	skWOFWBFHxP0u3UAMiPg3cUOxEWL69oo=
X-Google-Smtp-Source: AGHT+IFnd7xj5Pq9akTxmspxJbkFJbmmIA03mUFW2B6h+sDDSyh+/NdbCh8gBxT6LtqsX9b+RXGKw/QASht5Itx+9Lw=
X-Received: by 2002:a17:907:7703:b0:aa5:46d3:4d88 with SMTP id
 a640c23a62f3a-aa639febbbfmr329138866b.15.1733509869483; Fri, 06 Dec 2024
 10:31:09 -0800 (PST)
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
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Sat, 7 Dec 2024 03:30:57 +0900
Message-ID: <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Grrr, I just realized that my emails are bouncing=E2=80=A6 Didn't happen
before, I guess this is because my smtp server is unhappy with the
many people in CC.

Resending using another address (and, while at it, redacted two
messages to combine them in one and added more details).

My deep apologies for that, really sorry. Also, maybe the bouncing
messages will finally find their way out? In that case, please just
ignore them, and sorry for the noise.

On Fri. 6 Dec. 2024 at 15:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 5 Dec 2024 at 18:26, David Laight <David.Laight@aculab.com> wrote=
:
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
> "is_const(NULL)" or "is_const(1 =3D=3D 2)".

But 1 =3D=3D 2 already has an integer type as proven by:

  #define is_int(x) _Generic(x, int: 1, default: 0)
  static_assert(is_int(1 =3D=3D 2));

And regardless, __is_const_zero() performs a (long) cast, so
__is_const_zero() works for any other scalar types. Even the u128
works because after the (0 * (x)) multiplication, you are left with
zero, preventing any loss of precision when casting to (long).

Here are some tests to prove my claims:

  https://godbolt.org/z/beGs841sz

So, it leaves us with the is_const(pointer) case. To which I would
question if we really want to support this. By definition, an
expression with a pointer type can not be an *integer* constant
expression. So one part of me tells me that it is a sane thing to
*not* support this case and throw a warning if the user feeds
is_const() with a pointer.

By the way, currently, __is_constexpr(NULL) returns false:

  https://godbolt.org/z/f5P9oP9n5

and the reason this went unnotified in the kernel is because no one is
using it that way. So instead of complicating the macro for a use case
which currently does not exist (and which goes against the definition
of an ICE in the C standard), why not say instead that this is not
supported by just leaving the constraint violation in is_const()?

> Side note: I think "(x) =3D=3D 0" will make sparse unhappy when 'x' is a
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

If we *really* want to go beyond the C standard and extend the meaning
of integer constant expressions in the kernel to also include constant
pointers, then what about:

  #define is_const(x) __is_const_zero((x) !=3D (x))

As established above, comparaisons return an int, thus making this
pass all tests:

  https://godbolt.org/z/f5zrzf44h

And it is slightly more pretty than the ((x)?0:0).

(...)

Side question, Linus, what do you think about the __is_const_zero()
documentation:

  https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-2-4e4cbaecc=
216@wanadoo.fr/

Do you think I am too verbose as pointed out by David? Some people
(including me and Yuri) like it that way. But if you also think this
is too much, I will make it shorter.

Thanks,


Yours sincerely,
Vincent Mailhol
