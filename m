Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13518BC21
	for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606158; cv=none; b=UWHDyTtLrn73QujRRx3ucJUM/l8awN3l3/ibZFWyqcQ94YNIWtkaSP/OZmFBVI94I1WG2lpzWJjEbZ6s49eZKMpIfUhjUFw7aaTsn+2+tDIRrOuGqnv224zUWn5Iqm6xIvwrNPZEXpXtcZHQranRBUeElFhtjUld9NJx8aExBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606158; c=relaxed/simple;
	bh=mSaU8+k6H5UsTO/zFUXIvfBdXgPPqBH46d5GSShwijo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdzRVOo+Ls3APx7stwztwftEDveV0ST1hNIcsHMxg6wEhBXYeDdlUGquq2Bmw5zqYLbc4G/mkHBY3wZgYkkfP1VQWoHav2gtLm1Nt+Uq+aYv1gyZY6+lMZziyZ2jJXOBBloZaXQVyfmDxwKfRpLi3Tq8C1NXQMU4mKPnUR8eEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bTXmb0hg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bTXmb0hg"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so1428661a12.0
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731606154; x=1732210954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnfu4AuFc7Ir4mUZPIm/dFK37daLn9XyJCKqN5KNnKU=;
        b=bTXmb0hg/PSAmC5JWBtjYpMMEaOV4IgsFuz8JZLqQgGdds1y3Q2lPLMYcxed6kv82V
         moDTN9KnR3e3JENCgZHn97adJcvZHBk5jUjJ0TY6xCebEX3N2Uyz8RrJRHivfa98cFf8
         BLKmOthuarB6CBBRLQ2nQdNDEf4l5mBTfwW9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731606154; x=1732210954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qnfu4AuFc7Ir4mUZPIm/dFK37daLn9XyJCKqN5KNnKU=;
        b=roWGTMv1hsqooiJHtiu6EkWQUP2D3o4dsxaVwv2X7qfh1nBHm7rUPOIYN+tA5cf1VB
         59+cQeup186zMtJAcwg5RsVA7TeKPUDPf2OJi5+cXvnTrscMUYX7gZeCs9YibcOWcOaI
         rvI56Hb6IbqCvgpMPk3NG0FZSQvCV1wVeNIqynb7W4PzWr7WhZsdw8riSb32y0VLSFWV
         5s8EFXIQ6bzuOa5ALCE9AXctf+VheXkhSCHI0B98ld6vBZoUnnogbdoK0Xx92YmzHhVZ
         FlON0CMGhNZLdTkX2FTQleX9c9TiBxzKBdJutwfZJOV4awu3YMnvSRcYuDfI3M03fwaH
         /gXg==
X-Forwarded-Encrypted: i=1; AJvYcCXM2cbji0nBhoxDB9P/5Za/eQP1y+kre89RJs3KwwmY5etyTH4prbfAlMF0fUzOwQPjnEoh5DPQ3w/aTGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6BgNHitmL/R6ZpBdO//8jHSt78OL0JYm7Mg4NpmLsHSFLCNf
	iiYExtxYF635Ta/rGnsUTcV+jZz0tJCUJ4igRuDdZHFuW3wjSCrY4WRE8QGyQuBlCUvY+anjlW9
	kFiXQgA==
X-Google-Smtp-Source: AGHT+IFSwdnxkCpl/jgYOCqPE0RKoD8YLYsEODCgiOukTZQtjCcPNEJE8gFanBZr6Z6IT+4/H+Azbg==
X-Received: by 2002:a05:6402:2786:b0:5cb:7877:a633 with SMTP id 4fb4d7f45d1cf-5cf77eeb975mr2465873a12.33.1731606154089;
        Thu, 14 Nov 2024 09:42:34 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9faf4sm761747a12.33.2024.11.14.09.42.32
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:42:33 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf8593ca4bso646762a12.1
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 09:42:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7UX8bb6+3JjmscH23CtUpTESiIQAvwWcTMnrzzwED6BDKqYFao06JyO5lQ75pfij/KuETQvgDOlm5hPk=@vger.kernel.org
X-Received: by 2002:a17:907:9307:b0:a9e:b5d0:de6 with SMTP id
 a640c23a62f3a-aa20cded0b0mr291909366b.50.1731606152058; Thu, 14 Nov 2024
 09:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com> <20241114101402.156397-2-philipp.reisner@linbit.com>
In-Reply-To: <20241114101402.156397-2-philipp.reisner@linbit.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 09:42:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
Message-ID: <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Philipp Reisner <philipp.reisner@linbit.com>, Kees Cook <keescook@chromium.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 02:23, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
>
> compiler.h defines __must_be_array() and __must_be_cstr() and both
> expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
> So far compiler.h lacks to include build_bug.h.

The bug is real, but..

> Fix compiler.h by including build_bug.h. With that compiler.h and
> build_bug.h depend on each other.

I hate how compiler.h would include build_bug.h, which - on the very
first line - then in turn includes compiler.h.

Does it *work*? Yes. The standard include guards stop the thing from
recursing, and both headers only do create pre-processor defines, so
the dependencies aren't ordered, but it's really really ugly to have
these kinds of circular includes.

I think a better fix would be to not use BUILD_BUG_ON_ZERO() at all,
but just use _Static_assert() directly here, to make
<linux/compiler.h> be more self-sufficient.

The gcc docs say that __builtin_types_compatible_p() and
__builtin_has_attribute() both return an integer constant expression,
so that should be fine (the advantage of BUILD_BUG_ON_ZERO() is that
it works in some contexts that aren't necessarily technically integer
constant expressions - as long as they just evaluate to a constant).

We historically used to avoid _Static_assert(), but that was for
historical reasons (ie it's one of those things that didn't exist back
in the day..)

Hmm?

              Linus
