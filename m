Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2122C6FA
	for <linux-sparse@vger.kernel.org>; Sat,  7 Dec 2024 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603751; cv=none; b=WDnaDw3nrdVmtGBbA/xNBQxLR/5UuQgR8aZimoYg6j4OpnymcqwjOR51LgtaADJh4qqBUPWKAaXu2B7E99qyWwCqFFTAkJn2zA35EyN/0VMAqahRv5/T3vKr7lY8OdwOe5/aTwLCXTCHEkQcFUHigyVpvAsiMvHQqQn6EUNE6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603751; c=relaxed/simple;
	bh=7mHyTv6r85AJbexntlqRENNWjYsWWzkVfT4oFafMmAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVDm+bAyhvrd+AmzZPMRa/fxRdTUqHAvh+eFyRXMjEJcYRG8ofMri7kgkBHKHeJq3k3fmNeg6OGamaWBbLGfHtbDglJ0ToPHClxZiY7G+el628TrU4lPG+xaQ46K3e7yC6rEcrvx4mTyXW9BYKbxcJMYA4uOe1b3j01sqii0qbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h4vwUbpR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h4vwUbpR"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffc357ea33so28089901fa.0
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 12:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733603747; x=1734208547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HiZTKf4hCKQ8GKQ+oAO9V4GLtbxeasgvzn3MVqs40sY=;
        b=h4vwUbpRe1JeQ5bnq4lxV0Wgseh2JFuKdx1iLbY0H13IfcxtcrkOohK1lZkWbzpzrg
         f7nN4QO4pYKgxosmCRGglkehATFw0xkp8HjqzF3v11roliMVqotmPZJtJYpNj6ZtMTI8
         bkMccFpA9ihJSWO38O6NWZPob7+db/k+xQEqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733603747; x=1734208547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiZTKf4hCKQ8GKQ+oAO9V4GLtbxeasgvzn3MVqs40sY=;
        b=xT0ImoWb5+TPMkquiV3irulP/TCDi6XZnIAiO3rz3ygewl/nsT8jhFa4uwCgK+Km7k
         u+F5u3JEpzA15ttKz3KFZ4kbkmO/oOqOv1qBXbXWQ7iC/dWew/aoFwo8Jr31Job3oDmA
         EBVLZ+GunqIh018gg3t3g+4vDs2hqaoV2mEZS8LXXnPw9F/a45fNuy5vY5CtCEQgfzIe
         TYehiOkrVo7k8FNuWc3UY590sO8OtdaleNkMV92rPtOoIGH2iH/i7Y2mlNKoVS8KlKCq
         skB/l/tTNuBeDkN1eg5WM5aUOyYPhFomIz9u5e4W12VAEA9iOsqHijf7Tcgbl5syDYZW
         f3+g==
X-Forwarded-Encrypted: i=1; AJvYcCWakSXqlETNh7rSwcZdvOep4O/Ajf5zdAWgZXT1/CaHx1EWyNd2kha6EKrurUA1pWynWxMgyy7woagzwGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouTu6sM6NgH8vDHOqO1z6q1DTg8k9RymUDsAFAeWWlatQ0X8G
	rmwndZNvG1SxlWciG1Xmv6NcpBx6NXRx3YvDzywESC0M89aVtbHCEqOX2ed8TRcbCVcpJB3PaHm
	bOoeBKw==
X-Gm-Gg: ASbGncsuTSzFDxSrN8s5aUFkB12N8kSGI0+xME8oHzEJeWx6gFfAjpx2vgkE2MZ02rk
	FhA6bWVXcu+mqrkh95nBQfcMWkmUDUFBtMlChzF78z6cODGc5PGug8duLKs3TLxme86bvFy4+Jo
	sB6ppkvEcvHn/RPfcj3/yiN3ZreVs+wQSFwgR3+LbXPzbheYtPp/TJdZj1isz/+VUAfWVB0l85h
	ie//J1qq/oivk3CwQT0sX3bkgIxdDCXTC2ZGU/kt0Y04VSstLIRp2KUnernvxr3JiOkeuRGJpZO
	qbzv51VsWTYDBB7ZONUYeFGH4XAZ
X-Google-Smtp-Source: AGHT+IFM+W20uHRrZ3ajFtPrtPSM1gWfng5bMDqmvG6BopCK9q9CufXVI3cXIMF9Qv/HJAOtsRK5ew==
X-Received: by 2002:a2e:a587:0:b0:300:2d8a:7a7e with SMTP id 38308e7fff4ca-3002f921fefmr25957441fa.24.1733603747028;
        Sat, 07 Dec 2024 12:35:47 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e2058fsm8053451fa.79.2024.12.07.12.35.44
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 12:35:45 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003e203acaso8284081fa.1
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 12:35:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQRcf7fTmoO/uzRcNAgr4ZRFG1sCpE8YGhkgeEqCEkBSF3UslQyMq1xoz97L5/HQNFD36LzBGGeBc1ndA=@vger.kernel.org
X-Received: by 2002:a17:906:5a52:b0:aa5:3853:553d with SMTP id
 a640c23a62f3a-aa63a21b715mr608706066b.46.1733603329136; Sat, 07 Dec 2024
 12:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de> <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
 <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de>
In-Reply-To: <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 12:28:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
Message-ID: <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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

On Sat, 7 Dec 2024 at 11:19, Martin Uecker <muecker@gwdg.de> wrote:
>
> But that all seem solvable issues on the compiler side.

You know, there was a whole *architecture* that was designed and
predicated on "it's all solvable on the compiler side".

That architecture was pure and utter *shit*.

Because no, it's not solvable on the compiler side.

Getting things like value range analysis right on the compiler side is
fundamentally hard.

It's hard to the point where either you only get it for the simple
cases - yes, I can show you a ton of real code where it's trivial - or
you need to have explicit markings in the source code to help the
compiler, and then you end up having to have the compiler (or some
other tool) validate those with asserts or whatever.

And random asserts ARE NOT ACCEPTABLE in the kernel outside of pure
debug builds.

They may be acceptable in most other situations, but in a kernel you
can't just say "we stop now because it turns out the analysis was
broken and the manual notes could be fooled by an attacker".

Now, would we want to have proper value *static* range analysis in the
kernel for other reasons? Oh yes. It would often be very nice to have
the ability to state "this value is trusted and is in this range", and
have it percolate all the way down, both for optimization purposes but
also for various sanity check purposes.

But it's simply not sanely available in the generic case.

> a) this is not guaranteed in a specific situation (-Wvla-larher-than)

We'd either get horrendous numbers of false positives that we then
have to manually add special code for, or

> b) transform the array automatically to fixed size array
> of size X *or* something smaller when it can show this.

we'd just do this by hand *once* and for all, and say "VLA's didn't work out".

So yeah. We did (b) by hand.

We used to have VLA's in the kernel. It was a disaster. We got rid of
them, because the (big) pain wasn't worth the (few) places it was
actually useful.

So we have been VLA-free for the last five years, and it's been good.

Simplify.

             Linus
