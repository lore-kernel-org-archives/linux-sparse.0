Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D421D0E36
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870613; cv=none; b=GBHcXvRz/G/UgN+yVU/Z5alc503jwqrjzFvPKT8ixg/ZYqKvVRqTUT74dDWes8ZYL5sIH4vczWXotuuWwnXf01Ybcy26YWNSJ+PlTxvsCsg2n8ZkgM8nYcDDoWmeNUlNI0p778DnVE0vkwwk4LiGZt4UYEvE4pF1TXSK00GqgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870613; c=relaxed/simple;
	bh=rKZSQWVvGhg4raZdqqnEYVcbbk/2GmORPysBvFpPh/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9uiKzIVii0feR1UFM1BkrjergEDNyVZTnVz+BtFuZBvpCT/eFFwLHpPj5qab3CLUONEHcrv95/YfNa9AwRX4JdnBgCcyVZBbo4yEjpoYYyEeEGIvskZLf6h8nKbEQBk97xl0I15mQjcP653UX13apsMLFj1OJaU8laRa+vkSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=baIgCviD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="baIgCviD"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso4921662a12.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 11:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731870609; x=1732475409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yTq39KpSi/XOcjYMPkfmcPZj5cLER0PBeGZUoAkDQbU=;
        b=baIgCviDGngvEErUPTSeLANqyNK3/+Bva3KBDnml6h6QcRAvGCkBvXWwMS4ShnSEL2
         TtPI23q9h0D/eHreOpMRDM6rJ97JX8hRU0JliFBmJZccO1Qh+AL71lfQqLb769ktdii2
         3/9AUQlkXqXuOAvodoHdXKEpmkF5zsg8zrYFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731870609; x=1732475409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTq39KpSi/XOcjYMPkfmcPZj5cLER0PBeGZUoAkDQbU=;
        b=wcmLMp+xSOSZm0xF0ZFx8PD1wUnQJX3Vp7Wf4uJhQZCOmhcNzcP4izBq756t2uRJ0+
         624XZ/ypn786U5dSNxvpKlVkvlMZ8rBtbMEbQZnjrZN3QktTNY/iwN5U19k3y8hyQyNu
         7nXU+cj5cTU1Jd+m1TDuPxuKwpRsWk9I0fgkCK2wU4cfDENRn42aKecfaPv3uOTbp+7T
         BZAXtuDb60RXXQmzEhkHQGxLknFisPBcH+Odh+OUHkylwK+hOdkrsktOtV/TpuEqLGmq
         BDNz+uGSneqMOTl871D5uvrUrO9j6MHndevhki2wU3n9/3XYjPqB+kW+kRKkcv60uJvT
         maAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6drHLKjxUyORTa7voAZdvGqMxoHQ1t3HKUYD9GwxvAbWdLagts82moU4lGAU9EhCxydezlSDFYDP6miw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8tvDxsaajJKhqMVmbUBwtSyLX6W//Yzt2W6cvd36Wms7WjRF
	qvPeygQs8UwMMGPdUmSIcGRNcsfC2z458lX3Z41PtNhQwQtL1irhG8HwnZ6AANawHiP3DKjQF/U
	vyd6trA==
X-Google-Smtp-Source: AGHT+IESjMfB0nRqpuEfkIxWjIt4KpYgQM+vnioPBdBqdCBkmm4PPx7/Vm2uG5wk5z+AHy2eZuDDFA==
X-Received: by 2002:a05:6402:348d:b0:5cf:a759:b27b with SMTP id 4fb4d7f45d1cf-5cfa759c16bmr4203543a12.33.1731870609039;
        Sun, 17 Nov 2024 11:10:09 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26b8fsm452158766b.25.2024.11.17.11.10.07
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 11:10:08 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so595967866b.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 11:10:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgH70kyC2BIzxK6Kxs41iFqMuTwy5eXUYNXArmLw3laDQT80ZEcsicBQz6ILYYZwQZoY+w14kiBlPG+3I=@vger.kernel.org
X-Received: by 2002:a17:907:a4e:b0:a99:c9a4:a4d5 with SMTP id
 a640c23a62f3a-aa483482762mr901553266b.29.1731870607652; Sun, 17 Nov 2024
 11:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com> <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
In-Reply-To: <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 11:09:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
Message-ID: <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 11:05, David Laight <David.Laight@aculab.com> wrote:
>
> I think everything can be built on a base if_const_zero(x, if_z, if_nz)
> #define const_true(x) if_const_zero(!(x), 1, 0)
> #define is_constexpr(x) if_const_zero((x) * 0), 1, 0)
> which gives a bit more flexibility.

The is_constexpr() should probably be if_const_zero(0*!(x)),1,0) to be
ok with pointers and with "long long" constants.

And the "1,0" arguments should have a real reason for existing. I'm
not entirely convinced any other cases make much sense.

           Linus
