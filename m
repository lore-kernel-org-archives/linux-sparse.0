Received: from out.smtpout.orange.fr (out-12.smtpout.orange.fr [193.252.22.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200315B102;
	Fri,  6 Dec 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451916; cv=none; b=D2BGXTw6/a1bvCjPf2QkvhC8ZtU6ormcrr9kDk9Ujh9RnfvW2+MrRYQiU7EX8K/JiXfdQqEbwgFKIwfjMQwnBMGjlzrKAH0NR9yrNmnPS+yRtORlDeoY/LZNzIAqYfkl0yLyLJw8jZIplwpws4rpRq1phD4lqG/9j3JljbSqNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451916; c=relaxed/simple;
	bh=6RTv55FsfGEAbH65kMZfiUbp6t9oJTmATDpoVUcjvLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8CcbR+jiVcMRYdiXekOqVoJEXBUofnOmWc1EaG1U+nf6Eq91turuHNX7PVO6h3XmXS2vMu1qSEPnBbMSIvf9zy5moCaZ7tH08l6KqmIVchI11S8ZaGyz+2QNhjxNbtWO2v88fv1/Mg433v8+Sdent9xjGwljxPh1qg6aPDdPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BLlNDwl6; arc=none smtp.client-ip=193.252.22.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BLlNDwl6"
Received: from mail-ed1-f50.google.com ([209.85.208.50])
	by smtp.orange.fr with ESMTPSA
	id JO1nt7eqp32OGJO1ntEhTo; Fri, 06 Dec 2024 03:25:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733451911;
	bh=EDV0uoUPSeCM4ycVbpiYzkI+GBIJXljO1W7VncV40gg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=BLlNDwl6OXAQbQFoTdDT+T6/mgTmN9X5jyf5mgrax8OIDekFhy5rVT6xKCSyDdnNu
	 vSdQRzodyYm6Mq8SNvB3cW9QTuzsw8LAbKUuP0xvv5JXwoFn6jyM0/kHkNcMndzJWi
	 q+dkokibRg0NByE+DMcmHv/aoEzLVPD552Yotgqji6+6BXWfwg5+nWRXt9BDXswnYd
	 Eq2Yz4a7OpjQ7KeLbTCtEXPpVuQuqWXAQ5wMy3WgrXyjyoARVamyxhJQWbuTEISAwg
	 jwUDWin0JNBrgbZOFlflGKrcuM97NvgjASnXS6NJYu1KtdF70KtJwZ3Y5WOorszraZ
	 ZPN799bTHwY8A==
X-ME-Helo: mail-ed1-f50.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 03:25:11 +0100
X-ME-IP: 209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0c098c870so2903624a12.1;
        Thu, 05 Dec 2024 18:25:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW069yRiNpLhw7+nkoGMZQqQilBmQBfqKbYHeLIEjFnSWPRcVuus3Krz50WakMpXoaV6CNbdRftPjSB9R5s@vger.kernel.org, AJvYcCWESg37+9tYG2qgIO3WJel9ECxXBXVim5Dn5KLyGIDiYkdAKQ8171PsjMhG57dt5M4rXoMPz5NbQpJ+yGz6@vger.kernel.org, AJvYcCWSxF+WWbdAlciPg2QMIaWxJJgLFLfgmhzcqiR28e3iOmBNqo0PzPz8+Jsk4yGqfmxVBbjDieYjTy0vKLmD6Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYxnLprPRQCCt5tWaCtS4vzOMuDYHewrgw7dYlHr1ePemOz/9
	tzrByCJEJyArMpevc/OOxBPUNqgiMa3qfR4CHEsem1Q4C1voRijVk4YcTbcpxBK4n/e1guyhTlC
	iqR1ClfZa3b9dHntPA9h+E+VgRxw=
X-Google-Smtp-Source: AGHT+IEENKH5q363NsvaDS9r/FGBH4NT8jK2UDZzhmMDEw1YQ0vbbHzKVnWBLQ5cMhIKh2zINR9br+tBOM6tHUnfBmY=
X-Received: by 2002:a17:907:7759:b0:a99:5f45:cb69 with SMTP id
 a640c23a62f3a-aa6202f3295mr391454866b.4.1733413951191; Thu, 05 Dec 2024
 07:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-5-4e4cbaecc216@wanadoo.fr> <8b8262389bd6484586007d749132346f@AcuMS.aculab.com>
In-Reply-To: <8b8262389bd6484586007d749132346f@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 00:52:20 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJPvbSr5i8N4Dm=2N6D8uSzefCM3TyK8HBNNNrybo5f2Q@mail.gmail.com>
Message-ID: <CAMZ6RqJPvbSr5i8N4Dm=2N6D8uSzefCM3TyK8HBNNNrybo5f2Q@mail.gmail.com>
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

On Thu. 5 Dec. 2024 at 03:54, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 02 December 2024 17:33
> >
> > In __clamp_once(),
> >
> >   __builtin_choose_expr(__is_constexpr((lo) > (hi)), (lo) <= (hi), true)
> >
> > is equivalent to:
> >
> >   !is_const_false((lo) <= (hi))
> >
> > Apply is_const_false() to simplify __clamp_once().
>
> There is already a patch 'for next' that changes it use BUILD_BUG_ON_MSG()
> and statically_true().

Found it!

  https://lore.kernel.org/all/34d53778977747f19cce2abb287bb3e6@AcuMS.aculab.com/

I think the easiest would be for me to cherry pick this patch. So that
regardless which series is merged first, no conflict will occur, the
patch will just be skipped the second time it is encountered.

Does this work for you?


Yours sincerely,
Vincent Mailhol
