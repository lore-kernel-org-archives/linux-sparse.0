Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08F1E529;
	Sat,  7 Dec 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733579456; cv=none; b=HroVBm4Feoec/NyAwldlOJOKOgbIbhuTVqvzco2CYCxGqHuJwHI2ZdfQ482/pIG0bUAETAyuCHMnPTnCc9oNAaOcJoBB2MuoJut8mS3cDH663+xYJXgZEPSe3KkQpUbYtZQUIvGYPjqwARLQbaXGJ+POajIL8FdMsY+lqrK60aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733579456; c=relaxed/simple;
	bh=tqpi9D9V12ZhYD/Eo2oo1VJUJRZoXZAOBye2Q9k0rME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHWmRs/bjGRop7D/YZNoQ27TOFAf6/O/5W28DDeL5VPG1vQ/KjVbiUE3OKuNHOKag35NgTRB3KNf2ndifuScQrNN5+x+m0IFtEJ8XqWs7F5Q0gNOxw6i28lXSm1WZM2XHpYkFYTeM9PiVJ7OeYMaAa/Ax9QpylsO7uyKjp34DJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZXJ8bn4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZXJ8bn4"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so470249566b.1;
        Sat, 07 Dec 2024 05:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733579453; x=1734184253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHFw9+ZFS/5kCWej9Q2r4cNs9qWMsdVVVFbrLzYifFk=;
        b=RZXJ8bn4UfsSbL81PCYYSYu2+C6r9uIsZnYejqWiTa6mbpTrv5IPS0mtV4DJAW1Lqa
         nSmgsbnjfVNbTb67ybCeD4ShwUXnhcKXXcKbo2Pzlx7sKt6TGKHmdOLXdr5XHcVwpp5C
         SGi+uiXozLRlkNLzX6Ajeihnrw0CvxLFWErUT7q/L6VL8KT3WOm7tdez4ofpdNPG+1O3
         3MvPrXgmFvxtWWKOdfiKJySORn6HZ5TeGpDOz1FXNoBt/II1u9Cr3Y1kwvb+YgN1av2P
         khuCv+3nZvgIMIxuVk6W3KDZZ8jAphEctGAgKq0H6plUNT9I16qSrRN9LEE1lsthSq5U
         ZtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733579453; x=1734184253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHFw9+ZFS/5kCWej9Q2r4cNs9qWMsdVVVFbrLzYifFk=;
        b=G5lsEG3M+OccCu5VQBnX1CH/OtcNdfnvQ6IXDOLIa/71CjHdPC9EdUUopEHXBL45QZ
         rJbG0d4f7zuStv6DNx4RR5tgRfnudAE+x4To5b4Y95vdQ0EaERWBHmISslkGz9PAR3Wl
         uZ/Iu6cCZdnuN7aQtaYZghXSuOoiJXSsFn51Hvs74QL12YsWAQxRIQXgBS0vmO+jDJNV
         yqFnoYBExUmI+QGbYeA8FWiAkb2q8k368FhV/hQo2us5QHEE9kHLIkphVUiU5dZqX+pC
         d8UZbsZvmSMWLDyW6KjDRalk7gIUaiwu+V+H6SBp0QqnYAJd3QzdrwHVltHc8JRr/9cf
         ma6A==
X-Forwarded-Encrypted: i=1; AJvYcCVs0cKj2PJMlk2F3F8sJkW2QBCDhoTupqOX4Dqsj6I0WW0Mjwjrc+8P8cPrsB1Ybq/D8IjcTOB+m4c0gTX/@vger.kernel.org, AJvYcCW05vw9hvNI91UcmBLkA2k5uQ4C8vK7sjN6yreqBjpdvQHNjQQPS5H6xHGauCyndvLDCGOlaUxhTU54SFWoT80=@vger.kernel.org, AJvYcCXQR+Guu9SvOWUlzXJ6kkCfTDBOYDXJ/NUBabTVFW79+Nf7ooXui8Ni5Dqcs6eifm3DYcJyzpIAkgkS5CDI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55p9tYMgSlwKUi474MmCrlB+MkKVb0AUA+EKYPerZoQjHxH87
	qsoAyup0B2Uh6VYp7GhpyrL127j/tFQ5OnUiw1Cn6oUarATba373uZ9/rPJNJgDHDMXxkb2INId
	lEuAO3ubGw2+ye1rGZzmaL9hJt2g=
X-Gm-Gg: ASbGncvFS0pbPOYSZSGI1LhqoPuxgDqW+PnTLD5iDupclcqcvvnLIMUCHFGem4D/lQd
	Jd3uyyQw8mIlyYApO7MqOgE+Bv9dZXDo=
X-Google-Smtp-Source: AGHT+IH6k2GyIlgxnGFl/g0StSGsvarnhcm9pbDRqjwA6P99KliYB7aZHWQfO50sclN4sezlsrdFqfGV/df1a3TMj88=
X-Received: by 2002:aa7:cf83:0:b0:5d3:d7c2:ca58 with SMTP id
 4fb4d7f45d1cf-5d3d7c2cad3mr7104642a12.24.1733579453216; Sat, 07 Dec 2024
 05:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <CAMZ6RqJGqBqvgxzp5yPFY1pk0WkkwEMM34qU-dZ3kXfsnKaqEg@mail.gmail.com>
 <429e7c6713ecc94494d9107e5f5a1f0c8e854f23.camel@gwdg.de>
In-Reply-To: <429e7c6713ecc94494d9107e5f5a1f0c8e854f23.camel@gwdg.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Sat, 7 Dec 2024 22:50:41 +0900
Message-ID: <CAMZ6RqL+iS6GVsY20=O6GdQakRpp7XdewZJsUbmE5OCsKaHR6Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat. 7 Dec. 2024 =C3=A0 22:19, Martin Uecker <muecker@gwdg.de> wrote:
> Am Samstag, dem 07.12.2024 um 21:45 +0900 schrieb Vincent Mailhol:
> > On Sat. 7 Dec. 2024 at 17:39, Martin Uecker <muecker@gwdg.de> wrote:
> > > Am Freitag, dem 06.12.2024 um 16:26 +0900 schrieb Vincent Mailhol:
>
> ...
>
> > > I find it amazing how much time the Linux kernel community spends
> > > revising code to make it work perfectly.
> > >
> > > Still, I am wondering whether some of this time and effort should not
> > > be targeted at C compilers and language work to make these macro
> > > hacks unnecessary?
> >
> > It seems to me that the long term solution to this problem are the
> > constexpr functions.
>
> How would constexpr functions help here?  (I am a bit sceptical about
> constexpr functions.)

I was thinking of some of the "side features" of constexpr functions. Namel=
y:

  - std::is_constant_evaluated
  Link: https://en.cppreference.com/w/cpp/types/is_constant_evaluated

  - if consteval
  Link: https://en.cppreference.com/w/cpp/language/if#Consteval_if

I did not try it, but looking at these, I believe that this would
allow us to rewrite most of our macros into some constexpr functions.

> > But the core issue is that before getting this support in Linux, we
> > have to wait for this to be added to the C2Y draft, then implemented
> > in the compilers (probably just reusing the C++ constexpr functions)
> > and finally wait maybe one more decade for the C2Y support to reach
> > the kernel. For reference the kernel supports C11 only from 2022=E2=80=
=A6 So
> > maybe we will see those in the kernel around 2037? Meanwhile, we have
> > to deal with those hacks.
>
> If we do not collaborate on proper solutions, then you might have
> to wait much longer.

I was invited to WG14 this September. For now, I am only lurking. The
thing I have in mind right now is to write a paper to allow the use of
static_assert() in expressions (i.e. make it return 0 on success).
That should be a relatively small change, but would bring a nice
quality of life improvement.

For context, look at this:

  https://lore.kernel.org/all/CAHk-=3DwjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5=
k2ZpDbgA@mail.gmail.com/T/#m1ba33a804b4041154b72a1d0333f90ec7204c461

And I will definitely follow the progress of constexpr functions in C2Y.


Yours sincerely,
Vincent Mailhol
