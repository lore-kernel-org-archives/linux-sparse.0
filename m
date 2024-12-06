Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41822069F
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512174; cv=none; b=X1Cg+nThkc/tLe3dBDr6ltzhf2CZ5kBEpDfI5Dc/rdTkGzgVWxf8Ca1DG240K7B+Y7OZfwMenY4YUa0TMDmnVAYpwkac8Q+rAYsvR71MX0HQ8xnm1Q70Q+o+VRsEa8z9WNjbUpRPkaT6x2q76AssuPYLoEUhLHIedDG8rMfOZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512174; c=relaxed/simple;
	bh=mpzJOBPMyEgZbeHSaWVVY8PUqVjZS+sd0oYWuGX6RdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHzvyFJds7NabYK+PM9A49AuRp1J549bci6ebJvoC54LU99LLbAsR4i5YNtlo/0vitCVpXN5aitlSobckW78uOqc6GyHNULigsmrc329PZCatcl/WfUhHkp8pElykXsZnVkoZWM4oD9100FCR2NR3Nq9+UcPMLOLeqWHLnOAKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PFl53lwi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PFl53lwi"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30033e07ef3so8052401fa.0
        for <linux-sparse@vger.kernel.org>; Fri, 06 Dec 2024 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733512170; x=1734116970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CnspTgT+QlMaq72RnxBUxeYja+eFoihpXPIoDsPSZVk=;
        b=PFl53lwidrQIy4pg/s8D9BKlYxnrQcaLs39eoSOQVSJe5XDO1ROdtxTdkA1B0U+FsU
         HqkBMrauqB4qvL3aoD9fgwDH8pVgMcxreHHSyTqw6buSx1X9eUSk/bh85MeLNBPT8m8K
         LOXWbUxlJnijXN8Rpw62aZOgTYg6kvg9TnGjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512170; x=1734116970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnspTgT+QlMaq72RnxBUxeYja+eFoihpXPIoDsPSZVk=;
        b=MO9AKn8Z4XA8IFj/S+YZC5CQalt8Iwq9lPwhvJ0EYbSyqQ6yFn0oYI8bScKfU7GLS0
         wclPJmiYKwCB7K63UFzgMeAbXsFPrl8AYMSLJPlthGX91jZHzP+xW+e73ttvlxKc/F49
         q0+xEfvNVU9LO0VJxc9O1P3QermQilv/Fnhkll9AjdLGiMgkpRiEttW9n4Y2tPLMIV0t
         tDLqpFSiAY1wkVjAeiCXbdIkcYKzEIM2h6It0dq3PKPZLVEVdmMeJ/cjJXMKZaKbmfkk
         s81WCRhQvSigV1A1SDO4j9Lvy7s9YgMK+l8oXFf2kIb5iXFOM5GB4zNL2CRbjYFvnWpE
         nZZA==
X-Forwarded-Encrypted: i=1; AJvYcCVACugeg4b7kpWuWADSyaZDHzsd7/rBHaIiVTkuo6oEkL2pSs5sEQFGCN4IfUn6YLVmpN1H64vYXbUPmfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6aM1Gn9OfL54ioQN4cplED6UY+tTzA6BuFHCjTIGXsaeS25Z8
	h1zT/lbqPGVd/fRoGCTNBpKhRSyo0uhDbBUjd3JCU5hquy6sJI9R+9b70Gvc0GWnkDtZdDqLc2f
	TTZOZPw==
X-Gm-Gg: ASbGncv9Qq+ibCR3xMruAy/WzDPl3nyc4bgUy/7WvYHo5lSTQTBDUcI0+xMlsMajXI5
	xIuzMR8IiHZ55ucbGUBhvEAeM3crvhLTHsRlEZNbRoLXbueBVgC2eWUZBQJ/jgtshIkZaK2yAhX
	XoGsuf7rcwkPCFfIfKw8zXuSjMrTy75DCreq3ywFDRIfcb5Ld7Zlp6Lm1c2dyH3uBPRWSBCRmk9
	ZRFAASEyEdtZDEX96afyWztp0N+plX69S04O2Ko9D+Ssd45GXh2WyWpc1uq5jugqnmHfeZP5IZL
	BsYRrO13avjFEI8zWws35fxz
X-Google-Smtp-Source: AGHT+IHs7NkE984XUjXhLEQd5LKqWtCp5R+18+HZZguKYtfq/Okq39KOh8lXXCCb2hCpzbYlLz/ZOQ==
X-Received: by 2002:a2e:bccb:0:b0:2ff:df01:2b4c with SMTP id 38308e7fff4ca-3002de1aca9mr17020761fa.4.1733512170112;
        Fri, 06 Dec 2024 11:09:30 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d85534sm5256461fa.10.2024.12.06.11.09.28
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:09:28 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd668c5easo2639702e87.1
        for <linux-sparse@vger.kernel.org>; Fri, 06 Dec 2024 11:09:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdWjSFwnYviUuiIgemCa6eRMr6QhncpusxOfLEvMm9g3YT9Rng4x5QDGMaY8Ce1TMeHYdeJW4vvooVPsk=@vger.kernel.org
X-Received: by 2002:a17:906:9c18:b0:a9e:b5d0:4714 with SMTP id
 a640c23a62f3a-aa6375f5cd6mr310802966b.21.1733511783880; Fri, 06 Dec 2024
 11:03:03 -0800 (PST)
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
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com> <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 11:02:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk_thfjRnAYRoGX7LjJ8AyiPTmBqjJEPu6JiKDLG2isg@mail.gmail.com>
Message-ID: <CAHk-=wjk_thfjRnAYRoGX7LjJ8AyiPTmBqjJEPu6JiKDLG2isg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, uecker@tugraz.at
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 10:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This may be a case of "we just need to disable that incorrect compiler
> warning". Or does anybody see a workaround?

Hmm. The "== 0" thing does work, but as mentioned, that causes (more
valid, imho) warnings with pointers.

And it's not necessarily require that a pointer expression actually be
marked as a constant, as for the fact that these macros often get used
in various arbitrary contexts where things *might* be pointers, even
if "not constant" is a perfectly fine answer.

We do actually consciously use __builtin_constant_p() on pointers.
It's very convenient for format strings in particular, where
__builtin_constant_p() is a good test for a constant string, which
sometimes gets treated differently.

And in fact, dealing with NULL pointers statically might be worth it
too, so I do think it's worth keeping in mind.

               Linus
