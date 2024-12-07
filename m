Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBF153BC1
	for <linux-sparse@vger.kernel.org>; Sat,  7 Dec 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603493; cv=none; b=ZJTzWKz1unEFLRcXEB1kDW8LY3IMHCZ3qEGOE+xLET0rsojvP1kHWEEMas75oYrfStQTREB9Ffak4iwcU332dukDCtvbrsHJBSexUIaLwIVrElpuQhO++rISqalvwIo7pH4llK3FtNvYh8VTuKjN1ZxALZP37I8BcsbWig46JZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603493; c=relaxed/simple;
	bh=ct+vM4e0Jtr5aDgyp/mMMW/kc2rgYH8fWmf1syFBJE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2HXNrU/MlAJS6XNLlanVBWARssm1qLy0q9s9ULhamPiHljzBdWTrMp8sRoperXNj5/FvQH6XUJxylHf+cllas1LALV1+/+rDKXYTvghDEVuszXuw/yIIL14z3f52cjIC/LXuEWiexaAGc0wnPszpbgv575AU2y7PcZnAh93O2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DuyFI92e; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DuyFI92e"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e3621518so2342855f8f.1
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 12:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733603489; x=1734208289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ms7Dj4PhpQjQO3I96MAeIgwapri0gFHpEAP0IFi7Ea0=;
        b=DuyFI92eDeTCXhqeWVS/qaWoHPuO6YnBptBEbbQZU0VVLNNfeKvGTrhRIEbzoE2VgB
         VoKKfYd5jSquUzbOpyCg9+FV35lzHb0vzVGOijHKO/Wf2QrxkgiwgeA9bKEUOB7ghdrk
         WN/wp062TQeOniyMzZULDOrQcid6zeMI2s4CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733603489; x=1734208289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms7Dj4PhpQjQO3I96MAeIgwapri0gFHpEAP0IFi7Ea0=;
        b=Z58YosJPuNj6BdCiIPH4CsUqfW5F1Pi1K2ZIUnoU3NNwknzdrd+AqfxA1iHGjE1ygU
         xYLUAyiAHIEL2HRKdnd0a9ji2WNOt8GBgslDJeWJLOOO2hMQ0gNZNSKcdhKDC9uhvzs1
         yiqPgHvwyPokNF/L6FVIPnEIpGhtMDKLyNY2vSO/NiI/Nr9llbeFpD55fjjN7fRb5AED
         YvIJo6giNE4qt+b4wBbeM4/kGrF3vVNRNcvQ/uyHpaQVTFPyFhUcFhdGl9dqqJNUdjrN
         2zIBbb5Wy83hkEyztqYEj/s6NuJTrfKwD4teF1iPTCd2u8A0tnXiqiegG3Jw3ZQ0Tr7n
         AoZg==
X-Forwarded-Encrypted: i=1; AJvYcCUWIXSv+jC3raF26FH0+/8UZ00qSInsRj6EuMd5B0/SVpNulOJvsZadPEXxiCSyFQJv/P7M/tWYI52BDGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJrSsjOhpCa3xjxcdXsCEAOrrYqNs5vr1zpFI2hf0ttKLXg6x
	uk6S+J7YtlHNrrUV7QPcf1wQn9F8yWT7ids4isN26VIvvi8FTMohyjNsqUf0WTTlhTDAMo7Ld22
	SX0Fbaw==
X-Gm-Gg: ASbGncu1FEbeUUN7B/lsx56Y/mCMkvBd5OWCDUW8WzmctL1Ai0Nxi5OOM9LXAiKEE/N
	M5j06PhGVVV6ePJmINNJaTeXDU1TSRfnxY4TkKGUmx6gSVOkROB6Z3eDBz9f4PGpHWuw9xPChst
	lTR7dKV05qxpIXfhoHkN99qZhAIY0dCDyMsqHuEu+jadFT8DI42dhHTkb8//+EkWADrDAY5x8I0
	wkHurBh5is9KRHaeM7rf3HPIWMx1nIU2K9LjHOUXkOQ97roBk79uK6Fz+2owDGR6UpRBcxS61yD
	uULg/uPLV26oqE8FCe+Aolvq
X-Google-Smtp-Source: AGHT+IE3a1NX0eSqyzYpRZO6LPHoDW13jLyotkHwTDs0/cHdIMq0f73EgzHTqLONVYAthxTbmc56FQ==
X-Received: by 2002:a05:6000:1565:b0:385:f470:c2e1 with SMTP id ffacd0b85a97d-3862b33e519mr5083518f8f.2.1733603489188;
        Sat, 07 Dec 2024 12:31:29 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b132sm429169666b.105.2024.12.07.12.31.26
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 12:31:28 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a68480164so404134166b.3
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 12:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3NooK455nvazsdvyenkJhZ1WdrQhNCSETmqYc+s+yPHfq9qxskIDARQBEDEDnCM84fDw7JQi0gEplWys=@vger.kernel.org
X-Received: by 2002:a17:906:328b:b0:aa6:326a:bcb9 with SMTP id
 a640c23a62f3a-aa63a10fe42mr541173966b.33.1733603485779; Sat, 07 Dec 2024
 12:31:25 -0800 (PST)
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
 <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
 <b1ff4a65594a4d39b2e9b8b44770214e@AcuMS.aculab.com> <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
 <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com> <6b8c9b942ba6e85a3f1e4eef65a9916333502881.camel@gwdg.de>
In-Reply-To: <6b8c9b942ba6e85a3f1e4eef65a9916333502881.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 12:31:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzFAaksqMdYeYC=T82tny1HnGGcYu_xJTXZF1OZwVziQ@mail.gmail.com>
Message-ID: <CAHk-=whzFAaksqMdYeYC=T82tny1HnGGcYu_xJTXZF1OZwVziQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>, David Laight <David.Laight@aculab.com>, 
	"w@1wt.eu" <w@1wt.eu>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
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

On Sat, 7 Dec 2024 at 11:51, Martin Uecker <muecker@gwdg.de> wrote:
>
> Am Samstag, dem 07.12.2024 um 10:19 -0800 schrieb Linus Torvalds:
> >
> > If there is one feature of C I would have liked it is "allow inline
> > functions and statement expressions with constant arguments as
> > constant expressions".
>
> There exist proposals along those lines for C2Y.
>
> From a more near-term solution, I wonder if making it possible (or
> easier) to return integer constant expressions from statement
> expressions and allowing a restricted form of statement expressions
> at file scope would help?

Even a more limited form of this would have been useful several times,
but as mentioned, the problem tends to be that we end up supporting
compilers for many years.

So then we end up having to work with older compilers without that
feature, and can't actually clean stuff up until many years after the
fact.

We're currently still accepting gcc-5.1 as a compiler, although it's
time to look at that and probably (judging by what stable distros use)
upgrade to something like gcc-8.1 as the minimum supported compiler
version.

            Linus
