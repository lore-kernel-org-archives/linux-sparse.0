Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E053208CA
	for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467810; cv=none; b=svbJDn0pk4FDXDe7GoUIJfK1HLEeaLCqurwGHemAf0IhpJUdUPE48gv5uo4pUtjJFz+95fKQqD+xr1t4rMnNeZ4Z6YMj4ZuVUCgEA0wraawcPprQsvRyDFYDmntZKsKddcPofw2xujotZ2ZpJWiOw4x7brE4CC3Z3aK9bpagSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467810; c=relaxed/simple;
	bh=zPOso5hQr9q26ouxj3E1DFJoepkpXvPYEB5SQf9Gp3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTNVmj4xr4/JhkNLtQPfcVIbrnVIj7kSGoBr22g3cGl/zncyAWOlXi8L8NopU6HtMlH22u+HULK4S7OtixumJayqObKQMnHTWLztvLzITJ7+dcI+NpgyTITqrIdb3X1ogVAg/aoHWFh2UQmXRyoHdM0aMMApYiWVGAAPICRFuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IIebeomO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IIebeomO"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so3422974a12.2
        for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2025 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758467806; x=1759072606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dP1DiqunroxstlbKYeNs/44u8H/OIJeRshL6QeB9H8Q=;
        b=IIebeomOvD8qmJeCmPJDBcjLuO7CUsFmuKABYOTEEOKgBijcRj2R0xheksc7R+T2T8
         yiu4sONpQw6evlwRpG10yeTO7BvBlj7eRPTIKl11yvLc68/ULe21QPZYE+uP8u2kHbCD
         7Gn1z7KmIZkhEP96plHYTPkdpW7fQw8QZqiwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758467806; x=1759072606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP1DiqunroxstlbKYeNs/44u8H/OIJeRshL6QeB9H8Q=;
        b=rWru+lYadCusAGZoYlzOFzgywT01e1Qe4NcZAwgd6y0Yu5kusAPAeC1umtemU+iVJD
         fnY7fj2CUzkUjgCCkb0XxBszhNHXjvVi/Ov7XtFSfyrtBHPpvZbV9a9gE/NqkjchfOD3
         9T93UlTUPjYSfYsMCxAY/ZkzwRYlffBq+hEO+aDebZYDqmxrBNx1GlnL33VKssIlGJlf
         MZRib+dAMGC2gnTL+kop2fdXnk3r5+OM7lLtrm9Bo0j2vedL3WkFIysVgwV4YyShtsLN
         gER+GIfs3GxamRikUajmVaGAYJVkvRCMPVy2CHDYuvCeODWOMQM3wQ4XZebYt7VQ9FBS
         arJQ==
X-Gm-Message-State: AOJu0YwQz6AHdqF9FozMuusPZ5rbjgF+b+5Co21S9yeGpFu8MQqH06pX
	Pb+UzLpzdYc+HhoKHqyutv/XrJ2LqoUQ6kEAoDkfN+59ZADbvHPnbRjw5/b7dkj4nZ7We9vgA9j
	YqZY/vrE=
X-Gm-Gg: ASbGncuUVXs0bCfEH8Rg9D2ytsEPrEWyHIJK8Z1LYq1U8tp4t8XoMNk3+896ZJzOgbe
	JW0lJ0tvT/rsvLpBVdCvIIZhxIsYvSqXOuHGbArB3IPRt/vzPa6ASdYr2g8LLCb+ZySIz/c6rTl
	k71We9VheuWwF06o4+GCopxFvwTSki8GCG+EkciEluSc7EUei1UOb2et8jhcqfsf3EObFJEByom
	RuIAqiWAZ+jpbZI03A+7bzHyVHvicEdD1EZvGCK1/r49oLY4qo6Y3oOyibWad+1JswELGMD/ID6
	CeyAgj6FMRjhYlKccc8N4LxvbhRJTKiiv+QPq6PG6vcz5ZHE7+PRGbC9UFiw0la8CCvhQeoPYIp
	v5hjgOgv6ull08RBcB1S4gKs1A5ovC9IwHcbW1WBk46xCS+3bBrw0c8uK7HXoJoq8kciSUsqN
X-Google-Smtp-Source: AGHT+IEXfA78gdVgu1wLnzFMCmuZdT0Cwn6ce7oN6HNZSn4N1UkbWLqzSnZZ8l1ae4ptmkP1nDd8BQ==
X-Received: by 2002:a05:6402:90a:b0:62b:53af:78ca with SMTP id 4fb4d7f45d1cf-62fc08f8a65mr9086674a12.9.1758467806498;
        Sun, 21 Sep 2025 08:16:46 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d4357esm7337966a12.23.2025.09.21.08.16.45
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 08:16:45 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07c081660aso652936466b.0
        for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2025 08:16:45 -0700 (PDT)
X-Received: by 2002:a17:906:4a88:b0:b2a:7f08:23da with SMTP id
 a640c23a62f3a-b2a7f082899mr257865866b.56.1758467805264; Sun, 21 Sep 2025
 08:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921061337.3047616-1-mailhol@kernel.org>
In-Reply-To: <20250921061337.3047616-1-mailhol@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Sep 2025 08:16:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
X-Gm-Features: AS18NWAozDc5tCd6iMIkX_IrMP_cEfyRfSkdFRGU3YZwjukJ7fsIcoHoLCPu2cM
Message-ID: <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against zero"
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Sept 2025 at 23:13, Vincent Mailhol <mailhol@kernel.org> wrote:
>
> Add a check in sparse to warn if a value which used to be signed gets
> assigned to an unsigned and then gets compared against zero, either
> val < 0 or val >= 0.

Ack. I had forgotten about this patch, but I used it for a little bit
in my private testing, and it seemed to work fairly well.

It had some false positives too, but the ones I looked at generally
made _sense_ to me.

They weren't always trivial to figure out, though (nor were the
non-false positives, for that matter). Because sometimes the signed
source was fairly far away from the unsigned use that it complained
about.

That's why I had added that

        info(def->pos, "signed value source");

part of the patch: it still didn't always make it entirely obvious,
but it helped a lot when the value came in from a mix of macros and
inline functions, and it was hard to see what the source of the issue
was.

Even with that information, it wasn't necessarily easy, but it was eas_ier_.

But I only used that patch for a couple of days and only looked at a
fairly small handful of cases overall.

I felt it was *enormously* much better than the insane and completely
"-Wtype-limits" warning was, because that one warns for code that
cannot sanely be improved (ie the "fix" for that warning is typically
to remove a sane test that might be required in a macro in other
contexts or to just disallow some sane types).

Put another way: it looked fine in my testing, and it matched my "gut
feel" for how things should work.

But I didn't use it enough to really know for sure and then I forgot
about it all.

If Vincent has been using it for months successfully, I think that's a
good sign that it wasn't _just_ my gut feeling.

             Linus
