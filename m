Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5641DFE1;
	Sat,  7 Dec 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733581315; cv=none; b=fcnAqFlZaFmLbkGSs0Lm8vaIorbSjYZ4wH9RrnHHueWP05Ppqb2P1WV47mJgPcTpXKnyv1Z2U6FfolTHuDFBsT+LKK7WtjeXBSxP0AEH6eDLnJqmuuvta95SgZxqO4wrNGp/BnOgUU/0GeTXUbxBWlit97jmUUSr0vR/sd52bPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733581315; c=relaxed/simple;
	bh=r7zPRKW+PjxixSGhr3dPnkSnW+fktu4xG/vmEVmcVkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoEZA7/RsOKFJq9laWdQ7NLmwLkdB3YZHDJ4+joDOXcdxJiHnqFNbsH8wriKF0yl69N9WPpxYM3c2kQwcFteUTmqNAjFUGhawx2ah393mTafUTNq3hYzjYBq+pI7x4owcTg0EXmZnhRhxo6ieh2EoBD7P/hpEXaamYXxT9Xhslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gwiP4BfJ; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gwiP4BfJ"
Received: from mail-lj1-f179.google.com ([209.85.208.179])
	by smtp.orange.fr with ESMTPSA
	id JvgrtuN8m3iIjJvgstKW2Z; Sat, 07 Dec 2024 15:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733581310;
	bh=Q1k59tg7g6ZR0AiJKHkbtvAsnBjYlK49uTsKYbfsQyM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=gwiP4BfJB71AFH3NlbdaJwDel7cPzPPXg0vuSj7JZByhSqT+cBvwkzuAYyIk7h4N4
	 05AbkCLcsrKVksURZx4/E3wM4BbsSlLMl+22w5XuTUWdAXi3Sl2XUO0zUVbC7xZ+5M
	 S6Vwtd6VkjvK4aw46/gH66/e/MjTbXNwqHK7/tKWCXt2GEE5AjtYKMela907v/cZP5
	 XXbQed7fwJKaaejBXlI93a44UAazx7dGWUwT49ZI2QiDPsN8SzNXz+sSXi2yB8zlQ0
	 25mh4SD0cvH1SRzKW7k0m9bx3rhJkfXKYeE9BrusuEI5JoSTZOLEKToTMscJepCpPi
	 aXRugyRs8HwLQ==
X-ME-Helo: mail-lj1-f179.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Dec 2024 15:21:50 +0100
X-ME-IP: 209.85.208.179
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3004028c714so6068451fa.2;
        Sat, 07 Dec 2024 06:21:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV87MpYCQwszEpVkgVkcQvfgZzoawDRf0xod9PClB5RnxaSX5vIP86K91CoAdTT/pUDWG2bkvJjhXaliS/3dwk=@vger.kernel.org, AJvYcCW4Z1azu+t6dpwSASzF381kdKgNUMyzF1XJ/5OOaFA7otEetdhFISYTEOlXnyzSx/VbdUuohvjkOl6NxNxA@vger.kernel.org, AJvYcCWOuaxsg9nGrvzsk9Vbg4y7y9qYWFjP5bGA2zOyfZhZ+9giO2Lom6a4e9yO0izlwBVVrCIqCeGA5pAurmXy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6CKhoYOl8dvLiDezDdYSIlhF67n3QdgIu93xWHBzKBEZmX9S
	vcncWUU/JkS1rc3i+tWdTAy8LPkg4kRdGG999btXHvvNPE2VIU5rAYaJa0m4EPWdta/yvVnFAVg
	F28HVftbQK7fDIrNXfQnS952nAjQ=
X-Google-Smtp-Source: AGHT+IHLXgFQhA/c3KQxjVrMyKCAmSqwk42Fqpsfdz6EK+jIFFcEtdXEZClHZQiPmD1jBbv/RGy99L+br5F0PLvN22o=
X-Received: by 2002:a17:907:7392:b0:aa5:427d:b101 with SMTP id
 a640c23a62f3a-aa63a1109camr127306566b.36.1733460187056; Thu, 05 Dec 2024
 20:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-1-4e4cbaecc216@wanadoo.fr>
 <e115a4245e5342a994a7e596cc6357fa@AcuMS.aculab.com> <CAMZ6Rq+n0vG9zObF-kY-Xo+iP_Y3P8A6_nEfB8F=UhqeQBepRw@mail.gmail.com>
 <b48e2f5dd8d64cbab471629ae03c7511@AcuMS.aculab.com>
In-Reply-To: <b48e2f5dd8d64cbab471629ae03c7511@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 13:42:56 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKUH5VGHAuqv+dR_0o1JFTvV_gNV2qUwoMfcWCQUSX2Lg@mail.gmail.com>
Message-ID: <CAMZ6RqKUH5VGHAuqv+dR_0o1JFTvV_gNV2qUwoMfcWCQUSX2Lg@mail.gmail.com>
Subject: Re: [PATCH 01/10] compiler.h: add statically_false()
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

On Fri. 6 Dec. 2024 at 12:39, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 05 December 2024 15:26
> >
> > On Thu. 5 Dec 2024 at 03:30, David Laight <David.Laight@aculab.com> wrote:
> > > From: Vincent Mailhol
> > > > Sent: 02 December 2024 17:33
> > > >
> > > > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > >
> > > > For completion, add statically_false() which is the equivalent of
> > > > statically_true() except that it will return true only if the input is
> > > > known to be false at compile time.
> > >
> > > This is pretty much pointless.
> > > It is just as easy to invert the condition at the call site.
> >
> > To start with, I will argue that:
> >
> >   statically_false(foo)
> >
> > is more pretty than
> >
> >   statically_true(!(foo))
>
> Except that the test is more likely to be:
>         statically_false(x > y)
> and the invert is then
>         statically_true(x <= y)
>
> No different from C itself, there is no 'ifnot (condition) {...}'
> (don't talk to me about perl...)

No need to talk about perl, just staying in C, it has both the #ifdef
and the #ifndef directives (and since C23, it even has the #elifndef).

Regardless, this was just a nitpick. You convinced me, I will remove
both statically_false() and is_const_false() in v2.

> I suspect you need to pretty much remove all the comments that
> cross-refer to statically_true() from the other patches.
>
> So is_const_true() is just 'return true if the expression
> is a 'non-zero constant integer expression'.

No. Linus made it clear in

  https://lore.kernel.org/all/CAHk-=wh5SNYdgx8-X+ggHP+ojbG2F7oyt3TLmMgqejYd5zn0Aw@mail.gmail.com/

that we need an explanation of why statically_true() may not work in
some contexts and I agree with this.

As far as I like using proper nuances between the terms 'integer
constant expression' and 'compile time constant', treating
statically_true() and is_const_true() as completely different things
as you are suggesting is not constructive. At the end, what matters
the most in a comment, is that the final user properly understands how
to use the thing correctly.

Removing the cross reference would increase the risk of people using
is_const_true() in places where it is not needed. I will keep the
cross reference to statically_true().


Yours sincerely,
Vincent Mailhol
