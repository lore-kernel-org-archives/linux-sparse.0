Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F82DA765
	for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144318; cv=none; b=EzytWxLLcOEhbr9up6KdVpmQufMyqsiJ+ia0HkHachzYznd7Uo7M1b6/tmGwZ0j0XRaDDMU6s2kB+AiA5h0ZCgaVusmewZkrFL+7IDa/ZsuV2Bsao8pgGC75OzhE9X5fK8GqKJxNRy876iuSKXRKtRX+NZTPR47wE+Q4miJe8zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144318; c=relaxed/simple;
	bh=q+G6p9rlYVdF4IAY15DAkNeh78dBDH2GAlKPgkYV1L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEClnBtwk2JqpMIr+WdQEK3JsQFTRfmZh0otnR0ObeGu08FvHtsKBUBWR2LrBYlgOrVrelSXwgQ/knFsLQdA8mEybtB42W1VAsoB7LPSfjuhRzMT56b4ARORk0o2QwGbCVDHWV+KlW7J34c+RskWo1W/yZILQFHqD950hpew/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WRUnsJBs; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WRUnsJBs"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e19642764so1940048d50.1
        for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 10:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763144315; x=1763749115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RchFDA63Jl2Lp6o20oDSql3FkElvmeYALm/OMSMHBI=;
        b=WRUnsJBsNMBs1DL2X/Kf7B9e+Bj5EZPRhet/0A3+RubCKntB1duM6OpJdJh6jKR8et
         xuqaVSld7UI+1rpiU/nRtYN6+qrdhtGNTOf3XiL4w7fZEqs5korjE4754y+YO3Dr4hFI
         9jLqogGxdR0NzlppoErl1ZQeJJd130mJhNQzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144315; x=1763749115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6RchFDA63Jl2Lp6o20oDSql3FkElvmeYALm/OMSMHBI=;
        b=J+D8XBtIw3pp3W6f/8LaN4yR3fYiXLNr53N6JJ88qUONoGGWsd2/X/vkFLdj3v9km1
         +O6RVE3YtiKipW6cw78LrMTWsLi3dy06AKl5q54Ha2GjLFhMTmn8QqT2Jqabo3mFFL7J
         3XJywScgMV6nA1v442ikmCEkrJ3Oh3cNobDm2LYucm5AzSQHQ4weJevy6fVVH84JIUYu
         23CTauXYT4oTgoemKN1GqfBaltlY1wyuH9KgpHHabpxLoJC50CRuVk2hgDyL78ndxHsN
         yRW3C7FYIIAvb+ckqkizChQ922YneijechDA0utmTFqUtYWV/i8Sa49rAsMb3anVw++t
         sTqg==
X-Forwarded-Encrypted: i=1; AJvYcCVtuS8VN0sMQ2f66uigBSFu+FI1cZFonTczWlBSnmLsPq7/1Q5ruqvV/3zQTh9iRJ46elkNdA17Des0Lww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9wNTCu4S7snsuMxJV72W6NFDCJYQCmEtdOSI9lcihtTXmWDk
	Q65yKczZXt5Q9mO6AThkOfjjHKhhMfC44ybymVsfU57BRUUHFjXMxeN4nujt7vjrewFtOvD5gU6
	hlm1PWPPQpAh9sq5uWvR9bYwsgYtmRHx+5NrE3K6EJQ==
X-Gm-Gg: ASbGncvoPa2NDimuGooROAhUf9C8Ba15+xShnAdlMbAKas48cxyDa2IDxNwtMW3LU1Q
	NL+DmVhk8EWO8A7H34PHCFi9zCE4rYIQPXdELBmFaGvbTsMQSutUQgDd6JqnXAZLnrbh83u6ocx
	HwNYY/+GozPkxNdB7LQz1ptQI6kZc2i2d5urNVzrbZhcv7Tcvj90qJ4w4qu6KExowAl0Mg6c/zL
	IZcWSeK9AvMXkKeHVTqg5gbjMDLKNsUsDuYXZ0+C5hfkuu4htzMNy8zSqiFopGu/A66kf4pm2uJ
	OS5vI2xKECA1GUUG
X-Google-Smtp-Source: AGHT+IEkrrkkDCPBST2SSDzieRk/7lHjozCohOP4iZxzRJLyNlSuNDKsPOvPXofON9amzy4eOciLaHdtAeIIvM6ecKw=
X-Received: by 2002:a05:690c:6e08:b0:786:5620:fad3 with SMTP id
 00721157ae682-78929e15d08mr41201237b3.11.1763144315285; Fri, 14 Nov 2025
 10:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114055249.1517520-1-hch@lst.de> <20251114055249.1517520-2-hch@lst.de>
In-Reply-To: <20251114055249.1517520-2-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Nov 2025 10:18:24 -0800
X-Gm-Features: AWmQ_bkVV8Sj_GIT8Ewq_zzysvsvBXQ2TETrcIO1MdsndiK3KIFex7SyIgpCoiw
Message-ID: <CAADWXX_ORdj=PaW5oeMybV6sEV6UxbZnRw4=TDZpa1Ejt0vbJQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] lockref: add a __cond_lock annotation for lockref_put_or_lock
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, 
	linux-sparse@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Christoph, while I have some minor comments on the patch, the
primary reason for this reply is actually that this was in my spam
box.

  Your email sending is violating DKIM rules: your "From:" is
"lst.de", but you use "infradead.org" as your SMTP server, and the
DKIM signature then has d=3Dinfradead.org as a result.

  That's a so-called "alignment" failure, and is pretty fundamental
and a sign of spam. You can't verify that an email is from a valid
address by then using a different domain entirely as the "look, trust
me" thing.

  So your emails all end up with dmarc failures, and then are much
more likely to be marked as spam. ]

On Thu, Nov 13, 2025 at 9:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> -bool lockref_put_or_lock(struct lockref *lockref);
> +bool _lockref_put_or_lock(struct lockref *lockref);
> +#define lockref_put_or_lock(_lockref) \
> +       (!__cond_lock((_lockref)->lock, !_lockref_put_or_lock(_lockref)))

I don't think this is wrong per se, but rather than rename the
function, I wonder if it wouldn't be simpler to just have a

  #undef lockref_put_or_lock

in lib/lockref.c and just keep the same name for the function and the macro=
.

Macro expansion isn't recursive, and having

    #define a(x) something-something a(x)

is actually perfectly fine, and something we do intentionally for
other reasons (typically because it also allows us to then use "#ifdef
a" to check whether there is some architecture-specific implementation
of 'a()')

And yes, you do need that "#undef" to then not get crazy parse errors
in the actual definition and export of the function, but it would
allow us to avoid yet another "underscore version of the function".

I dunno. Not a big deal, but it seems annoying to make up a new name for th=
is.

            Linus
