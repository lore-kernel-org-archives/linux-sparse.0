Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D2192B76
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512542; cv=none; b=H9Up++Bwf3u0+3C9E3SMD1tievNl88nipsX5txdRCS24WJG18MFim1kiGz3OFQTx6dt0GnfZ74fnwEqtDdLiDmNHlobkEL0Hfvv2zCM9ywkw03BJqWVO95JAGxWtuWCeh9sarTrFJBUOcVp6Fz9kY0RCj5wsBD3NhPy61adpI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512542; c=relaxed/simple;
	bh=i8VSKf3d9h7aPyCMroFIPs2BgVVC/quFiHlWg+y9lfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiJERHKNBhh5Op+Um+odP2KR6p1rzRhciDVjU/vO6BxRdm3jkBqA+YOvQPlJEu3ow56ZIc4Q7J4DPd+nfii7TB8gBRhDGvmpo6toLRIREeGBz5t9w1DyeEPx0/ui5FQ6Y6trMin021jO1RVACugd643AtLc9TVh4QsDvWwlFRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UxCybm7w; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UxCybm7w"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so2714381a12.0
        for <linux-sparse@vger.kernel.org>; Fri, 06 Dec 2024 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733512539; x=1734117339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB1D/kV+LS+wbR3JFN0rKIWFlL1hHHNzi40qmGJ0Urw=;
        b=UxCybm7w93T+ZWPiQAgME7Rn2EA9H6rDgxmx/nvYagMAxgcG9/8abf6z/lw61dtm36
         D1wFwMTnbs36AHyMTh1fWJoPbCedp79YW0GF4ClvMbfoUUmXhsyVbp16OPMLEkOWxian
         6Dk4KduLTZ9GPm3qR0C8g8k3o3xVXnWBBftlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512539; x=1734117339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB1D/kV+LS+wbR3JFN0rKIWFlL1hHHNzi40qmGJ0Urw=;
        b=avdmR9+fXSvbr4bL9Sno0Mm+FaRjhSbS3aBOv4FSNkbsqMZ4edJFTmx1Xl5Ffjbl3V
         ZzNafgbPV1aY/xMyoEO1oxjJSpCob6a3N/fiV1zlRQJpJ1czwsVlSlqHwddswN3iZNVt
         f4D12MVteLlIgiMKxvQMDUuZO+MdTNhsr423AoGlSUxogwfVd6kjAj27qpUDaJ2B6mvY
         faKYfOfZYcR3nJwPTgJzxup2LZWRo7Essa67GP70ZXucK5wISjc4J49nc1ixq7sJkKJ7
         o/frVGT+mY5ilvK0wYsV773zH58oeGvDuMTlBL2PDsOgFNIluvf4U6et5K45pITplSFm
         P10A==
X-Forwarded-Encrypted: i=1; AJvYcCXu2XtSpwaGSRjF5v3Somd9hu31Fl2wme7D4MWxyuZMJr6FK/TZrUHW0OSxD+uM8KoEFsmFUdCDfkaYXAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5l1GX/N+0bftqTeSp3GjybyjfpF+NPfzP//Wtiu1emMGeEAu
	WB7KDh+QVOcZ57sdDBFpmPFyY8SQahYbGSJyJh+/F99krV/NJxbkrG02RSzadxN310fP20obXhQ
	DAP34TQ==
X-Gm-Gg: ASbGncs7cf/Sibj76u4kMbM7tvHssmMxl83ZuuZu+Opl8Fh3wr9iPI3uwOFyN6wKcAE
	zBHUKi1cFr21hhvy+jrLmuvSmaij2wc7+tf6zpk6TDv9+8GKCCsMCqc+pIaaYIyRs4eWMMEYaxl
	VmvJg5OWTfgUk/CVFYQo9dlIYkjbPQcU/E8fK30ZAaybCblTHsXciAtIV/Xg0kSgtsdD0y6RCbY
	MicX1gUyif9KeIz17KBHgUjVbqTPipuI5CxBPoOvlq73ytMgl4WlTJvSqnNl5soKoUOrnLVRwam
	94DpKBj2eOk5fe+Dht3EPlao
X-Google-Smtp-Source: AGHT+IEo5yItwIjkdrGDUs5Z4mLzAYk3vc36wUKCTHgNt6yT8X/AEdYOhflxro/BBhQjkfePTzWBFg==
X-Received: by 2002:a17:906:cc2:b0:aa5:27d4:980a with SMTP id a640c23a62f3a-aa63a242b13mr287440966b.49.1733512539108;
        Fri, 06 Dec 2024 11:15:39 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62608f57fsm280883166b.146.2024.12.06.11.15.37
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:15:37 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a68480164so298793666b.3
        for <linux-sparse@vger.kernel.org>; Fri, 06 Dec 2024 11:15:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwZVgPdqkk9ACizc2PJfkxFazO1AkNqobokyLpO7kbmJXgIeFdcBgniGp/VSFFeTlJ8Eijyu6eAwtPN1s=@vger.kernel.org
X-Received: by 2002:a17:906:4c2:b0:aa5:308c:3489 with SMTP id
 a640c23a62f3a-aa63a2519b0mr271057466b.58.1733512537212; Fri, 06 Dec 2024
 11:15:37 -0800 (PST)
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
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com> <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
In-Reply-To: <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 11:15:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
Message-ID: <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"uecker@tugraz.at" <uecker@tugraz.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 11:07, David Laight <David.Laight@aculab.com> wrote:
>
> I'm missing the compiler version and options to generate the error.

Just -Wall with most recent gcc versions seems to do it. At least I
can repro it with gcc-14.2.1 and something silly like this:

  $ cat t.c
  int fn(int a) { return (a<<2)?1:2; }
  $ gcc -Wall -S t.c
  t.c: In function =E2=80=98fn=E2=80=99:
  t.c:1:26: warning: =E2=80=98<<=E2=80=99 in boolean context, did you mean =
=E2=80=98<=E2=80=99?
[-Wint-in-bool-context]

> Does a '+ 0' help?  "(var << 2) + 0 ? 0 : 0"

Yeah, that actually works.

And "+0" is nice in that it should work in any context.

> #define const_NULL(x) _Generic(0 ? (x) : (char *)0, char *: 1, void *: 0)
> #define const_true(x) const_NULL((x) ? NULL : (void *)1L))
> #define const_expr(x) const_NULL((x) ? NULL : NULL))
> I send this morning.
> Needs 's/char/struct kjkjkjkjui/' applied.

Oh Christ. You really are taking this whole ugly to another level.

           Linus
