Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360F1DF96F;
	Fri,  6 Dec 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476038; cv=none; b=czJTYEoUpSrl+f5T3uF+MrlQ0N1i66IYo4TRC97s+sYC4748EbrLXlCFmvdheYMMaU0Ss2Kl9kreGcwXc0cGwM3XqsP99bvmUaB8/aZOb8S5p8UQwUyC9IdFcoWcPlA6sCQILDwqDP5UvIdUZQY2o8z1o0RnLvMMkHNj21wjSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476038; c=relaxed/simple;
	bh=0q7ZFLwW9rU2S2ohh1blu7RzwrYq7HPnLQWJ4LGS+aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf2KEJ44+WZacVl103hrTOs4gT8Z1xCp4JHqAZP5BoMm5lF0dmEtiTmfxhTTByL340sXI3yzDtxUBLaHN2XGQ1AeynER03r3yH4QhpgewMmXr4ZD6SL+hliRwAmo2pyqEYY6LGJVejo7Fd3fyY4VUwViktNhwrAr1QQwA+T8+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iAne1yae; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iAne1yae"
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by smtp.orange.fr with ESMTPSA
	id JUIptudxv25GjJUIptaQ6E; Fri, 06 Dec 2024 10:07:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733476031;
	bh=5FIX3GE2Cphszv8rtvt9crE9ghdCcm+668GDkaRhBU4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=iAne1yae2oKd2rgb5zhuKVojrEPeKvwG9cjTE42bJPalgV4b/lHysh/EQGl2SoEBh
	 aHTd7PjlB6kO15WFnL7mT5iwF7AKqBfRlVquPywTEAAnLrsl/oA34svt9njQ+rOEHU
	 wQTo14aqpRbWNvNxvN3YdE/9QjbdqzXwFMC1xHgnb0ym/dm6dA9UxDarGMr9gsFayl
	 o0GXaBq011UCmb6nyEU6/nG/Ai+Rqi/5spYXuAZpn1gKxfx2xQq82sRJ8jKk6Rm4LP
	 P9ueXQkkhNfIe9XbPTwONAyf2QWwGi3dG0eRzDc3K45cJXCHIwpWMXdUW7eboXHnHo
	 Nzss5Q1nTgMqQ==
X-ME-Helo: mail-ej1-f45.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 10:07:11 +0100
X-ME-IP: 209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6332dde13so173988566b.1;
        Fri, 06 Dec 2024 01:07:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUMiWKGVIPyUxjYbWIorx0ncmeXJcE4kIW5neT5ai9kLnpTZS2t86IUH+EImz76pL2ZvuYf6GYorQECoXb@vger.kernel.org, AJvYcCUy0KooX9Fb7w7+u2rkkskuZ+gsMyeKMrBXoW7YtQCNcw0k5y9uQcSGzRvKEO7TZKzxJX8ULiKKStlEPXM9@vger.kernel.org, AJvYcCVCwejHEqHg3pltljucuLK/fg1EXwL5koIugr/dFTQq33TdaQwuRyPMlMpjJ6yr/aE3sUFyX1wfFrgzkEVxfDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZS234xypwW6iyprE5syfhF6FX/GX/5J0g8XNIgLkvIRhuCGx
	qQ5yNbPVZ2tKvu+bh4lM2+dEfgWpLgqO06590SuL3tjNNVhi20UcoXgxJOy/TsQd0Tw0ilhBNVV
	Egw8kMAU2TMo0CefcNkJMmLqkvpA=
X-Google-Smtp-Source: AGHT+IHtHlVyoW+nRFmP2KVhABtFl5ikoWMC68HCGMKZEPnxOyfyDUMalss4BKk3XOGNHnTjXwFKxuaBrlfCMkC7FxE=
X-Received: by 2002:a17:906:9895:b0:a9a:238a:381d with SMTP id
 a640c23a62f3a-aa63a2c64eamr136036766b.52.1733469982863; Thu, 05 Dec 2024
 23:26:22 -0800 (PST)
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
In-Reply-To: <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 16:26:11 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
Message-ID: <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: uecker@tugraz.at
Cc: David Laight <David.Laight@aculab.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Martin Uecker <muecker@gwdg.de>
Content-Type: text/plain; charset="UTF-8"

On Fri. 6 Dec. 2024 at 15:40, Martin Uecker <muecker@gwdg.de> wrote:
> Am Freitag, dem 06.12.2024 um 02:25 +0000 schrieb David Laight:
> > From: Vincent Mailhol
> > > Sent: 05 December 2024 15:31
> > >
> > > -CC: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > > +CC: Martin Uecker <muecker@gwdg.de>
> > > (seems that Martin changed his address)
>
> My current one is this: uecker@tugraz.at

Ack

(...)

> > > > > + *
> > > > > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > > >
> > > > IIRC Martin has agreed in the past that the accreditation can
> > > > be removed - especially since it refers to the 'sizeof (void)' trick.
> > >
> > > I tried to look for such message:
> > >
> > >   https://lore.kernel.org/all/?q=f%3A%22martin+uecker%22+__is_constexpr
> > >
> > > but couldn't find it. Do you have the link?
> > >
> > > @Martin, do you agree that I remove the accreditation?

So, do you agree to have the accreditation removed in compiler.h?
Personally, I do not mind. I am also OK to remove you from the
documentation and add you to the CREDITS file if you'd like to.


Yours sincerely,
Vincent Mailhol
