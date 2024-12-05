Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D2BE49;
	Thu,  5 Dec 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412115; cv=none; b=JmrvK8fJpo/PH+CIgpUx6zOIOE2r6JRSgAOirNjn0nwNCTCysapOjTQXQiW8sFSw9wvQgta47pI5P0HQoCAeMTjC2e82uT0FIfumkSrW2FLLHPLxoINWUn5S6bimg2S+zuYa1XvfjEUNWpB7iT97B6iGh3hkibHsj7Lyi20oueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412115; c=relaxed/simple;
	bh=GC3WGrIayaFhbnkEoyvU2eOpxkJNP8G3yldJihZbihU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFxNkzrAEsmccfBG5lsj2n8PjLPw3ng3gTS7fOFfqqJG3dXSMRNDl/nhre7maaKghhIb/YjbMEjs/x/9Dbp2F6SUKMWxpQSIkvDS1fvWoDa+18XL/fNKPTB4TVKBO1dGYm9C1QR6zfmfpXjM+MHv5fpq+uIKclLqBaMePZ4My60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LvV6d31c; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LvV6d31c"
Received: from mail-lf1-f48.google.com ([209.85.167.48])
	by smtp.orange.fr with ESMTPSA
	id JDfrtYtoJo2eYJDfrtQcCO; Thu, 05 Dec 2024 16:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733412111;
	bh=5Sob8jML2a9sfY47l90QZhBAyozcID3U7Li8+UA7roI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=LvV6d31cJAEGoiZDrSkQNjo9pVAU6TjzSYFdJOCb7T5OGECIfQC4fFWWdIi+PG9Fr
	 Z5mvy9ue4eMDMHUg/NsCshFqVKXRdRV/vDMiwjebztOSISTwmT7a+LkaDlcIddLDRd
	 XGTTsT0WlXOVSW8GqXB9hQYtiz0US7PX6qy3MCSYSEmlrYnTHFT7vBzKzS4V4AvJZf
	 EwyOZsFITzX1fmrJprLpTX4Aj/e+4wzrlSHRjc0EsfZuCLBU95IlPhbWP7uTZ381qi
	 828XFmI1Era9s/qpzec9N2VkkLg9TJW1gG7nQv6dNU0aWJz0w5tINRpuSXq5Gy6m1i
	 ueFlo1bA11vTw==
X-ME-Helo: mail-lf1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 05 Dec 2024 16:21:51 +0100
X-ME-IP: 209.85.167.48
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e274f149fso839058e87.1;
        Thu, 05 Dec 2024 07:21:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV88/MN9Diw6+m3ylIvKiOqJX+gHNlKhg4dbfQMxKA/fJE4esOLruSWZCzap+o5y5e9I8P9br2O7J0War1f@vger.kernel.org, AJvYcCVYUY/C3tWVBH6mApecr1hIwjUJ/q7uC+qIz1IRJ6D+vXOcZP5pDh/aZ47YuRFmeprn5Y/AlnVoTIcAfpcAfwo=@vger.kernel.org, AJvYcCXaJmmXEBFq51X34gT9k45oSzLyEX0LZNHFCx8p2pbwCWmTzwvjl0ABgj4hr7RyuGfDYQqaxNO9lC46Xh3P@vger.kernel.org
X-Gm-Message-State: AOJu0Yyquz0FnBLOZo3QeOGPLfWuwZH9cFUrsQyiFVEI5PWRTKB39MSB
	JlS2K2n3Wv5ykainp/vEKF0fLTYIC/FG1YsVWEpcJx59k3/G5O25Hh+6GxpsYhR3B7QDGMocYeN
	dAunSdnmbqjjQzt53CmSLNpx6FSI=
X-Google-Smtp-Source: AGHT+IFTPODU6RGdJMXff+75tOD6Nj3x2Mn/gdl5NWtqQnJzhnFZgI0m0ZroaJ8Q+jvxJuILOkW0ziN/Pe9Qt29xALE=
X-Received: by 2002:a05:6512:32c8:b0:53e:28dd:a9d1 with SMTP id
 2adb3069b0e04-53e28ddb7bcmr693951e87.24.1733412111008; Thu, 05 Dec 2024
 07:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr> <FBEB24FF-5885-4938-8D1C-9B7BA9071FB9@kernel.org>
In-Reply-To: <FBEB24FF-5885-4938-8D1C-9B7BA9071FB9@kernel.org>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 00:21:35 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLSiTfTNQrcje06MbSxvM2k16MgqG1YTCufe6j9FhupEw@mail.gmail.com>
Message-ID: <CAMZ6RqLSiTfTNQrcje06MbSxvM2k16MgqG1YTCufe6j9FhupEw@mail.gmail.com>
Subject: Re: [PATCH 00/10] compiler.h: refactor __is_constexpr() into is_const{,_true,_false}()
To: Kees Cook <kees@kernel.org>
Cc: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@aculab.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu. 5 Dec. 2024 at 08:58, Kees Cook <kees@kernel.org> wrote:
> On December 3, 2024 3:33:22 AM GMT+10:00, Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org> wrote:
> >This series is the spiritual successor of [1] which introduced
> >const_true(). In [1], following a comment from David Laight, Linus
> >came with a suggestion to simplify __is_constexpr() and its derived
> >macros using a _Generic() selection. Because of the total change of
> >scope, I am starting a new series.
> >
> >The goal is to introduce a set of three macros:
> >
> >  - is_const(): a one to one replacement of __is_constexpr() in term
> >    of features but written in a less hacky way thanks to _Generic().
> >
> >  - is_const_true(): tells whether or not the argument is a true
> >    integer constant expression.
> >
> >  - is_const_false(): tells whether or not the argument is a false
> >    integer constant expression.
>
> But why make this change? Is something broken? Does it make builds faster?
>
> > 7 files changed, 97 insertions(+), 84 deletions(-)
>
> It makes the code larger too. I don't see what the benefit is, and given how much time has been spent making sure the existing stuff works correctly, I feel like we should have a clear benefit to replacing it all.

It makes the "code" larger because patch 3 ("compiler.h: add
is_const_true() and is_const_false()") adds two new macros with 20
lines of comments to explain the pros and cons. So the added "code" is
only comments. If you ignore the comments, you can see that I am
actually removing a few lines of code.

As for the clear benefit, sorry, but I have nothing more to offer
other than code simplification. The reason why a lot of time was spent
to make __is_constexpr() work correctly is just a testimony of how
complex the thing is. That alone can be a reason to simplify it, now
that new tools (_Generic()) are available.

Of course, modifying __is_constexpr() is not strictly needed to
introduce the new is_const_expr(). My previous series:

  https://lore.kernel.org/all/20241113172939.747686-4-mailhol.vincent@wanadoo.fr/

 did it that way. But I was rightfully pointed out for my macro being
ugly. Maybe I can suggest that you give a look to the above thread and
tell me if you still disagree with David and Linus's comments after
reading it?


Yours sincerely,
Vincent Mailhol
