Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAF1BF58
	for <linux-sparse@vger.kernel.org>; Mon, 11 Nov 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346355; cv=none; b=Gv+kQ5i4lh0ReSntFEcUfZhUi97wqjMXrnuYgPcYWhGB031bNnf5xsAIWcGHhP1J3uIkfX8vlj7isFDY8Nc2N0UNEvZpYeise0Pr+7XcGp1Ce7mtX0OSppiJRxufmyXr+RTZDoJ9E3Y//Il3G9SZ7TNpj9BFBx2eNwde3Jx1V9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346355; c=relaxed/simple;
	bh=PPNNsS1qLG2J+Yv0Mjv/CI33UdPosqw6oofwmfziC1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcuVkYc2meuZGqcZ/Dn2Zw7g+Y6z9cRcE/hvS3dQLKslNkFiPOOxChVMgld9muO1BVHcuhWFAz6YPEpYOAPqsCXznhjdvBwk5BqBusMR1oquiZ9iP8m6xO75ad+XocHxE07TBxoxyJNuy27tmABxhuyjQHIJI3Xjp4sEmDmfLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LnZDFPyh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LnZDFPyh"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso5347965e87.1
        for <linux-sparse@vger.kernel.org>; Mon, 11 Nov 2024 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731346351; x=1731951151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMII0Va/Pc2J6Ok+zfB4lxRXeg8cQiz8GFTVesocEWU=;
        b=LnZDFPyhtV+aWaJykuKIudODpOk2BzPd5YBypID2oC217006ZjtUCxTg1lbIqEcy3w
         qOP2AhWdPRrGr4Ph7QCP4G1MKxJtlMdbUKFzGYYofaMeTPxCiPfgTOdfVSd+9CHy5Z/s
         c9BJLApSpaifXaHLLoe57Uf4s12sKOhpxd7L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346351; x=1731951151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMII0Va/Pc2J6Ok+zfB4lxRXeg8cQiz8GFTVesocEWU=;
        b=mcg7kY3avVXoFMR17bFgQPTYWmByKSOLIR6NP6A1NWLPVn/PlRyPh3/5Wif+TgAPey
         92IpZUiaqBtuLIOlGMtsHxxNDEMXk00ht/+liBsRm4MPyw1Jne7rGSOUikPSjRpEmrAK
         5rkvPwo9pB8/m1Kg+6eZz28/g9DuZiHjGv264J9wy/WDtLCb7yZdxVU9qsNwNfg0MlLb
         +v921s/QkYthhXjvkWB2YSJdkcB4UxntlRSFbkBNku3mfSJW4OBTst4DfGGskMdWaDDj
         HzlowlvC4cu3pyDOI6VBEUnCWYCt1LVUKe+gf5O1VWg79WZU+UaXv73u0SrCKQHH8234
         xxuA==
X-Forwarded-Encrypted: i=1; AJvYcCVff/SMJ/8CzPBbotJoZjT1EZFvDRQQcvEA/fQIzaJIJDvNgQVduZIVf+Pu0H79R5GYa5IPnYs68mUUXdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZbyTLya7Ni5m26jLjRhk+fr3Ub3HdWgZP26dHcV9i0KIMWZ5
	C89ij/QiTCMRPZLlBV7Iy2xJDABgV5q3NJKRea/V9WffupGebgWPJ4oZIk5oPkgBqvmVh74buYG
	X6j8=
X-Google-Smtp-Source: AGHT+IHZLxrQ8y9ONL2Cg1UAPXpAwHJoJvcMhzjlgyv7NHHmeEW+HC0/K515gO3WGXSW6nCDWyjI6A==
X-Received: by 2002:a05:651c:1026:b0:2fb:411e:d979 with SMTP id 38308e7fff4ca-2ff202e18e6mr50909551fa.31.1731346351387;
        Mon, 11 Nov 2024 09:32:31 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb765asm5163121a12.48.2024.11.11.09.32.29
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:32:30 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso697546466b.3
        for <linux-sparse@vger.kernel.org>; Mon, 11 Nov 2024 09:32:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkqRFyHY/Rl1m/K839JEJ7SgtAvXGZqb0zeUkOT7UlgOgYVW4cGPkkGI3kvzJ28lSLc8v83/u7xixSCdo=@vger.kernel.org
X-Received: by 2002:a17:907:9494:b0:a9a:597:8cca with SMTP id
 a640c23a62f3a-a9eefff1308mr1311580566b.45.1731346348977; Mon, 11 Nov 2024
 09:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111164743.339117-2-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241111164743.339117-2-mailhol.vincent@wanadoo.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 09:32:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5SNYdgx8-X+ggHP+ojbG2F7oyt3TLmMgqejYd5zn0Aw@mail.gmail.com>
Message-ID: <CAHk-=wh5SNYdgx8-X+ggHP+ojbG2F7oyt3TLmMgqejYd5zn0Aw@mail.gmail.com>
Subject: Re: [PATCH v2] linux/bits: simplify GENMASK_INPUT_CHECK()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-sparse@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 08:48, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
>    - introduce _statically_true(), taking inspiration from
>      statically_true() as introduced in commit 22f546873149 ("minmax:
>      improve macro expansion and type checking")

So I really think this needs an explanation of what the difference is
when using __builtin_constant_p() vs using __is_constexpr(), and why
the existing statically_true() didn't work for you.

In my experience, __is_constexpr() is too limited, because it
literally requires a syntactically constant expression.

In contrast, __builtin_constant_p() often works for things that aren't
constant expressions, but that evaluate to constants at build time.

For example, I had a test patch that used statically_true() to do
things like "if the size of a user copy is a multiple of the size of
'long', call a simplified version without the byte copy part".

And sure, __is_constexpr() gets it right for completely constant
arguments. But __builtin_constant_p() will actually trigger not only
those, but also when the argument is something like

        if (copy_to_user(buf, values, n * sizeof(u64)))

because it sees that even if "n * sizeof(u64)" is not a constant, the
"is this a multiple of 'long' size" _is_ constant.

IOW, I think __builtin_constant_p() is preferable, because it not only
doesn't expand to the horror that is __is_constexpr(), it also
generally does better when you have the flexibility to use it.

Of course, I do think that the use in BUILD_BUG_ON_ZERO() requires
something that is more statically reliable, and so __is_constexpr()
that is purely syntactic is probably the right thing to have. So I'm
not objecting to your _statically_true() per se. I just think this
needs a big comment about why we have both versions, and when to use
one over the other.

                     Linus
