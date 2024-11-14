Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5418C907
	for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608903; cv=none; b=fN6/qZ98VZGXWIQqj7u2QQeOAA3fWrwEZUZD1yf/iOE2QviNW8XJgwsMQIlnARyi2jIPH0oDZw5gR4wDoI/EMA7pniWBF7sirHVte4XdYGPbhU13saHxmhJUw45j3l6aWFkuR2QqpwCDZ5pObzL9J06ArvsDJqULNiDBdl2uqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608903; c=relaxed/simple;
	bh=KCc0gSJuw6M6GZeBy+cbkCwwo7HpbQ8dLEdU98bWO6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbNSWf+8r33j81RZ9i3GbUUXpiF08wms9FlC5F6SDsXN2PusGxl4/5BhM7y4urLIAjwsuN66Ae+v5sjDl9BP5gE8nPwARlPJlx1AexmPus3+/sH/esmsM9koCGI3RXnxPYkYIO4VigZihP8/03J2+6tUAzFEpqCkedrkk6/tvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DvHfA7Dq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DvHfA7Dq"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so1332382a12.1
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731608900; x=1732213700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaqaoJAF7E7zv6sqRicq9V7Po6v7/UVcqTEzLTnHU3M=;
        b=DvHfA7DqYC2scy1u+OFbr0McJwUi7JJcahySZIHRd/Rs3biVZWbOle5Movg7TAUoVM
         NQwyhqVIaEjpimJ5GVth0xakvuslR9qH8kzFjMX5hcqD83ESQuR9b8EMPWS8NsdMRjTU
         hYsnS6WzblI5GWWLsnoICxPGr8QaLXUyc6Sks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608900; x=1732213700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaqaoJAF7E7zv6sqRicq9V7Po6v7/UVcqTEzLTnHU3M=;
        b=ZFCl1I/Sh8EjNtLQq18hIo0b5VEaAF5dQZj08SsAGBSnZu3EMeb6GkcCdTBR5jEp+y
         NMtvJD+jI8cKLeM8VdBHyF9Q7lulAORxuYG+MjKx0tC67ZQMPqNDiif7DsgTHtJ35eEC
         fxztHx3dADZzmvkYcLnBHuaWV/E4TWeYtO/amiSQltO0LGMAKTInDM3ZIS9/8uEQi2rr
         RYWBrjZE9W1cyflkAbi0u87hG56ARbDyaxZNWoQRY4e2vhTWvy1TBzcp+qbPzwlZ3i38
         S8jXCRP3H1XLoA4Vw7MPByVdqlDqCpW7cYA344FyMGsNwQ3DDeGrFgulpkMor+WYcpLi
         9Rhg==
X-Forwarded-Encrypted: i=1; AJvYcCWUfzlL5hwfq6IisKud9BpzDaOLtc0J8tYOn9qMwqmCFVtfrs8CLFuS659R56OidOfcKwZMAFu6RyT/xVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFy5HKqP5sgWadWiKc2D3uTDGJ8BTkeGZD1SBtbBZXNjK//C1
	8ihBW7S/luEoz4PD4OFaV1mRP7IDqNEXNf7301SZCdH1f0lG4g8vSaznIXvmHYhv6d7PxnEGjTp
	e/JnWiA==
X-Google-Smtp-Source: AGHT+IE2Xh+zVCE2iHQxFMzjV1P90LzEJrrP/XygPWb6+5zsWkZRKIhQSf0KnnirBGXp1Dsjteclcw==
X-Received: by 2002:a05:6402:13c7:b0:5ce:dde6:dd6f with SMTP id 4fb4d7f45d1cf-5cf63103700mr6803719a12.24.1731608899908;
        Thu, 14 Nov 2024 10:28:19 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf87e031a1sm287454a12.17.2024.11.14.10.28.18
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:28:19 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so1332342a12.1
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 10:28:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX00xqvSGitR/BvQfAHXBjGK74/V1L1Nhpebx14nDGejve7psTfGrHGr46veg2P+sWmkrP1nu0JEXYKcC4=@vger.kernel.org
X-Received: by 2002:a17:906:6a29:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa1f813b795mr748535666b.51.1731608898491; Thu, 14 Nov 2024
 10:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com> <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
In-Reply-To: <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 10:28:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
Message-ID: <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Philipp Reisner <philipp.reisner@linbit.com>, Kees Cook <keescook@chromium.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 09:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think a better fix would be to not use BUILD_BUG_ON_ZERO() at all,
> but just use _Static_assert() directly here, to make
> <linux/compiler.h> be more self-sufficient.

Damn. We can't do that, because we typically use this in contexts that
require us to return zero (because the assertion part of an
expression), and then that whole expression needs to be a constant
integer expression.

And because _Static_assert() isn't an expression, we'd need to wrap it
with a statement expression or something.

And *hat* we can't do in arbitrary contexts.

Grr. I absolutely detest how bad the standard tools are. It's kind of
sad how we need to build our own hacky BUILD_BUG_ON() to do this.

There's probably some trick I'm missing, but yeah, it looks like we
need our BUILD_BUG_ON_ZERO() thing with that crazy bitfield hack.

                           Linus
