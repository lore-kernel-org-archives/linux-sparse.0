Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423722756C;
	Mon,  9 Dec 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747550; cv=none; b=ouRPDH/6HblNWCWDCdk33wrIUcJGhI8TkeVY92bGtIlSLH6ILL/fpNXAZwpuQliymuKIC9PscflUFxX57T3yQ1WoOBb5Ub3Foa8qged83A8qWdL/twps5VPaEGlBzbhuDtBMXoqGE53tduqMuLPC0CcBOELJG+9acnMdCDI5SEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747550; c=relaxed/simple;
	bh=kB3RYhKaW5gjZwwRvCZ6UhMhANIepMJBAcWY0Q8JPmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAlR7bzvFjJ5IP1ZVfDKDow+82W88ncpRv1w12XqNyIVAqqBxS+I+ycp+0fY1/8GiI2/O7+GqWMYJCl6wWteqfbdGtzzjZWYOBNgfh5wd46sXUfEcDN80QvC9RuMvTuPHP2ilY/i0EU5coZROjeX1Wpm/I99f9ZB5vS/SwU0jP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emJLQ8hZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emJLQ8hZ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa66c1345caso45816966b.3;
        Mon, 09 Dec 2024 04:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733747545; x=1734352345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HB4h5xGYBYj3eCi9b2ZJAMbBJzOGVJksJuXFxsMtAq8=;
        b=emJLQ8hZf5Kyt3H6k+GTU+pJwMc3TK2wBCVgGf9e0k/sr5DeOZxPZoRh/4kl4x5Dh3
         weTJw/prEVRmoNAzhWFlZpY78tZWcQvkFdQa2Vagr7yBtMCnpLznoPtQVnRazFHfqX5L
         fp9wH2q0wLZbVv2GmqBpKO1CVW7o7uVQMVY81J3GrfaKmcQ5jWLdDW470H9Egl/sAVVJ
         x9V9/OwOnLFIWKlICcqRHFFTpVKGezWO8TehUnHY41xH8u9GZqaIGtwjuI4xClHUA/Qd
         L22aoZ76Wm1QJ7gBz4F8Wynb3bIxwSl7LQBMbi1DwaN0b03VYDqMjV2az2EeGZybGlkS
         9Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747545; x=1734352345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB4h5xGYBYj3eCi9b2ZJAMbBJzOGVJksJuXFxsMtAq8=;
        b=xJgrFjuDqQFFDT/gwahkv4Nj1nh/du8oCf4sS6g7lpzmKLjE8SXc9YyOefZvGIMje/
         s9okoY3l5k5WlQpNI7TMTYsvVl/770Ci3du3Mjr1fuKVMN/Vyrsgdr5PtnC7knlr8thX
         wvPUfjnHos7oZ/9gk66NimUueyy6jOA+qcQdm2n4m4cnRGLhw1mTohnBMpcZRbKVnL5R
         4jUow/DZt4txg7bLQyB30HYxovnrNd5QvovEiBekg24JVwSDKVvrvjZrnyKfHi4tsAj/
         OWstW3N4j4anubRF22zhyAv5CROlukhXwRDmatLE99iFXQL0lX/2YFRyRd3Nlgu3gJ1z
         1qEA==
X-Forwarded-Encrypted: i=1; AJvYcCUAuYbSPbVDHKpZFevzpV8tn2ksdygtjV4qQujXZXTfZmjR8gXV4sOkBEJNla1FNhUUwptZTRefX08WfcKx@vger.kernel.org, AJvYcCXJMnQ8HFkD8ZDgJYitmFtKxe7d2oEDgGl006kxiX4brhAwwDq9VNEY2czpEOy9dvXJhC3OtbLhmgOYO3lr@vger.kernel.org, AJvYcCXuegDRZy5EQ9HfbL8bKQ/I0AEuAtEBThgwbHIz6TC/iHH+KBWH/ZC1vg1+Co6TvGIXLnos6xvcl1mEKlXvsSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlS0s7AdcOlnQoGER7D866ZQ0/Db6l2ixHtaMjPRokpjxVUQMY
	xYptrIMTDULg3V/BxmEHDhqlrhTyi1pqu6Tg/bTE9ELGfcJRw2gaCbhfKtlyM4SiI1h7f4LdttO
	Thcl4lSg5RWGfHb4DgJf4+36sfjs=
X-Gm-Gg: ASbGncvEGY/O7vxGN0Kxo1mmuzGIIJuIQ8sbE9easBb44KnxP8M+A2wqTXoaJlZQ6oe
	U/O5e/60bNGfs/LWFVdnqttjEf/NF0uI=
X-Google-Smtp-Source: AGHT+IFjelp5b6CRvlamva7li7ksyULJr/ZURZRaVo1idystYOkChGCfpprPWdYOncNMp0luUAJecmb6PSVS5WPpxr0=
X-Received: by 2002:a17:906:3145:b0:aa6:7cae:db98 with SMTP id
 a640c23a62f3a-aa67caedcf6mr431164766b.10.1733747545303; Mon, 09 Dec 2024
 04:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-5-4e4cbaecc216@wanadoo.fr>
 <8b8262389bd6484586007d749132346f@AcuMS.aculab.com> <CAMZ6RqJPvbSr5i8N4Dm=2N6D8uSzefCM3TyK8HBNNNrybo5f2Q@mail.gmail.com>
In-Reply-To: <CAMZ6RqJPvbSr5i8N4Dm=2N6D8uSzefCM3TyK8HBNNNrybo5f2Q@mail.gmail.com>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Mon, 9 Dec 2024 21:32:14 +0900
Message-ID: <CAMZ6RqLMXaAej75eXrLgvt-Co1yyEg0QNJSxPovzLzb7vdxmdQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] minmax: simplify __clamp_once() by using is_const_false()
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

On Fri. 6 Dec. 2024 at 00:52, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On Thu. 5 Dec. 2024 at 03:54, David Laight <David.Laight@aculab.com> wrote:
> > From: Vincent Mailhol
> > > Sent: 02 December 2024 17:33
> > >
> > > In __clamp_once(),
> > >
> > >   __builtin_choose_expr(__is_constexpr((lo) > (hi)), (lo) <= (hi), true)
> > >
> > > is equivalent to:
> > >
> > >   !is_const_false((lo) <= (hi))
> > >
> > > Apply is_const_false() to simplify __clamp_once().
> >
> > There is already a patch 'for next' that changes it use BUILD_BUG_ON_MSG()
> > and statically_true().
>
> Found it!
>
>   https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/

I picked up your patch and got two build errors on an allyesconfig.

You already sent a patch for the first one:

  https://lore.kernel.org/all/33893212b1cc4a418cec09aeeed0a9fc@AcuMS.aculab.com/

For the second one, I submitted a patch here:

  https://lore.kernel.org/all/20241209-nfs4state_fix-v1-1-7a66819c60f0@wanadoo.fr/

I will wait for those two to appear in Andrew's mm tree first, and
only then, I will send a v2 (that will be rebased on the mm tree to
get your change).

Meanwhile, I think this series will be on hiatus.


Yours sincerely,
Vincent Mailhol
