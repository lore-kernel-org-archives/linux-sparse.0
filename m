Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43F14B96E
	for <linux-sparse@vger.kernel.org>; Sat,  7 Dec 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595983; cv=none; b=ditvYYobL9XPNczlAGX5ua0lr6JYu/4xw6NZiIOyuJXfnP0M+5CLDbQWozy2FUhDZc7YHJX58W3eoqJX+62lypYQVrttTYG27VYDNGWSJi0J4aTIqzOtinsPrpDfYzTFUJPWKqpO4mgvgmy397muInp532HS8Kz0nWqpg16tzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595983; c=relaxed/simple;
	bh=pCyqxQB1wqSB6HSVhdTXB/6ltiXA8UsqI4BL9ES1zGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD8G1sBSIbrmyUut9nL927oJlOb7d0qrcsem9+wxre/TNoiI/9QD/YGMiYDBiARUSdf+sLdhpS9cqAcxZPV0sT29n+hx0Fvn1sCjI2qdNXTswEvyrb7aDq+5UDgBVAlPbQQy78+J6lJ7iL6cBFfphJAFtEYck6K3vIJsCTYtMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xkrv+T+P; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xkrv+T+P"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa560a65fd6so561935866b.0
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733595980; x=1734200780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/vNc5nALUWVUmfD8b/aC22BtPTbXjUkByw6MJHP530=;
        b=Xkrv+T+PdpVlV5hRmiNOaFXx1KGBy2icNh2XQWOLGEO6tCgTaZIlsgrN0LHPgbk1dW
         XFhiY1K20e29MmAAgGNqvxggm1KK2rEOq3Ht5VermQqbeWytJAXtJtW3RZOkCihjPgob
         nTOwlP5j0lbqX0ebI9eKgadwlPP8WN9+cPNZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733595980; x=1734200780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/vNc5nALUWVUmfD8b/aC22BtPTbXjUkByw6MJHP530=;
        b=LMkhZF3aasdvs9A75lrgePnNvdTfdhoxrczm/nGvYeX2oJI+miwesX7Js7hI7sa+Mv
         Fe4/2rwRcC2ndJOT6uPd4DdbptwRjxd9jWaGvoSMDXjN2NY6mhWmle/Vmp/2h2tIjcCO
         HONM+KOTavjNEEeqxj7cC3fd3nAP0BeEK16HAuec7I/PLvFJhLFbpB3u/GDtA4nSgd6G
         1vteApHk7Z5ZFMu95gHq7bprf2MdH17Ca267hqHk8f2n2MpiOmA6/J4twAv43Wfg1nVP
         6h7+81PdvU8QRWrdJC2nMtsfaskNUIMO1MKfbzNDx96UAN2YMVxCci0N/CBEQDUiTX/O
         7iZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnXmlMLVE4gy/dhaeUYc7slXFzf8C2N5dxV5iSyokFbi75NIO0Wta5WDhnUr5FqPM+9r2gS3P8lMxtSNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lyriOrWSNyoA65VkEtZn1AtiSjc91y1iq87sgbQJMVVb8BAC
	1e6ocSNNauZToABGRiu305xBpUkvbe+Uf78IYAcItaY5YyzoHg9gZrbQt3+VLhNH8edeJDTi+ac
	4yoJiig==
X-Gm-Gg: ASbGncughPKOVIYfNIwAfcMN07fMszjP8G3pTsMxiPkHS/v6UVgifBKfV+mgwtiLd33
	T+KCzIYoII5boBKne0zwf+h06b0DK5x2602GKmAlDU/P50RopDotIW7i8VMCGWfQu938Dgj9bNB
	rYJLIpEt+PmBUko0CFfbUKS2tckF3QJKAhSFcu81Qjgy2VkXQ9sU/2So1XprJgZYsMlW/OlZcLU
	jBgloUCO43FoIEF1TQBOITBR00EhN7R04OkxgSWkgQ7yRitXrgdrDTO0qui9ku0WEVLJsBIkfH8
	R/fDtGDHAYxMiHjjljWzEMW0
X-Google-Smtp-Source: AGHT+IG8C/qv1z/JD5ZieQDwZeJMvbfTCSGTAtSy1CTRYWyTy2m21IzsEjl2WbwBucOiaNMqveIN1Q==
X-Received: by 2002:a17:907:9707:b0:aa5:55b6:8080 with SMTP id a640c23a62f3a-aa620332febmr1230139766b.12.1733595979681;
        Sat, 07 Dec 2024 10:26:19 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa663334859sm87984766b.39.2024.12.07.10.26.18
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 10:26:18 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa64e1dc9b8so128315166b.0
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 10:26:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUffXQkx3ei8nL886bSLghjxwYlEyCBF6/H8xkzjQVz0gvS9Q76wpoB5KSIE2Y4ZDQ7evM/C6p2ru4v2xc=@vger.kernel.org
X-Received: by 2002:a17:906:32c2:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa6373494a2mr765427966b.2.1733595978237; Sat, 07 Dec 2024
 10:26:18 -0800 (PST)
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
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de>
In-Reply-To: <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 10:26:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
Message-ID: <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
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

On Sat, 7 Dec 2024 at 05:07, Martin Uecker <muecker@gwdg.de> wrote:
>
> VLA use *less* stack than a fixed size arrays with fixed bound.

Not really. You end up with tons of problems, not the least of which
is how to actually analyze the stack size. It also gets *very* nasty
to have code that declares the VLA size using an argument that is then
checked afterwards - and if you have a strong preference for
"declarations before code", you end up with *horrific* issues.

And even if you are super-careful, and you solved the analysis
problem, in practice VLAs will cause huge stack issues simply due to
code generation issues.  The compiler will end up doing extra
alignment and extra frame handling and saving, to the point where any
advantages the VLA would bring is completely dwarfed by all the
disadvantages.

We went through this. We are so *much* better off without VLAs that
it's not even funny.

Now when the compiler says "your stack size is big", you just look
"Oh, that struct should be allocated with kmalloc, not on the stack".
Boom. Done.

            Linus
