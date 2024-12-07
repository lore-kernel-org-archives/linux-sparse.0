Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDB14B96E
	for <linux-sparse@vger.kernel.org>; Sat,  7 Dec 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596078; cv=none; b=BCo/mzEvEduRDH8Djm4ggQaSeQ6aUjUbo4L95S+JCbHcksufoDroTLxNkEIRGpgDcjjSu8bltB4+RfbwSCRkU9ofB37TtnkBdgmbTh9GdM0Zqme5WAE2OhcjJDmrq0SsMKJS+ylnINQimi+qDyuwwdpZkN2yYGNpbzGONMoH2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596078; c=relaxed/simple;
	bh=xXsYNQRaodrrqkXbZvBZDBxwyz9RKFl5ErY9YCsri3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf5LYao4xRUr6sQ+3MAV4MOrITXYmiV2ElMNdpfFWIAI7lvm2SDRWO9ZOU7sA9ohln8ltNtcrRcg7/0Ysq3T6YIj5wTFGoU4BrweP9BhBr32YdRqT5kI/fFcb1oofvxccgMmFxYjODfnK7PqAVOZAoVrJ19eZSvUEWQ/+aCYnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H0pt3ysU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H0pt3ysU"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so3749745a12.2
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 10:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733596074; x=1734200874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hz+XAesKzHzZKAdlmXfk5ETHyOV9LQeE1EOaQCTU32k=;
        b=H0pt3ysUQlbLzOk/+ZRuST1gd/6Nz2BdPUI8kUPOr48Tf4TWoCGoN5oUWgoLIRSPbh
         lnRD0IZkO16V06ok3tBdGbyuuqRhmJq9Qgq0O7kTfj4zpFXfqx1nvPqWHaAEv12O2yzT
         PZ2EPmvcY8RCbCFs62LdN+U4n7sBjz8AJYCxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733596074; x=1734200874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz+XAesKzHzZKAdlmXfk5ETHyOV9LQeE1EOaQCTU32k=;
        b=cd8R6zf7V1Rw3H14zjNe+Qx18xW9WtRN53OtKmMEmyMBLIREYCCg2jb4Jau0CDq4md
         93ihn0if/DY2nQ2HznPc+tSedh1XCT7DNs/NngYf2gUtp+UnFnTJ6w3J4C5EC3aWNdLj
         e2jYpwJ4QgMyL4Mf7eINn2q27VIMxs891Kz/xp0GSPcslBhT1GdPTr2xn97liLTqn+2W
         cF8+NoDxtI/vyloK4h1eXUiAhBsu8eLgRcSSXZg83GRf+VCaYixDsSutjos+PGKmZc/Q
         I4RCzQkKA4cx9klay0/VgmK0d4oUAlpwdvwy9uUvAKokiO8TTqE+z71lAUiDPnKasHeB
         jwug==
X-Forwarded-Encrypted: i=1; AJvYcCVgBGBBmtwtaURBv6qbA+QxOX67kSW77l4fL6kD4aRNqBEGYF3iLRdcX32zxTno5ngMx/ts0PFAzst7Y4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MmoKRhDJuVEkopAy6OBvEYjsnhH1HWECNku0mYENCCrX2b5Q
	pxcL0Y/Hh0DCDBkB1GlxjGWE6fHgpT0rMXkigH3jHt+dTkZmx4KLd8noo6KvPzv1TkLV3wxa2O4
	B767faw==
X-Gm-Gg: ASbGncuXY4VEM4aOW9ANfljmb2MM8O1M6L9a0FvFLxnKoHSXID2K08/jNfDobKUbTAY
	7pCvi6X1wNN9mYCQPcZahxz7FSPgS5XYKuOT09mWszpwHmcq0OvzVxkxjs0kapvjUczNQFzIAVN
	RS4MlTAyOSdGSGEK/z8Fv26A221Ho1SWskJoaFs96xklw4XorACBAj1NZKb0Jb5uYYv/tDA+hLU
	kxUPoh9GNZa81UFzndoF4GHEgV/V49fgX/Cj0kEXZOqs2seTqE3NyQXa51B+t6EyO1aQc1LfR2Z
	3JLfYZMAHL+y6R0fiLtPrx7eF+Sp
X-Google-Smtp-Source: AGHT+IFjr6aF/7ajyIbZLrxUkDzbOI9BV8gbif1ZTkDGSyRM7+kPx2DzLagD+H6xdUbNToCqYBR3Ow==
X-Received: by 2002:a05:6402:4005:b0:5d0:e00d:93e8 with SMTP id 4fb4d7f45d1cf-5d3be6644e5mr8070304a12.6.1733596074525;
        Sat, 07 Dec 2024 10:27:54 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa9c9sm3743476a12.81.2024.12.07.10.27.52
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 10:27:53 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385f4a4093eso1900878f8f.1
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 10:27:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjhQY9QGwNhCEaIzcSu4hMAJzglG6v6ZjAocXvO9iYKZNLsMsrjLVHCOAqB6ri0PHgLMY6ygKH5n6zcX8=@vger.kernel.org
X-Received: by 2002:a17:906:1db1:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aa63de7f394mr497786166b.37.1733595590996; Sat, 07 Dec 2024
 10:19:50 -0800 (PST)
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
In-Reply-To: <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 10:19:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com>
Message-ID: <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, "w@1wt.eu" <w@1wt.eu>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"uecker@tugraz.at" <uecker@tugraz.at>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 04:24, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > No good - expands everything twice.
>
> And? __is_const_zero() does not evaluate its arguments, so no side effect:

No, the problem is literally the expansion.

Double expansion of these fundamental helpers gets exponential,
because they are used in various nested ways in other fundamental
helpers.

That's why we then spent so much effort on trying to clean up the
min/max macros, because a single line of code would expand to
literally tens of megabytes of horrific expansions.

And the problem with these things is that you can't make them inline
functions, so they have to be macros, and then you build up other
macros using them (like that "clamp()" macro), and it really gets
horrendous and affects the build time.

And yes, it is very sad. Particularly since a compiler would have a
really easy time with some nice helper builtins.

Of course, often the compiler *does* have helper builtins, but we
can't use them, because they aren't *quite* the right thing. Like that
"__builtin_constant_p()" not actually working for some situations
where we absolutely need not just a constant value, but a constant
_expression_ due to C parsing rules.

Quite a lot of the pain we tend to have with these things is directly
related to the fact that we often want to do these tests in contexts
like global array initializers etc.

If there is one feature of C I would have liked it is "allow inline
functions and statement expressions with constant arguments as
constant expressions". Other languages have done that, and it really
does help. And yes, it means that you have to basically have a
language interpreter in the compiler (you do want to allow loop
constructions etc), but it really is very useful.

Oh well. Even if compilers added that today, it would be years until
we could take advantage of it.

At one point I literally was thinking I'd do 'sparse' as a
pre-processor for kernel code, in order to have extended language
facilities like that.

            Linus
