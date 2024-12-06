Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055522315
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465698; cv=none; b=VLlrkBWyYb5CMtdGGWdS8YD7jZ9/K/ZOrXQ4RHwopNqXKpuD16//S/G73B4+XMJ7Oje8JRTAk6DjUgK+jH7z3fvJeZji2pyh1M25A716qFYO1YnO2ffvczsXlTRr/euScnx0F/ZlVjd3am7NPn023JoDnhlNYJa84vpa0pqdTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465698; c=relaxed/simple;
	bh=z6hEp8csz74EZNAx+MsdQ8oAglzBDLPIjblM5QboFag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7Xs4stZSyEwi3XwGMY6YoZskRvMR/GNAYfjrDYxz35IVc14krHGv1chzCyAP/Ce5XjECMVP0M3gBPT417YqVu7JRrQhj3RSfNch687dcf38xsNFDJ058L0F4Aivu/dhax+QRinP88FrfZ5R1tqhWYuNODVXxeC3F5098cRpMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iBe6nH2w; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iBe6nH2w"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e44654ae3so267588066b.1
        for <linux-sparse@vger.kernel.org>; Thu, 05 Dec 2024 22:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733465695; x=1734070495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkINBrTDhyE0tcSEzrQhWY00f3rEWU+OMRPtBhc6Jxo=;
        b=iBe6nH2w89cSp3aP2k3OYrT6xXL5JPt1el06Xg/9HqC+GTF9IqJdo5G/D9u99Qx5Jz
         0mdnk3MoLYl3wrM8xWsRx0FICd80XvU1okN+cYgRVY8Ef7ISWofNRSahiLM8gUkLODH2
         lwlseVwRPnD6l5sIXHhjyZFoB4/0BRNfIG7d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733465695; x=1734070495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkINBrTDhyE0tcSEzrQhWY00f3rEWU+OMRPtBhc6Jxo=;
        b=LHUtC/b4HsDI11Bk6NkTIX7Vd19R3/0hISul3lm1EpB14cvF1iaTJlfFJkCC2RqfEP
         z9Dqk0VTHiVZ9TB+3T5XM+eawGn9q28MtatwTKaYU/171yw/rnBYkkmK8f2xcKr1GXIq
         rIyUWCeIakRdSDCXSOqqWsRaHiKH8gTcaN8uCombFEz4iPrs1lL81dFUfyjENP0D/omE
         a00BwBuVIBnVkQjbCamQ43f8cq8/LkoZ82/3V3MxUXFNcPYBSSUqrIpPFi7ZWK46UY7k
         d+im0tNU+CF8X4dEVejt/bWHEKsQYmsGDV5+kzlfRH1fpv9wIVvGYAPaD88WcSsndIKi
         sv8A==
X-Forwarded-Encrypted: i=1; AJvYcCUfaQgaKxr8iSgHFHRorDLhkkSOJnPvd/metD4/cKAZuV1yrMRx2YOwhjo4gWVnzQB+Ksq0TilKYdCuyc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/2hLRh9ccM+7uQ2cboyXnOpdeJm3eQx1wzStbtBVBa+kE8rX
	sgs7uN4/GSMZKW4WcnMgwwvY0y4/B93YZIhXSVl3Kwqu+soD2e1iKnvO4Mw0apfSr/WvMZKHOn0
	nIaMzYA==
X-Gm-Gg: ASbGncsYjeohqgOvWUvntnRxPpCsRmicgelZXe3LtYm+pbiAzwbFqwi+LcM9iu44rxK
	vQV9jL65jxuXXbAS8potF2eFjyygz2WE/xl+EhpOcyU/G1P5HfwbB9zftUgxUteeqnpGt69W1wl
	/xMJW5R29YET/YWxbVDf4KaKya5HjnKkjmgkkDbNcS9W+Af1KnToSGuDWAxZmvaE3zFLydGw7sb
	M+gMKkjCNQoY5PPa3Rnj5xzdQFw5H/fdDGddxKGEF7t/ohaCIxGYDxlEZHcxFEr2IcmKdptyIq5
	Z3AcSY8AmBu6s1b26nVGuFsf
X-Google-Smtp-Source: AGHT+IEXWJH2ixJkuEniyKYymK9KoMwSBbJnRPTk/tRFsmn6Fyd5UjUOgYPac87Y5ne0QxZobvmVPA==
X-Received: by 2002:a17:906:9d1:b0:aa6:25d2:c99e with SMTP id a640c23a62f3a-aa639fb34d4mr131137666b.5.1733465695264;
        Thu, 05 Dec 2024 22:14:55 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58dffsm186413266b.13.2024.12.05.22.14.52
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 22:14:52 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so267582366b.1
        for <linux-sparse@vger.kernel.org>; Thu, 05 Dec 2024 22:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfkm1Tc/W7rTruR2eC71GSjwhO3V1lty2ECoutgxnsbjcxWL5jSJnXuOoe4RYaymlkJYTtLe9tbL36JtM=@vger.kernel.org
X-Received: by 2002:a17:906:1db1:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aa63de7f394mr66959966b.37.1733465692215; Thu, 05 Dec 2024
 22:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
In-Reply-To: <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 22:14:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
Message-ID: <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Martin Uecker <muecker@gwdg.de>, 
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

On Thu, 5 Dec 2024 at 18:26, David Laight <David.Laight@aculab.com> wrote:
>
> From: Vincent Mailhol
> > ACK. Would adding a suggested--by Linus tag solve your concern?

I'm genberally the one person who doesn't need any more credit ;)

> I actually suspect the first patches to change __is_constexpr() to
> use _Generic were from myself.

Yes. And David was also I think the one who suggested something else
than "!!" originally too.

I may have liked "!!" for being very idiomatic and traditional C, but
there were those pesky compilers that warn about "integer in bool
context" or whatever the annoying warning was when then doing the
"multiply by zero" to turn a constant expression into a constant zero
expression.

So that

  #define is_const(x) __is_const_zero(0 * (x))

causes issues when 'x' is not an integer expression (think
"is_const(NULL)" or "is_const(1 == 2)".

Side note: I think "(x) == 0" will make sparse unhappy when 'x' is a
pointer, because it results that horrid "use integer zero as NULL
without a cast" thing when the plain zero gets implicitly cast to a
pointer. Which is a really nasty and broken C pattern and should never
have been silent.

I think David suggested using ((x)?0:0) at some point. Silly
nonsensical and complex expression, but maybe that finally gets rid of
all the warnings:

     #define is_const(x) __is_const_zero((x)?0:0)

might work regardless of the type of 'x'.

Or does that trigger some odd case too?

            Linus
