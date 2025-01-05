Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218335957
	for <linux-sparse@vger.kernel.org>; Sun,  5 Jan 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736113903; cv=none; b=EwyQg9mGHL14G+mYJrvgPtg/h60mot9eXOOKMLc6ma0bhsxlD2jWLMjbijhuwnAARMZlSZ8eleR1ZYWCGgxEn+SYC9ussFx5Vt14liF/IMVf/VJdxmYc6QrPGm36LutiY/OkwIc1aDBJyaMT9Kkj7iVSyWsJgAuYotR8CRu67c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736113903; c=relaxed/simple;
	bh=+Iv4GzdSfyP/K9u9CoJb2eqJJr5fi++CFIMk1H2xTVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlH92FeBdvTc65J9QKKBcGjP3n61vioaBjNG8q/w55i48WAFf1wrJZwC6/AfZE2IZFbXghER0SwZ0qd7hW/hSDrWJ82QsQ2+70vy1sXv4xw4C3ZzvVcEhF/JKoYJH9JdM+skMep0FzFi62yZua6UTolxaC/SxQXJ1eqGw6oMXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CWZ351ne; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CWZ351ne"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaee0b309adso1622499566b.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jan 2025 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736113899; x=1736718699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rpmRkGX5eC8WQcFjbwo5fM+X4EHi5ZBIwXmu7JGQna8=;
        b=CWZ351neCQzpfo6eu5pXmf7DFqKEjBHa00Fc1ZPt4+CwobAtUKhB/yZCkkW2UfJZ0v
         k8bbADBcj42W/KMqCxqezysOG+3KFl1MFz/g+xlVNM29mb39C96JfzeybjV/EZ76Wpnh
         TrDQa8WS/JWOK2Gs9u0QNXnYmg+2mgGEYcWg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736113899; x=1736718699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpmRkGX5eC8WQcFjbwo5fM+X4EHi5ZBIwXmu7JGQna8=;
        b=lHZ8sJukiqGZcGWScqkapIpMg3hghyk8UB8L+r00941RNUOBlD7u/5zlaSLaGbSv3s
         F1XWv0HvmERMOb62HIiM/fqCT5z/mPZdO3LL7dcQ5voMa6mz8CCFcBGMRpdKABizTd+P
         znxmM871FdJTiaEcNKFGOMkTUPaKyYouTLMTiVWmqUN4HpuP9oseUk8izvcbgrcW9Rlw
         7squV9BVyqN3jQLZAeY0Go/5DbIO5aaxQnR6vWxTKMoEmZsdnxcjpj787JwiUwsJOPS5
         WkRqwJMD1SeDMUZbeyf5h3PzlCpzxlIGW+vopIZZ87I3ECceRDC6Hjj8RTbz8Q6bNi/6
         lhsg==
X-Forwarded-Encrypted: i=1; AJvYcCVoJggpkHHJEy2ZIqNVWdBcZP6Px1bbPXGlUExQPjTLSO10XR9Ro/ksOSGcFNCvI2pN1UEXp+PkT/RtPhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4BfNwsofC33Jc9Fgmo27wxmtM72vjjkrtfLmlyUBs+zo1nzd
	0mkD6VrUyPAHBFlOLjzDMv3u0GN6ManzMtLSux6u0jKquQ3ZGDkVhr5llqZGdYwXtdDVhZ9/f3G
	InBs=
X-Gm-Gg: ASbGncvlQBvEnxoIiMO46H+9k4Gh/fkBf9U82TRdvI9zVWWzq1wQaboliopQD+LB+OJ
	vjYNYKvyjjNsYj1AY5IcmfS5AZ+PeNuvgIqsinzSytXFdqc3w0cirZ05EuCeLESjhHcMrWnn8EY
	zqqmSxRe9TFGKKuC7LHXyWpvTki+aD7HEaPWgKqhaXd2BfKn9hg2WxD23Qh2FcfvxT72uijDsOv
	2Qi16qJf6T+uSbQdjB9sWqO1w5V1TB9X73lOyFkxFIS5Wbqw/ImquDxI3bxkK0D9+qBp6vUePOO
	mzz8cu3NVjfgFEEBpQ+ZVbTqyssse+8=
X-Google-Smtp-Source: AGHT+IFEkn7uHHhNETCljov9PQQR2Vo052mRw706sMsrHTtVQyOXjHzCYS+Z9f5T4kg6a2s98azqUA==
X-Received: by 2002:a17:907:3fa4:b0:aab:d8de:64ed with SMTP id a640c23a62f3a-aac2d3278camr5719006766b.25.1736113899241;
        Sun, 05 Jan 2025 13:51:39 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f31bsm2157495866b.1.2025.01.05.13.51.38
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 13:51:38 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so2291890766b.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jan 2025 13:51:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVACG97drsLBNSN0t9A2+jlVQq3AgbTiHlTUOae1v/cPdj1geqLTbwxT3XbkvLjzupqDY+1OGbXAVzUXmM=@vger.kernel.org
X-Received: by 2002:a17:907:728c:b0:aab:9430:40e9 with SMTP id
 a640c23a62f3a-aac2d420441mr4954091566b.32.1736113898164; Sun, 05 Jan 2025
 13:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501030516.uZrwnuQQ-lkp@intel.com> <CAMuHMdW-DYPp_2nAaBdvgoa6Yr9et2cNS_260H-9H_CT4yEasw@mail.gmail.com>
In-Reply-To: <CAMuHMdW-DYPp_2nAaBdvgoa6Yr9et2cNS_260H-9H_CT4yEasw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Jan 2025 13:51:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4tYCytRshQGkWSNmZS=59PtKEUpG7f4Sy_46n+WYtXw@mail.gmail.com>
Message-ID: <CAHk-=wj4tYCytRshQGkWSNmZS=59PtKEUpG7f4Sy_46n+WYtXw@mail.gmail.com>
Subject: Re: [geert-m68k:master 2/2] lib/muldi3.c:53:28: sparse: sparse: asm
 output is not an lvalue
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kernel test robot <lkp@intel.com>, Greg Ungerer <gerg@linux-m68k.org>, oe-kbuild-all@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jan 2025 at 01:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Perhaps this is an issue with sparse?

No, this is just m68k doing disgusting things that happen to work with
gcc, because gcc considers casts to be lvalues (which in turn is comes
from some horrid C++ thing, since in C++ casting is a whole magical
extra complexity).

IOW, this m68k pattern is horrendous, and sparse quite reasonably
complains about it:

  #define umul_ppmm(w1, w0, u, v) \
    __asm__ ("mulu%.l %3,%1:%0"                                           \
             : "=d" ((USItype)(w0)),                                      \
               "=d" ((USItype)(w1))                                       \
             : "%0" ((USItype)(u)),                                       \
               "dmi" ((USItype)(v)))

notice how it has two register outputs (the "=d"), and the destination
of said output is not a proper lvalue, but a cast expression.

I think you could just remove the cast. Afaik the w0/w1 arguments come from

#define __umulsidi3(u, v) \
  ({DIunion __w;                                                        \
    umul_ppmm (__w.s.high, __w.s.low, u, v);                            \
    __w.ll; })

and __w.s.high and __w.s.low are from struct DIstruct, which uses
"SItype". So all the cast does is to change the signedness of the
variable, but that has no *meaning* when you assign to it and the
sizes match.

Alternatively, you could just use the right types explicitly and write
the umul_ppmm() macro something like

#define umul_ppmm(w1, w0, u, v) do {            \
        USItype __w0, __w1;                     \
        __asm__ ("mulu%.l %3,%1:%0"             \
                : "=d" (__w0)                   \
                  "=d" (__w1)                   \
                : "%0" ((USItype)(u)),          \
                  "dmi" ((USItype)(v)));        \
        w0 = __w0; w1 = __w1; } while (0)

NOTE! UNTESTED! Treat the above as a "something like this, perhaps".

              Linus
