Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333202F0687
	for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543056; cv=none; b=SR5oPZqgFfCAfcNOUdbZREX5IjmN2R86h/A/ChqUk9RN5/bPnp5IA5Qla1NPnsxOjxwZv3aRjKqnuVKHKCv1jO/lNrc5lj2E/PaI39ERB3T5xTxoIrA8jWdANwUoUx/TnzFtGuKvyuIwvuU/vWb4A9SMYA0a3q6a2YBJier2TIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543056; c=relaxed/simple;
	bh=gB+SHkjWfedbzYpDMVBiKULC5VtGnLhBBS9nDA7fAts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3ZtUDdfegZfpzu0kP3ad5E8TfReJ4nFx1dLCTHrDR4v0BlxaksvZ/B/8fKqn+p5/1a0B/OF5yYe5JjB4c7QeQyCgRBD5DlcK/xupSIxfnmlcEv9aQz8tTTVdGirxhe2Xbq0upmq/BkyrRUYJQeAE6V9qxGW0xdS2VepdjrhVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96c48e7101so3457633276.2
        for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 05:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758543054; x=1759147854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Upd9A/TyVYzX336KA4+3asnCpUMKeK3k/cdViZQCDUE=;
        b=AqmBc4IyNvzvj8r0WIDlxLgo1uuxEyreB25jpAOvNfD4OegG/Fz+cs2zu0f3X71Alu
         i2MsFBIJfItNrc2EA67sSb/n72IQNS7kA2Uq09kCyUdjcl1Iyr0muok4xvCxJrpv73fE
         dtxGHC37Xi3fbE1mmnvp4QfxALIWGxM6Rad40vlItZjGlFBq1yRisG0Be1Afcmvktu/N
         ubfEMWs+V5z0e8dYFrgvYSqV1lyVskUj6n6dIt6ZKomu/fV3qfmON/dTgWSMZPqFCtnI
         Xq9yYPs9oYrZdD4u/qnTjbrkCxBFR3Qb7PuL3pBOj6I00ipjHEmq+4fJ9KYG64Ug+Ikj
         m/fw==
X-Forwarded-Encrypted: i=1; AJvYcCVmGJJpWCHQNsAouNsMHApq9d51jSWCwfe3acjhP/jGBGem9K4S2k/2WeF3TqDPhbjkjhrMRixOOiD2Cvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0e4K9ofyIiq7SQL50ZXpO3TXZ6+UFx3btkCWApq7m9lhdHds/
	jut2Cmkkq98gzXg+egpWfR1mkdqrqNhtl9yhrpEQHZTFCwAHMeXtEKckwR9zDhMOskMFSZLZ/34
	VQSyFCDqwUlQxDXrIqE1T30S3/il/F9c3FED2lW48m93dHzOOVOXDllsAfTZW
X-Gm-Gg: ASbGncvw/ygCDNcDoiBj0mjHwjOixRxVLSs0Vi5TdmDp+Lkg6TI+guhKjuUvRhvsgK1
	4NsVkMA/yQcHQolk6CCwjHuC5pUXTaEx31now/PmYRMynpb67LVuEBSQjWnXnrUoZOv18iBtDcy
	CkFW0Onbxq1kqWKVk4I1QoB+gMinEV97mwuJcFbrMf6P+IUQyiI0KNq4tRj8qC7c2bdBnIlkuUS
	RF99g==
X-Google-Smtp-Source: AGHT+IHEWmCC/4oti7ZKQT2k0qQGWynt163iqw87WFF2iZ358uYnWE5BNRQaM7lL8q6CN50JVCpui6n/iNexacLEwSs=
X-Received: by 2002:a05:690c:3347:b0:736:355c:7a0c with SMTP id
 00721157ae682-73d3a52ac24mr114001897b3.35.1758543054193; Mon, 22 Sep 2025
 05:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921061337.3047616-1-mailhol@kernel.org> <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
From: Chris Li <sparse@chrisli.org>
Date: Mon, 22 Sep 2025 05:10:43 -0700
X-Gm-Features: AS18NWC2zvpNrVExoXkINAwZZOL9-adjoV6fDZLvw_K1P6iegaV4oQI6iVBGCps
Message-ID: <CACePvbVYFNANx8pi9v85FHMGU3rtN4zOmnqSe-Et=s8ngh0Ltw@mail.gmail.com>
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against zero"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 8:16=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 20 Sept 2025 at 23:13, Vincent Mailhol <mailhol@kernel.org> wrote=
:
> >
> > Add a check in sparse to warn if a value which used to be signed gets
> > assigned to an unsigned and then gets compared against zero, either
> > val < 0 or val >=3D 0.
>
> Ack. I had forgotten about this patch, but I used it for a little bit
> in my private testing, and it seemed to work fairly well.
>
> It had some false positives too, but the ones I looked at generally
> made _sense_ to me.

I think the false positive is kind of unavoidable there. Detecting
such a case can be equivalent to the turing halting problem, which is
impossible to have a perfect rule or algrothium.

>
> They weren't always trivial to figure out, though (nor were the
> non-false positives, for that matter). Because sometimes the signed
> source was fairly far away from the unsigned use that it complained
> about.
>
> That's why I had added that
>
>         info(def->pos, "signed value source");

Do you want such a line in the final patch as well? Seems worth it.

> part of the patch: it still didn't always make it entirely obvious,
> but it helped a lot when the value came in from a mix of macros and
> inline functions, and it was hard to see what the source of the issue
> was.
>
> Even with that information, it wasn't necessarily easy, but it was eas_ie=
r_.
>
> But I only used that patch for a couple of days and only looked at a
> fairly small handful of cases overall.
>
> I felt it was *enormously* much better than the insane and completely
> "-Wtype-limits" warning was, because that one warns for code that
> cannot sanely be improved (ie the "fix" for that warning is typically
> to remove a sane test that might be required in a macro in other
> contexts or to just disallow some sane types).
>
> Put another way: it looked fine in my testing, and it matched my "gut
> feel" for how things should work.
>
> But I didn't use it enough to really know for sure and then I forgot
> about it all.
>
> If Vincent has been using it for months successfully, I think that's a
> good sign that it wasn't _just_ my gut feeling.

Yes, I applied in my local git repo smoothly. Just waiting for the
test case now.

Chris
