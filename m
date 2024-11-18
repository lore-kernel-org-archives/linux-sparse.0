Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6420322;
	Mon, 18 Nov 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892497; cv=none; b=J9+uCjR3q4+A+Cplc7cEziriIU/K2YxAJB6wxtV/6PKKWt/vTHq0JhgzN4rQkUwMo0Z50U6QSlFUt2w6QDPAx7kGziFpc2et+CLcFl2U6jmnDMym9O5Tqc0xen82FpDNFymBGT9tugt1cI68iuU3sxLX0hz92NQ32ULUgkb3Hl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892497; c=relaxed/simple;
	bh=HWCsUhpHDgwWC8g6ua6DorxLt16W8NnJfN6BZYQS3wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xpou+kJj/JJ7lmWX99L3H0vzEh3Nt2lTaqDYQxEzp42i/U8Sr4PRmi1H2zD2GOgb4EBk8RCVmABIw05hBMKus1vwJMmPGo8tqmx6c3WdebdtTm/PQVVDgommd7QglhHjb0fwnHxtYTPdssf98wppuVOrflNXWUUlkvXVNKW28eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YiwdVwu5; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YiwdVwu5"
Received: from mail-ej1-f43.google.com ([209.85.218.43])
	by smtp.orange.fr with ESMTPSA
	id CqLltb6R1t7pwCqLltFMAi; Mon, 18 Nov 2024 02:14:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731892485;
	bh=5EWXBlUu5q5BB5RerBonB4WBVQK2DymyLKEc60KRR6Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=YiwdVwu5qneVTcxE/QWSdtQTjvyMLSiJOGhcgt0uiZwymHYbXGv7h46jUJzQGjC7I
	 YTdgeTsdFYa5MohoNeUyGeBf9AcdseVxfwodTFgJnlNpQivqMm43QsJxCAT2OmN8ET
	 Re55OQT+THX1O3ayqlAwXwmVmG9NhvTdaUl3GRCFFJjxP9dAeN7alSki/mWVX+78sh
	 8KYLE6+gTgnUh4hHCs8yDbKbB2CUhN+gInOYLbXKGamP8TkVS4qHz2QFSmtgDCbwy0
	 4RRKVB1M5ts7lF6jzgSC10kw+5wN46mNb5JdpTxXyZlMFk8Gb1c7+6zDn6tb22Upzg
	 jswFutc6YbWjw==
X-ME-Helo: mail-ej1-f43.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Nov 2024 02:14:45 +0100
X-ME-IP: 209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f646ff1bso563893466b.2;
        Sun, 17 Nov 2024 17:14:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe2A9RxveQEahSB67S+bHEge4NI4uio417CoNO5fwUNDD5ey6NhFuX7BeVcmJqFH+1BkY5eJEJt4ZXU/o=@vger.kernel.org, AJvYcCXeszYDEYyL+664dz1t7gNrPXtCzR7iuLCwN7fFiyEEysXNbL29fsmAXKZcEj+jH92Lqiq31pKFMr7rCdNm@vger.kernel.org
X-Gm-Message-State: AOJu0YytRK8x6tCfk3FGg5q82ctW4FVv/b5jBoQ/jFVPPn4mYvkpbXPP
	uQgqwMZ7/9sn/ACDu9FZZd6FwHVmjJIDN+3oY7uwZPUWXDdOOa4XI8vJTNIc2BuZv1qjIO/OZCx
	Wxfr+KAW895fXI5E6U9sTf28okJs=
X-Google-Smtp-Source: AGHT+IFxLXimI3zJLX8n92Ypx5/5vhRGW8wOjcu/xvcEwYo4fR29uj4cq887t3sAQrSeYP0wy5wul4J4KJAX1ByYzWY=
X-Received: by 2002:a17:906:f903:b0:aa4:a3be:28f5 with SMTP id
 a640c23a62f3a-aa4a3be2a67mr381142766b.50.1731892485361; Sun, 17 Nov 2024
 17:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-6-mailhol.vincent@wanadoo.fr> <8bf9eb4434104a3b960d52bd1d38caea@AcuMS.aculab.com>
 <f5692429eb4b43738f562e5fc402ead2@AcuMS.aculab.com>
In-Reply-To: <f5692429eb4b43738f562e5fc402ead2@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Mon, 18 Nov 2024 10:14:34 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJzULnu4X=FB6xQpEm034QUtn6kiSX-P0_JQW1JBMABaA@mail.gmail.com>
Message-ID: <CAMZ6RqJzULnu4X=FB6xQpEm034QUtn6kiSX-P0_JQW1JBMABaA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon. 18 Nov. 2024 at 04:45, David Laight <David.Laight@aculab.com> wrote:
> From: David Laight
> > Sent: 17 November 2024 17:25
> >
> > From: Vincent Mailhol
> > > Sent: 13 November 2024 17:19
> > >
> > > In GENMASK_INPUT_CHECK(),
> > >
> > >   __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)
> > >
> > > is the exact expansion of:
> > >
> > >   const_true((l) > (h))
> > >
> > > Apply const_true() to simplify GENMASK_INPUT_CHECK().
> >
> > Wouldn't statically_true() give better coverage ?

Yes, it would.

> > I wouldn't have though that GENMASK() got used anywhere where a constant
> > integer expression was needed.

It is used in many places, including some inline functions such as bitmap_set():

  https://elixir.bootlin.com/linux/v6.11/source/include/linux/bitmap.h#L469

where the input is not an integer constant expression (thus preventing
the use of statically_true()).

> If it is, maybe add a GENMASK_CONST() that uses BUILD_BUG_ON_ZERO_MSG()
> (recently proposed) and so validates that the values are constants.
> And then use statically_true() in the normal case to pick up more errors.

The issue if you introduce GENMASK_CONST() is that there is no gain.

The only advantage of const_true(x) is that it works on cases where
statically_true(x) would cause a compilation error. But for
statically_true(x) to cause a compilation error, x has to be a non
constant expression. And if x is non constant, then const_true(x)
returns false.

Regardless, considering the number of times where GENMASK() is used
with integer literals, I do not think it would be worth it to replace
all of these with GENMASK_CONST() tree wide.

Trying to go in your direction, we already have two genmasks:

   - GENMASK(): which uses GENMASK_INPUT_CHECK()

  - __GENMASK(): no check, used in uapi

What would make more sense to me would be to:

  1. replace const_true() by statically_true() in GENMASK_INPUT_CHECK()

  2. replace all the instances where GENMASK() breaks compilation with
     __GENMASK()

But this idea was already proposed in the past and was rejected here:

  https://lore.kernel.org/lkml/YJm5Dpo+RspbAtye@rikard/

> (Or just remove the check because coders really aren't that stupid!)

I think that this check exists in the first place *because* such a
mistake was made in the past.

> The interesting cases are the ones using variables.
> And they'd need run-time checks of some form.

Then, instead of introducing GENMASK_CONST(), maybe introduce
GENMASK_NON_CONST()? But then, the number of instances in which
GENMASK() is used with something other than literal integers is pretty
rare. So probably not worth it.


Yours sincerely,
Vincent Mailhol
