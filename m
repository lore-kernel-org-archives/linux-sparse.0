Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141D322E;
	Sat,  7 Dec 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585019; cv=none; b=Es26YEYZwKLd6VTWQZOvTMk/Oix9SDqwPHkuVrUz2HgqiMqL/jLU9fap4L1XXTeEVqWwv0miwYUBLiEKBFvHQhSbsV/3/HLvI002bMBl8/EOz5cR3D/hsAzgdOBdRP6gooXB4u5ANTcXS4ubi/+J/bduhBRWuxtKEEsDk1lXU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585019; c=relaxed/simple;
	bh=9klYLk4gCiLWbKle7o/IVMAyL0lAMD7YRZgQqgDPYE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+KmWf7NycDJfjIoxWsFF14pUHdXStkb/wvgzvysLm6YiwdkilSVNYa2baCcJBQSAnrEHClygJb2QSTTGMQRV5OMvr2OzblHkt+EBBKT61H3LOeB82alO50g2yUKmXCKDDKggTZ2BJ7FqkdUx8aUf823WR7XbzHgoHvWv4oFb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmue8dZb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmue8dZb"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so4751574a12.1;
        Sat, 07 Dec 2024 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733585016; x=1734189816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXHUUtMJhw42ifbhB350SCKKtNQKr7a+mjsEg0ARJVE=;
        b=Dmue8dZbq0HAYmP1R3xNp/qqmAEgsgcoMZpHARhcBKhJC21YHmo5jyX5X07V15/3jV
         EMaH1xfdQg9iQxkoC5qKAg2iIgHI2v73tE/RFXZOBCToitNv6la0GJ5qNb/2GqLMKdrD
         s+1pQGj6U/SKvLvBOj9jjXzcxMJBP4e8f9U/lVqZauCekf+G9k/3ODQas1K6R3Rk8UWh
         u9RnQ/nEVFfVUETYfTqsZQ2s/cNGFKgXIoTnlnM+Vl81T/BYKPTucgc6j/r8NzI29Jss
         X5MRMGTUncypbxUnHDLMbRhU9tadQCFXjtYacoyJMenuad1QV42Dx+uW9Upps2icv8gD
         RToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733585016; x=1734189816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXHUUtMJhw42ifbhB350SCKKtNQKr7a+mjsEg0ARJVE=;
        b=Mt+17ZDuCZHJrkIJlYFijFjEuwNWYxXqwcwBt/XbibZs288BiWgltsRndM25387jDJ
         BIiuhWDeHoLmhMr8XQbkUGJ9X3ecEnl6+/OlrrxgQfZQKeN4hgxEfEd/3e3GdTgFBI0l
         Ln5HC0p0K3iA9RhnG3RrCUfzSSl9HvlSvqMe8jBh0aZ+/wt00/HxeyJDWNio7WvV8Hfi
         cVv7dwSA5+Px2fJSAc9a8QAkHWY0oQVl6O+KoScqCb+k6tEH9j6PfGjD3bMLE67fVgQj
         QyiCDwuMHJ3McvDwPDEkQydKiaZ24tJWAvEdIk4PNsvsd+YaG6eLL4pmDmoQ98hAShBO
         L2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVM+ji0rzyjb2KqI8NJhfHiHN7PMrV23UICmJclcpVyQWg+t4on3mqNAeyK7BxHheF7KeSCLJk+e9YDm453RvY=@vger.kernel.org, AJvYcCVeWeCZpQjrYj4l+oTnNvm+VrjscCURg4aKrLKKcu3MAOJZNjIMeBCHM7ulliiRpmMqK0Uee2aLnf10TY/w@vger.kernel.org, AJvYcCWj6BOTTQiZu+p7C0m9vDlUxa18L6BfkC+L2QiCThTGXWN5/9w70/nnbiv6dDCxI3h5FIV+jZp3QAZsv28s@vger.kernel.org
X-Gm-Message-State: AOJu0YyguL2sXBhG/S60619yDxGksACjqLPvZDTDbN11DZz463mWwf+g
	k4Wgw2K+FwwU6d/t44apUhF22lVWIXtxHhGZANFiGQxipDeTxK4sfddHMxff4RiO1yp4CFd8H+9
	GIEE2KqirP2IrifyGa3WYRookkEs=
X-Gm-Gg: ASbGncvIAqAdbL3TwhwY34pBNogFhoMCoRwYOuvY5HVUYpSeHLTE7VFRvHU/obI4ppa
	8bjKNpK6VaIGzRn/aBfzPYjg2YDIqRC0=
X-Google-Smtp-Source: AGHT+IFjxVVDHtb5XUqKlxwjzwTutKQUzN2zumRBPx3EfKj4t3Mn5Sq/gwwPwX7tapi/bTH5lmwV1+4Ni4olRczdgm4=
X-Received: by 2002:a17:906:b3a6:b0:aa5:1661:1949 with SMTP id
 a640c23a62f3a-aa63a21bf7emr624479066b.40.1733585016096; Sat, 07 Dec 2024
 07:23:36 -0800 (PST)
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
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <CAMZ6RqJGqBqvgxzp5yPFY1pk0WkkwEMM34qU-dZ3kXfsnKaqEg@mail.gmail.com>
 <429e7c6713ecc94494d9107e5f5a1f0c8e854f23.camel@gwdg.de> <CAMZ6RqL+iS6GVsY20=O6GdQakRpp7XdewZJsUbmE5OCsKaHR6Q@mail.gmail.com>
 <b3bd6d4ef485dbb5db4c784f4e42f76adce502dc.camel@gwdg.de>
In-Reply-To: <b3bd6d4ef485dbb5db4c784f4e42f76adce502dc.camel@gwdg.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Sun, 8 Dec 2024 00:23:24 +0900
Message-ID: <CAMZ6RqJrAVVLDAJtNTA2U=UFVUJp1samoat+yfBmSpO-dCVcaw@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun. 8 Dec. 2024 at 00:10, Martin Uecker <muecker@gwdg.de> wrote:
> Am Samstag, dem 07.12.2024 um 22:50 +0900 schrieb Vincent Mailhol:
> > On Sat. 7 Dec. 2024 =C3=A0 22:19, Martin Uecker <muecker@gwdg.de> wrote=
:
> > >
> ...
>
> >
> > I was invited to WG14 this September. For now, I am only lurking. The
> > thing I have in mind right now is to write a paper to allow the use of
> > static_assert() in expressions (i.e. make it return 0 on success).
> > That should be a relatively small change, but would bring a nice
> > quality of life improvement.
> >
> > For context, look at this:
> >
> >   https://lore.kernel.org/all/CAHk-=3DwjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj=
67T5k2ZpDbgA@mail.gmail.com/T/#m1ba33a804b4041154b72a1d0333f90ec7204c461
>
> What one can do is put it into a structure.
>
> #define const_assert(x) \
>     (sizeof(struct { _Static_assert(x, ""); }))
>
> but yeah, also a hack to work around a limitation of the standard
> feature.

If you scroll down a couple more messages, you can see that Linus came
up with that exact same hack :-)

It is now upstreamed in:

  https://git.kernel.org/torvalds/c/d7a516c6eeae

And yes, this solves the problem for the kernel, but I would still
like to change the standard to solve it for everyone else.


Yours sincerely,
Vincent Mailhol
