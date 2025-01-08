Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88B147C9B
	for <linux-sparse@vger.kernel.org>; Wed,  8 Jan 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345994; cv=none; b=mQ6jizVxKi53l0tWyXM9AOvQlFj/SkY74rDmz5GejnRTpPmRcOAJ54zDnBetoIho3FE1GUMy3CQHq0pQHt2v6aK+w4tZpQCdIti9w72XyMXAgkj8DsO+Qrx89looyEK7p578KOmLZTSgujZ5NDMxng/u3picgrgNZpnuuk87gX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345994; c=relaxed/simple;
	bh=ez3+HrLfVutu5Mm5304q+PpzenkT3+5qXxkhnae7xTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajMk6/gG46Mu8pf5jco+Q5a5ERJJ+4wf3fri1mue7+pb5d/iQz4BV8tYkczhskZzcWwHoD4/oTXvEAt/+wmt42H9fKg/hSmnbI3GmjRWcRYK57eQVZh308jWi/kMWqob+wLHnKi8PqmX/jogGHkPpWugPcYn3RfG+O3/tme3rHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4aff78a39e1so4853302137.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jan 2025 06:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345991; x=1736950791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLqxPrKY1TOV+euKVeE/94FdmePkGlHZLqqcrwE2XJg=;
        b=OZhZwvf1hmMpjnseTtzF6sxb1scHO8UQSgY9AjxvGJQP+VfqyWUJqiMpd3equp9vng
         wvX4o0iU10QcGO+myoa0RfiFvI40rgHf9c09MFpxCnZBnMAGEgZeaiyuIhK66dc3FcWh
         g3XrgVMKirovNbfIFBM+R2YHC5EUb65eKuME6SVwelKjPWmm58uvDXOYuZEhEQlu6DRS
         kufJZA69ZQ7R3x8emV+fgYVclWQxkT8bFx3OBmd4evHLlu7kULB8y5yQWy3qs7Pxzhi8
         Aw/CV22OTAcZ6K9bu+LjXC0KJfZQ842CUdjzfvFhTbBZsCqCyDOw8kouPXYUvQOkifBG
         2NUA==
X-Forwarded-Encrypted: i=1; AJvYcCWH7k1TfHt6YkQ2owONbfLNpRfMfU4AdZb6BKCGlHC/Xzyc50leDuZse0ciFkyEysR150EpCgJZDOXZ6vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6dOhAP6vJMHJDL+VCYYEYE/iZdrPKpvp/uTTIapQEV+7YG7W
	0bUYX6cVfycllXHl3sCQBXtBjFtpVsfgg956RZoJyoubPyZ/OQ2H0D21kskL
X-Gm-Gg: ASbGncsFbbRImCDbWhq0np6qsVLNkwyrArnHeqKfnCfSHokSrt/DVIMJWFLZmr97PDp
	6mQ5RF89cUre6A2N8IoKXhOV289gOd/oFk3myB71HTpQo60I8QzvzU5+mngxYD6s/LDhFLJlXpF
	zQe+kIZo030ivAZPJ7cAsi8N3RiO/opTyWvHVS/JkOJfwcf7pFxvbFQB1NP2Emo9PAdfj8ObM8l
	4vbKfNgtG+uB8q1MgTHKdMeaUGxnTKUiRBA6FwXq3zBkUHjXY/i+ZbpfOBgIDtL4Uj/zqSjra26
	1UJf9kPkLRSoni54GGc=
X-Google-Smtp-Source: AGHT+IF7peNoAAB03hsTDwIdUK7z07vSW1VvbpXiAJzVuiopt37X1fyUfu4Fv9/1pDQvM5tsrzuCWA==
X-Received: by 2002:a05:6102:4a98:b0:4b2:5d65:6f0 with SMTP id ada2fe7eead31-4b3d1048269mr2000344137.19.1736345991113;
        Wed, 08 Jan 2025 06:19:51 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf98be8asm8536084137.2.2025.01.08.06.19.50
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 06:19:50 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afe99e5229so4761863137.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jan 2025 06:19:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDav89eqig7g106v8HYGUfGa5PGyTFz9fczPcqLr+J49ucuwehdcs9gkVY4Q7JzvWoG8Lu0k3I/s2TdHY=@vger.kernel.org
X-Received: by 2002:a05:6102:548d:b0:4b2:73f7:5adf with SMTP id
 ada2fe7eead31-4b3d0f947f5mr1699824137.9.1736345990519; Wed, 08 Jan 2025
 06:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501030516.uZrwnuQQ-lkp@intel.com> <CAMuHMdW-DYPp_2nAaBdvgoa6Yr9et2cNS_260H-9H_CT4yEasw@mail.gmail.com>
 <CAHk-=wj4tYCytRshQGkWSNmZS=59PtKEUpG7f4Sy_46n+WYtXw@mail.gmail.com>
In-Reply-To: <CAHk-=wj4tYCytRshQGkWSNmZS=59PtKEUpG7f4Sy_46n+WYtXw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 15:19:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLQ2z=U1YJ18GsnJcej2mwGg02GVtKQLQKr0yNtA-7Hg@mail.gmail.com>
X-Gm-Features: AbW1kvaeBuWDdo2Mkx6lDOn6aHMKd182W90s65hQ52N3Jihquiz5sh0YRuRezHU
Message-ID: <CAMuHMdVLQ2z=U1YJ18GsnJcej2mwGg02GVtKQLQKr0yNtA-7Hg@mail.gmail.com>
Subject: Re: [geert-m68k:master 2/2] lib/muldi3.c:53:28: sparse: sparse: asm
 output is not an lvalue
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Greg Ungerer <gerg@linux-m68k.org>, oe-kbuild-all@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, Jan 5, 2025 at 10:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 3 Jan 2025 at 01:22, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
> > Perhaps this is an issue with sparse?
>
> No, this is just m68k doing disgusting things that happen to work with
> gcc, because gcc considers casts to be lvalues (which in turn is comes
> from some horrid C++ thing, since in C++ casting is a whole magical
> extra complexity).
>
> IOW, this m68k pattern is horrendous, and sparse quite reasonably
> complains about it:
>
>   #define umul_ppmm(w1, w0, u, v) \
>     __asm__ ("mulu%.l %3,%1:%0"                                          =
 \
>              : "=3Dd" ((USItype)(w0)),                                   =
   \
>                "=3Dd" ((USItype)(w1))                                    =
   \
>              : "%0" ((USItype)(u)),                                      =
 \
>                "dmi" ((USItype)(v)))
>
> notice how it has two register outputs (the "=3Dd"), and the destination
> of said output is not a proper lvalue, but a cast expression.
>
> I think you could just remove the cast. Afaik the w0/w1 arguments come fr=
om
>
> #define __umulsidi3(u, v) \
>   ({DIunion __w;                                                        \
>     umul_ppmm (__w.s.high, __w.s.low, u, v);                            \
>     __w.ll; })
>
> and __w.s.high and __w.s.low are from struct DIstruct, which uses
> "SItype". So all the cast does is to change the signedness of the
> variable, but that has no *meaning* when you assign to it and the
> sizes match.
>
> Alternatively, you could just use the right types explicitly and write
> the umul_ppmm() macro something like
>
> #define umul_ppmm(w1, w0, u, v) do {            \
>         USItype __w0, __w1;                     \
>         __asm__ ("mulu%.l %3,%1:%0"             \
>                 : "=3Dd" (__w0)                   \
>                   "=3Dd" (__w1)                   \
>                 : "%0" ((USItype)(u)),          \
>                   "dmi" ((USItype)(v)));        \
>         w0 =3D __w0; w1 =3D __w1; } while (0)
>
> NOTE! UNTESTED! Treat the above as a "something like this, perhaps".

Thank you, using intermediate variables instead of casts for the output
operands gets rid of the lvalue-related sparse warnings.
That leaves us with the "not addressable" sparse error.  Apparently
that goes away by dropping the cast on the last input operand,
so I will introduce intermediate variables for all input operands, too.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
