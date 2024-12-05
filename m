Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A82206A5;
	Fri,  6 Dec 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508215; cv=none; b=asBeNJaD3nmUAmHn9zGIdXdlvLfb7bTXfVEqopeq3JWpthUhOKVpg+fxUUl6OWox6/OBUKdb2jYnPANcCkVSlVPDrmF2TEHIQTrrBxmv0Bbv5te1K8JpGrgiy9ZJzDZYwiv3oeEHY6lLI8yjVMmJjD+mJonO87vV2Etvbzuy8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508215; c=relaxed/simple;
	bh=NZeAZdy0kgd/dGmfPWI7u/7Zhfjo+XjptjUslO06J9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV6nW5UHDUifLMBR3OgLwiowL0/0h3PhHL4dCFdG64/Sx9iA1kNbHfqXE4t90sBD7vCQeQoZgzuz2FndAjlNfJrUYMFtEVjPqPrlTHinKWK3iXXx4l5CmZ7/2cqLbv8syukZKH4/yr5u+Tq6iBbaGqjuy/c1GBxeR8rOAulNSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YCQCq662; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YCQCq662"
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by smtp.orange.fr with ESMTPSA
	id JcfntEXK6e9OfJcfntbkT0; Fri, 06 Dec 2024 19:03:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733508207;
	bh=fohnIjaGXi4erexWkQR0Ki8fkQHzJ2JQlgx+0ILcUhI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=YCQCq662pdnFysbh0EGT79rxoiTNBao7eWDodm4DbyarUJOOW/Oq5R8vlGEUlTGWg
	 GJvUzXM2+vwIrsAQs/whADbZ715Y/lJ4eQfkdpexzgVq4omEU8GdgLJH8rLIJ1tLXZ
	 tPv9zKtRHOfWLiWN4yqBJy31WxZPrgMqR7cKn3TDqjYc/0uNe64TSQgC+xaRnD+SHj
	 1iZ4ixFPOloeuK2pcL62uFc2zMlHwIpruW7q6CiVWk7hZvmBZJQT8BDFHCkDqu59TI
	 D1YLsbIQXHdQmX7ZMp96BSDPAAdOQ+stwh8pRK9St7nLkMtN32jbT0pqITbBT6YUu8
	 tVZGBwcKGBOGQ==
X-ME-Helo: mail-ej1-f41.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 19:03:27 +0100
X-ME-IP: 209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so329715766b.3;
        Fri, 06 Dec 2024 10:03:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWt3OfrAJKxDha9UL7vBANM5DT9vxkANTZSz6R+fy+wwasMzS984cRdSrMaf/e9GSmPtKuyYle/Ef+YRltH@vger.kernel.org, AJvYcCX4kRyVfSDvCq8tRHyjhpgdGmTq2vhrXUYeIH5q+zSzZ0oUBVJ+9ElXC5YkQR5ra4HIqWtHF1mgXS6vc5YzbVI=@vger.kernel.org, AJvYcCXaaux7tfs22+2+oujXkD3UamvMiYaSALBk1KPb1hp0I/ERaCl3eFIAr79NoKkuYVlp4MIbx6Iqc8cmLWvE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5tH3Nclzj7EwEeJAZpHBRu/TrwMaDrDdZ+BU9xerjjrM7UyJ
	hRC0nw20XoSsuNeXqlASDn3bezM3oEDoMFLI32XzRwwuTL5s0N8ZMWDDwPE9IdRAhZPn9SlfN0P
	CcPQRjVIybsyn60vAxzMVJAdwqEc=
X-Google-Smtp-Source: AGHT+IF7fNOJRtWBE8J5EkTB8RHD/J+PNwJHWESTQDWwz7k7Xwis6ssZjGPrSAnluvbW+xerUjreaR05tr055MdLvCI=
X-Received: by 2002:a05:6000:1a88:b0:385:df73:2f42 with SMTP id
 ffacd0b85a97d-385fd3f2e65mr9440939f8f.32.1733412345020; Thu, 05 Dec 2024
 07:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-1-4e4cbaecc216@wanadoo.fr> <e115a4245e5342a994a7e596cc6357fa@AcuMS.aculab.com>
In-Reply-To: <e115a4245e5342a994a7e596cc6357fa@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 00:25:34 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+n0vG9zObF-kY-Xo+iP_Y3P8A6_nEfB8F=UhqeQBepRw@mail.gmail.com>
Message-ID: <CAMZ6Rq+n0vG9zObF-kY-Xo+iP_Y3P8A6_nEfB8F=UhqeQBepRw@mail.gmail.com>
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

On Thu. 5 Dec 2024 at 03:30, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 02 December 2024 17:33
> >
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > For completion, add statically_false() which is the equivalent of
> > statically_true() except that it will return true only if the input is
> > known to be false at compile time.
>
> This is pretty much pointless.
> It is just as easy to invert the condition at the call site.

To start with, I will argue that:

  statically_false(foo)

is more pretty than

  statically_true(!(foo))

In addition, the simple negation !(foo) only works if foo is a
boolean. If it is an integer, you would get the -Wint-in-bool-context
warning. Thus you would have to write:

  statically_true((foo) == 0)

Anyone using this in a global header basically does not know what type
of argument they are getting. So, the (foo) == 0 trick is a must. But
because it is ugly, better to encapsulate it once for all. The
statically_false() is just cleaner and less error prone.

That said, I am not strongly opposed to removing statically_false(),
but in that case, I would also remove is_const_false(). For me, these
come as a pair, either we have both or we have none. Only having one
of these looked unbalanced.


Yours sincerely,
Vincent Mailhol
