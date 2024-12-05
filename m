Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81055226EEF;
	Thu,  5 Dec 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419576; cv=none; b=AxTar06LdbiWOgvLpXkpS11fdZslE9oTDEWnPSbZYqILTc6BUz/tgJQNgio9Jl06YCU69KUzsUOgVQKiONb40qKy4MuWJKO8yw10AKAwfqhXQRKSETNOeN1IXxynuOyN33jcfQhY6VhVRay3UXegFClg/0qqKYt5DDzdD+zvMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419576; c=relaxed/simple;
	bh=jlq0yEcIkfhAw4RY3cySThksRiqdiH9uWNpu/3Vz1CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/QQVbA4LVTz826UMidEq6awI3Y1CzuLPmWcoTteEEnM8PX7eeEiZkzAhsUl0+VNkwRXl1N/93fwdDWbnvj2ts4h2pfwku16qJe02etgDhsFCvVQdIzTXOUpBKxEORngw/QeIpRD3rQtTju2meDQegNBzNoPHW+ryDBcHrXiEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rs+oC1Tr; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rs+oC1Tr"
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by smtp.orange.fr with ESMTPSA
	id JFcBtxPvW5DmFJFcBtb1Ic; Thu, 05 Dec 2024 18:26:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733419571;
	bh=y8D8qHkNTgsq/hueRr7hAF5ECQldq13KAVXg/Zr3BLA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=rs+oC1TrEE1v/UZFNCIY5AjtHxQj56UdZP4oNawSj2QAaLpf/Ly47/hWHZOuMQlXH
	 nQXdmjeBnBum795IjKCj3pTbQypO0+ZoGcV0+9PAB9wPBUFZtv0wBY5Vh8p9M9RafR
	 fIDII6JyeIjLdnF9qxiGv2BnN5l0yX+wpd+W3uq+6CTt4gt1uUZwN5kVI1HV57kwBm
	 CDxlyBIGVh6kSxA7JT0bFBExW7DUk86B4n114BWNbAjNbvnDXR6giT1+uZvRflQDwm
	 GD+Fs8/muxIQNX3+OF6DLtun+Dtcf9UzfZeU+bRCR5KpftzoQs7J5WePMz7kMqkPvH
	 SBu1XVtltfHOg==
X-ME-Helo: mail-ed1-f45.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 05 Dec 2024 18:26:11 +0100
X-ME-IP: 209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so1632035a12.0;
        Thu, 05 Dec 2024 09:26:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTTG4Io+Ofnv/lAS1YAZEAhy6yZ9THnnrxqjHUlMp2rru+CV/FEX0+I4Ye1fGrlGoA0bCfqkJGRxUEfvh4@vger.kernel.org, AJvYcCUa3nUu/H0UoF+1eo9DytksgIrHYdnYp+P5RF/B8oDUwDQgLFvuO0pI2mlSGqyizEKaah5laFZHFx4AQiAzirE=@vger.kernel.org, AJvYcCXxcmHkH1OJZkomNmtbUBcI6+oqS6v/rsLCdjm8Hto5JlxzZP/TZcHhxwwsimcr8BdqCiAeJN3GuxA0pIsX@vger.kernel.org
X-Gm-Message-State: AOJu0Yykc3BDt/cliWXqpg0kiTsrKUhJvSwYyGfI+hVNubzMfSzigbGy
	W48rC8Vo/tH58cY51rfS/7RwUjthawbrXKj+QwsAiYY3FlDSxNb9FHXBnBgQK98xbbOgVAavEW3
	THZTM38D1KCsbYsAYjOmdiBSYNAg=
X-Google-Smtp-Source: AGHT+IFZAC0AEpJ1/mPjmzfGhg/DetDbHXis2ssNehZ0yWdtCmcXanGc2R7Dja3wTy2rdkW6SAY6SvJBqtErDk3coGc=
X-Received: by 2002:a17:906:3295:b0:aa5:28af:f0e with SMTP id
 a640c23a62f3a-aa5f7d4edd1mr1018856966b.15.1733413793948; Thu, 05 Dec 2024
 07:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-4-4e4cbaecc216@wanadoo.fr> <dff4cdd543104e3792e4856375f310c1@AcuMS.aculab.com>
In-Reply-To: <dff4cdd543104e3792e4856375f310c1@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 00:49:43 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLsiOF=5FZ=U2MtZ01iBYKZHtfZ5Zi4t3m=L5Oc4EPHGg@mail.gmail.com>
Message-ID: <CAMZ6RqLsiOF=5FZ=U2MtZ01iBYKZHtfZ5Zi4t3m=L5Oc4EPHGg@mail.gmail.com>
Subject: Re: [PATCH 04/10] linux/bits.h: simplify GENMASK_INPUT_CHECK() by
 using is_const_true()
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

On Thu. 5 Dec 2024 at 03:52, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 02 December 2024 17:33
> >
> >   __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)
> >
> > is equivalent to:
> >
> >   is_const_true((l) > (h))
>
> Change it to BUILD_BUG_ON_MSG(statically_true((l) < (h)), "error message")
>
> and then fix all the fallout :-)

BUILD_BUG_ON_MSG() is not suitable for GENMASK_INPUT_CHECK. We need
one of the variants that returns zero here.

But I agree that it is good to have a more meaningful error message
here. I will use __BUILD_BUG_ON_ZERO_MSG() in v2.


Yours sincerely,
Vincent Mailhol
