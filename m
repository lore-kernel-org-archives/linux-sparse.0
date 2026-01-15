Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620A29E0E6
	for <linux-sparse@vger.kernel.org>; Thu, 15 Jan 2026 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511975; cv=none; b=mX0/NMu/1R8+Q+TX1xEdkyJIHbdGtNm4Ml/8MdetfzZ8F2mmpVGWZfXiyYDm3iaVTLYX+PLZ3DwvgtifUBzKqCpIvxym0jLVggWaZ+oEqZAeHmb3lfLE7i9ow/N408NlxwkO2g1Pgzj3u4htx8SiPhroSV2rgajARVmHtILyVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511975; c=relaxed/simple;
	bh=H/W4U1c/44LXtxXQyd70ZxvTcYwMHtxm94LiqQ/7oxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qtd5m4xg+uF2sEnrZuGTNCBhIVkE7LryHtVL3ffebzj4+hI8OKWPxjKjIZIl7gNHkT6RBwwyUsfoqsskDAYeoVn0b1fQUGGD6Oo2Skt3WLDdaxZSpKyOwBxppplFpVLmKIuFtiQf+q+cYHPbUKvJjZenetsjnn5JLOPusMSZt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YIZI/lX4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YIZI/lX4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8710c9cddbso200050166b.2
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jan 2026 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768511972; x=1769116772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ+5+6W01DGjb02Z4c3S18rYFePAMoKLqDIVY0iRQwQ=;
        b=YIZI/lX4/8kMx0xpjnhua0d/S7Fp/dUPkVxbIP4K6bpyRFF1PidM5KzP7hAd1Vlx7e
         2ZtMnNQIi7HCj406GBn2F+0+WLzzjq3jDQ/7STI0CbF1BpAFgG9lGMm8gJ5FTacOOMji
         AU2q4Q8EV5cCzKBcIuab5jJQudc6iVfUPyXgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511972; x=1769116772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ+5+6W01DGjb02Z4c3S18rYFePAMoKLqDIVY0iRQwQ=;
        b=Zax0TjLjsmVxjY27KLrgDNd95oxkWcWpdPpjDwSWxvPqt7uW16xwcjPu4CFALoVqk8
         XLmg23tSy7oQHX9J5cdEL/Z5G9RX5UQKr5yO5zRuqywicKbPl+aZLqQfBFGwAbhV/ZQd
         T4KgghZsZyBwQKEBaFm6QgDP5d/6yC2B0B3C3j4WTwQ5RX1pamhP4auA5fFWAy3dZZDC
         F4TAC04NhAevHUBKyM+i7bGwAqfFOPgwJUS0WtHPbOIksEtpLWEPy11IBiFE5gAgC0jL
         WUAZVnij5exHO066WvBBpiApc/XjHBNjIawMNUqwxTtR/lvUdVuhfKVTPhdsAG/J5ARR
         pjbw==
X-Forwarded-Encrypted: i=1; AJvYcCWLyIhmkLLQb1SQvaE7jHDtmbKGcx4aEQVMPu5tklyUMk/bfGP8YevYDP4NcMvYbDCGLlMHnpIsly8352M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgsbljs09l3myynr9ght9cJJ+wawD9wKdKMJ08gG3Z3hJjX+pf
	lqgCz0eAOR3GhmgsxLHKtd9pOze2pQwC0qxXFZE/lavVhm5wc0aPMbci4RI4hg+AsoqviWhj/Q1
	USuSuH28=
X-Gm-Gg: AY/fxX7EUGFMjil54JEjG3BzSiZ3LfmSBCmitorshrgiNjpim/UJeY5aNC0O1VE0os2
	Uv9uKh56KZee1lIJpxx7872hRs3chJN7inZo40feSESc8bk7831gFuLo5vFZBsti8fBAf/4mYGJ
	YOMHpnO6lc07e2jKnW0IHLSdjfhDWvWm34dtBNK7ZYw0Wu3YZPUO1d3AiNY0sRbSrK2dHsGa8H4
	c6/8ZrLxwBEP2JLFk86fPVwWkFRXtayrPrFjrcJ4Dm86f2XmNgUNVymI4SJj7kjON1LIJPnPu1s
	sMBelpeEmcKg7WgQPCFT/NsHDAntWOUpfUi0xkKSMfoIPLdsyCRtG5STgQvyPfd4SXSTFn4Lk2B
	3DY6BSCqeTtsYx3AxvMDwah+MOfIUSFxpSMgJYz7Di7++4eTyZ+DG6Q4v70IdfT0pKasVTV4Y8D
	Sb2loldd4KsBIdf5gRAnQ/eYaWWhqMjiIs/En3MVFS/m/Rrl0x8vMQ3RwGLZFS
X-Received: by 2002:a17:907:60d5:b0:b76:5b73:75fb with SMTP id a640c23a62f3a-b87968b6b00mr29345966b.9.1768511972196;
        Thu, 15 Jan 2026 13:19:32 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795168c7bsm47158466b.20.2026.01.15.13.19.31
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 13:19:31 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso2199854a12.1
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jan 2026 13:19:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMClaylkO3/BCRR8GvpqcHmsHc6J45Zbg0Hzyfqbpsi24CMOc7BJZlNKkX8dV46tri9fd22LuIA+5AhiY=@vger.kernel.org
X-Received: by 2002:a05:6402:5114:b0:64d:ab6b:17e0 with SMTP id
 4fb4d7f45d1cf-654bb429f1fmr314654a12.27.1768511970977; Thu, 15 Jan 2026
 13:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202601150001.sKSN644a-lkp@intel.com> <87v7h23cb0.ffs@tglx> <20260115211120.GD831050@noisy.programming.kicks-ass.net>
In-Reply-To: <20260115211120.GD831050@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Jan 2026 13:19:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9pxiKm3kcZ0XQrFvz6fFek_A1WGqRh9yeghx3pE2d3w@mail.gmail.com>
X-Gm-Features: AZwV_QjxtpJnXoF4FXC-ZSzBPhKE8ZAnFi5EkPj7JRE0S180uTi4FtBplN8OFEA
Message-ID: <CAHk-=wg9pxiKm3kcZ0XQrFvz6fFek_A1WGqRh9yeghx3pE2d3w@mail.gmail.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	sparse@chrisli.org, linux-sparse@vger.kernel.org, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 13:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like so perhaps, which then mandates the very latest Sparse.

Ack. We want that compiler_tpes.h change for the real compilers that
support __typeof_unqual__ anyway.

Eventually we can just force that everywhere, but as Al pointed out in
another thread, we're not quite there yet (ie we'd need clang-19.0.1
and gcc-8.4 to be able to just switch entirely over to
__typeof_unqual__).

For sparse users, I think we should have the policy that we just don't
support older versions at all, since it just gets too painful.

                 Linus
