Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE163E47B
	for <linux-sparse@vger.kernel.org>; Sun,  8 Dec 2024 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733685091; cv=none; b=Y00kp17KFN/SF1DTYYGiJuKit5zzWcRCwwLEE6sCsTN+VCxaLP0c4SDx6hxtjujwgBYaaQanj6ZAOdpLWrCwja5IIGkpx5tsgfNpTzRrSmku95VHcRWpV49sWmJ+7G+FPTLzLINJD/XYkvpeAl/P5C+Pu5m1V9Q+9XUuL0a8I3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733685091; c=relaxed/simple;
	bh=6Hln1NJrynRFPSlOkJsikZnjs05QWUijpiLr2fyjuQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKEp7pakJnusm9WovVtQIsU6eFHbjdPYH4FjQorYUnmgrNSETFXgu1W/of3rwx6Y2B6ihuDGdUnFGXjwxPRIj06gFjjx/zLPP4K7H5EcviPRdCXk8Hp0v+CJf3d3QD2Zok6JG0W8lQ4JJGxn/6Bf8Nk4kc5gtLIc+pbl2GqM51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q73OzPGU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q73OzPGU"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa64f3c5a05so244196866b.3
        for <linux-sparse@vger.kernel.org>; Sun, 08 Dec 2024 11:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733685086; x=1734289886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjK1bZri5pPYXLEPg3pfsInYn2WFK+u61JXJym8gukc=;
        b=Q73OzPGUW2IZbQ4c/NOaGh1at1E2d6jHmuSoAki+Ru22+4fDrcAO+h3bInx6pfanTJ
         iC4qAQDpRCoatBYCKgC6OPtabq8ynm20w71OA0/XsNXIgZi4+XQgQSn8UTAh4V3jXWb4
         xuI3tLwMswER+UcVFbApPZ+lNLDpVer14pB+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733685086; x=1734289886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjK1bZri5pPYXLEPg3pfsInYn2WFK+u61JXJym8gukc=;
        b=jsNb6OPmNPNyDU1oqt5uFgxGj/5Kp40N4hmzk9bhshron9yrRCH7NB6elvlqC8rmB/
         CHMZkHMzpFC0FZTXmkCHocPq/TLudwRUUC28N3X6fKdSAk8MeQgEjKxKJ2w6vyrEHb4K
         xd3Tqe01yYvhBl5r87C2ndlbXgZ2I3bgJiYvRIv7ffmR1LKJh/a011NdramRCc3WQBCj
         2lZrGbm9FxqUYPOBDgF4LjuaPRXr7/j4lxhC6whtK1DNiA3dz2BOopUHWNvLXWbrCAlf
         QKrv/pmkEL7GmGmJfMfneabTGJSbcF4bR1rRRqeJN6R0TOctR7GekJlkfdNfgMNG6xdP
         +M2w==
X-Forwarded-Encrypted: i=1; AJvYcCVrvcCatj+9nEwzV9KdbSjAkiZ+pxNZx7780xDf5loQgyBTH/3X9rok08hWFQWkHH+IDPAcEobUTW/WdGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc10I/MODau/LcyWIjsY/60fMHQsHpiMskJLABohq6TYB5A7cW
	YY9gNAoXgk0ClVQolDqP63ToOt/o2mCWIq7Ulwkz34qBpPrYJ9keYE38qn0FGtfpAZkzjQCXhoD
	dR0FIHg==
X-Gm-Gg: ASbGncvZybfimmRo2aZ/eq3deHsWtngDM+rmC1ti+H40PNpuctYrDR2aBrn2zQjX6YE
	OLQ2fEYcjasccYDA902vJTyVSZwoMdg+2caIGGltbLOxYL7SL8viEK//xn38Fs9DLmUhXyIHdEd
	0ZDOr9R81v3oOTZ8tfWAlKleWsfhOWnB7J1dqQpj3GIeMagU3pFD7gAuY37XHCtp7dyxMU9ZvoL
	VnkfX37XhBJLuVHLhfnwAUkNGjj/vXo9WbcUe/9hqyQ1sIa93EWl6/O/Eqz53VYOFPdovBSIsB4
	Va6KlBLPO/JD6BctUXUQ53P7
X-Google-Smtp-Source: AGHT+IF1JjNHq4etxsa2RVwRU8nmMFkkSW+BTWjgBIguCScq0Y7vey6fbuQ32wX5XAIZ+0uOgLr37Q==
X-Received: by 2002:a17:907:784f:b0:aa6:7bc1:ba16 with SMTP id a640c23a62f3a-aa67bc1baabmr302221866b.29.1733685086242;
        Sun, 08 Dec 2024 11:11:26 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa685669acesm58426766b.189.2024.12.08.11.11.25
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 11:11:25 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ec267b879so707389666b.2
        for <linux-sparse@vger.kernel.org>; Sun, 08 Dec 2024 11:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCinxur0raYv6HRB+qi54Um8AWYQVdhNL9bw3p0dVwMFa7F77DNXG9P1DEKJKyxi4yobNeeWKAOXsiUFc=@vger.kernel.org
X-Received: by 2002:a17:906:8a53:b0:aa5:4d96:ec7 with SMTP id
 a640c23a62f3a-aa63a21bf90mr809950866b.44.1733684751478; Sun, 08 Dec 2024
 11:05:51 -0800 (PST)
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
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de> <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
 <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de> <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
 <9d9567dbdaf39688bbd0d240e29dec826a5931ee.camel@gwdg.de> <b71056c1b9e04aa383f2e5608c27290f@AcuMS.aculab.com>
 <6658618490381cf5ec35edbb66f1478024174e67.camel@gwdg.de> <e71fffb7ff0e4bf29692d006c0fe77c2@AcuMS.aculab.com>
 <87dd9b7b52e7cea874c1899f56efdd3d7c5b7243.camel@gwdg.de>
In-Reply-To: <87dd9b7b52e7cea874c1899f56efdd3d7c5b7243.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 8 Dec 2024 11:05:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+_6eQnLWm-kihFxJo1_EmyLSGruKVGzuRUwACE=osrA@mail.gmail.com>
Message-ID: <CAHk-=wg+_6eQnLWm-kihFxJo1_EmyLSGruKVGzuRUwACE=osrA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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

On Sun, 8 Dec 2024 at 10:11, Martin Uecker <muecker@gwdg.de> wrote:
> >
> > A lot of the 'macro business' for min/max is avoiding unexpected
> > conversion of negative values to very large unsigned ones.
> > And no, -Wsign-compare is spectacularly useless.
>
> This is a different topic, but what would be needed here?

Dan Carpenter actually wrote up some of the issues in:

   https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage=
/

but the basic issue is that -Wsign-compare has over the years been
truly spectacularly bad.

It has literally started out from the completely nonsensical and
incorrect assumption that the types of a comparison have to match in
signedness, and it shows in the name itself, but it also showed in
early implementations.

The very first versions of gcc that did -Wsign-compare literally
complained about code like

     sizeof(x) < 5

because obviously one side is an unsigned 'size_t', and the other side
is a signed 'int'. So comparing the two is clearly invalid, right?

No.

It's obviously *not* invalid, and any compiler that complains about
different signedness of that compare is just complete useless garbage.
It's literally checking two constants against each other, and the
result doesn't depend on the signedness or the silent C implicit type
conversion.

And no, gcc doesn't complain about that particular code any more.
*That* particular problem was I think only visible in a gcc
pre-release that sadly did actually ship as part of a SUSE release, so
we saw it in the wild even if it was never in an official gcc release.

I'm pointing out the history because it's relevant due to explaining
*why* the whole concept of looking at just the type is so broken, and
how the whole background to the warning was broken from the very
beginning. The very name of the warning is a sign of the problem.

Because gcc still *does* complain about entirely valid code, where
"fixing" the warning just means you have to write worse code.

I think Dan's example from the link above is a good one: if

        for (int i =3D 0; i < sizeof(x); i++)

causes a warning, the compiler got things entirely wrong.

And yes, modern gcc very much warns about that:

  t.c:4:27: warning: comparison of integer expressions of different
signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=E2=80=99 [=
-Wsign-compare]
      4 |         for (int i =3D 0; i < sizeof(b); i++)
        |                           ^

So if you want a general-purpose "Warn about dangerous comparisons",
you need to get away from the mindset that it's about different signs.

A compiler needs to do proper value range analysis before warning
about comparing said values. Not just mindlessly say "different types
bad" like some marsupial that has been dropped on its head a few too
many times.

End result: calling it "Warn about sign compare" is a disease. It
shows a lack of understanding of how complex the warning logic needs
to be.

Now, I'm not claiming that our min/max type warnings are great either:
they *do* end up basically being the same silly "just check signs, but
at least don't complain about signed positive constants being used for
unsigned comparisons".

So our min/max macros most definitely are *not* doing that "value
range analysis" that I claim is required for a *general* comparison
thing.

But our min//max macros aren't some general thing. They are very
specific, and so it's a lot easier to accept the not-great-analysis
for those specific cases where we then may have to change types
explicitly or do some other massaging to avoid the warning.

Put another way: a warning that triggers on really basic C absolutely
*must*not* have silly easily triggerable false positives for good and
idiomatic source code.

Such a warning is worse than useless, and gets disabled.

But a warning that is overly restrictive and gives silly false
positives can still be entirely acceptable when the context of that
warning is very limited.

So this is why in the kernel we disable '-Wsign-compare' in the
general case, but *do* basically manually then implement that very
same logic in the very _specific_ case of the min/max() macros.

What is unacceptable nonsense in one case may be acceptable "good
enough" in another. Life is not fair, I'm afraid.

                Linus
