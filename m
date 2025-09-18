Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CE13B2A4
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229271; cv=none; b=qGZ9ZCXvJpsce9EfEoR1u+mebBXCBC2RN5sbX+V6ja5fXyBsJfs1E/+6pg2tN//UHtKNNfOFMGZ+8kVEsOpuVeWoAVIQhBMQJDsJ5VoGG7ElquBeTLhxsWz2No6g+bK5bpH7ZuHvtExyan6dF2F4Tb8fw0GWWMyCsqcO3Yp+oxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229271; c=relaxed/simple;
	bh=Y0aRlCDI5j7/xTKlaqyzsS75nTjo7oTyY2BP/Z6h+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ul8jaPuwshROefPuDQQGzimU7x9MpDvC6bUXOWY6Q0odcHIGBLw76KMZnyzz/c7eBVxYgLcibVRkwP9luMZGcned7wnvyzBuLFhxuJfPZNSa2OCKW7BuPXHaSsrgw+7WN8OVm0JNIw4/PhRHHxZxQNbhQeMc8MPNS41y87sX7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBnuifSp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBnuifSp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso15347425e9.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758229268; x=1758834068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8whsQSi0AUPF/mAlaYBaLE5rrzm7bWRBeC6D7X3U3TU=;
        b=XBnuifSpk3ERatLsXf9I1n3d+weXBrk//nbzYl2YvWKXW0boogqe/YfRJxT9iK0cCQ
         pW3L0MEYfi0l5pq0NzCFTPjuVrroW9a6NwqZZYgU0r3Y4Gl+T0FvX7V7IjY/hnoLOxo7
         qNdJtHRVcjQJydbAn8ym0HKYMssZf0NXeZ6g9M9cUHCldzh0puIyQFzpss68UCKUg+By
         EMxp2ZE0XUQmBAtW0WXxQKaVGTr6yVBBSj9bbFtEsO1x8nt5PLSvNuRt7Is/2FHKrXze
         kKFcNdytcjzZwbyPEirg+RIXA9KcIlwMEfQ++2ktTVQ5GSvMJBABt4csX5dqr4msPgDu
         iRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229268; x=1758834068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8whsQSi0AUPF/mAlaYBaLE5rrzm7bWRBeC6D7X3U3TU=;
        b=XzyOZDrGKt7HxW3nqBXEh/hGeZ5h+df5cBXXgbCDfJ7Dpt45on2+EgeOWeZP52YtrN
         A5Z8dwuV1kT25KfYe4k/7kNTSZWVn2ts3/+AV8BEQmu4GAf00L8T8WZHGcZTbfGu0KDF
         sGJn46LQYclOLpS3tnmTqVQun07bRNarJPsDsniQFbFHNVyWV741FfLUAEQTE9LEis2E
         etYTCW0iy6nfUy0lH5H1yNnbHYtMpPNRTiAy+TkVqdIQkIEWpmLQ00N7OW7rEnSFMBe6
         srXZdQOTigl6acLSJF3xU8bpL7OolbfuDNGhBdN7KCaoQ3NKpEKEn7KJmN7lC3S8jACd
         DdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv7e+PKs7Si1bu2qaA/JMFX/WbC2YZrTaBic6So2fIHNU5ycFc88fxuBbFJz+BUO/Qe2L2p5NeoIXB7Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaerkIftCZpTHUx/VoHjeklzd36amW2hjRUYk9k5ADJh3IyTUE
	RoVtEBLyDTJhoDdSu79mQ2xCdVXODvbWpwFmRtDssXtdXpADlIzizbfv
X-Gm-Gg: ASbGncvLrQ37QaJcp1Sl94G9E9tnN0o0iu5Y5I8YlxIZ9N6Hf/YNVkYR7UEfDUc67Rg
	Zvm45XBeNKuiPolX1C4jLBnWY6zYKcl8SsfC7yj0tHhDU0v42Djtfk4fawDbkflbkJexWAFxCqY
	DRByjCN3Hwh2Yh16S0gBXLB44UsCUwY5HTKPXt2nyV0y0LYaC4fYUrBSwyd1tJnHm/XtjUI2WV1
	ToSDztL/Um0euPQfYWAJ7iWcK3YmASEeRWE1MaLQFYalEr6YjkWJk41iS4pWeNai0+uG9lcpM+f
	lljFqDSefqvRLVCt39YN/RoBTle6k3aaFnsn2DCHJ2XTHK2dmigAKWwPAB+XwK0dZjxH2ZtPX8V
	/YT9gB3c5wEEmBkmujkR47o2o42s5d5EcaZI0lSeXsBg/nNi9ZFEb5v6lKY3HhpQK/4lEiM2Qn/
	f04tQ=
X-Google-Smtp-Source: AGHT+IH/ADFhHy8Bccvk6S8WFFJzSRKrYkHXLYxTkOPeKEac1vyUf8zwVY5kJnjDYe07TnRqWgVkmQ==
X-Received: by 2002:a05:600c:4588:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-467eb325534mr3872295e9.32.1758229267977;
        Thu, 18 Sep 2025 14:01:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46706f755b1sm24361325e9.11.2025.09.18.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:01:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 22:01:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eliav Farber <farbere@amazon.com>
Cc: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>,
 <mingo@redhat.com>, <akpm@linux-foundation.org>,
 <gregkh@linuxfoundation.org>, <sj@kernel.org>, <David.Laight@ACULAB.COM>,
 <Jason@zx2c4.com>, <andriy.shevchenko@linux.intel.com>,
 <bvanassche@acm.org>, <keescook@chromium.org>,
 <linux-sparse@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jonnyc@amazon.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/7 5.10.y] Cherry pick of minmax.h commits from 5.15.y
Message-ID: <20250918220106.75a8191b@pumpkin>
In-Reply-To: <20250916212259.48517-1-farbere@amazon.com>
References: <20250916212259.48517-1-farbere@amazon.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 21:22:52 +0000
Eliav Farber <farbere@amazon.com> wrote:

> This series backports seven commits from v5.15.y that update minmax.h
> and related code:
> 
>  - ed6e37e30826 ("tracing: Define the is_signed_type() macro once")
>  - 998f03984e25 ("minmax: sanity check constant bounds when clamping")
>  - d470787b25e6 ("minmax: clamp more efficiently by avoiding extra
>    comparison")
>  - 1c2ee5bc9f11 ("minmax: fix header inclusions")
>  - d53b5d862acd ("minmax: allow min()/max()/clamp() if the arguments
>    have the same signedness.")
>  - 7ed91c5560df ("minmax: allow comparisons of 'int' against 'unsigned
>    char/short'")
>  - 22f7794ef5a3 ("minmax: relax check to allow comparison between
>    unsigned arguments and signed constants")

I think you need to pick up the later changes (from Linus) as well.
Without them nested min() and max() can generate very long lines from
the pre-processor (tens of megabytes) that cause very slow and/or
failing compilations on 32bit and other memory-limited systems.

There are a few other changes needed at the same time.
The current min() and max() can't be used in a few places because
they aren't 'constant enough' with constant arguments.

	David


> 
> The main motivation is commit d53b5d862acd, which removes the strict
> type check in min()/max() when both arguments have the same signedness.
> Without this, kernel 5.10 builds can emit warnings that become build
> failures when -Werror is used.
> 
> Additionally, commit ed6e37e30826 from tracing is required as a
> dependency; without it, compilation fails.
> 
> Andy Shevchenko (1):
>   minmax: fix header inclusions
> 
> Bart Van Assche (1):
>   tracing: Define the is_signed_type() macro once
> 
> David Laight (3):
>   minmax: allow min()/max()/clamp() if the arguments have the same
>     signedness.
>   minmax: allow comparisons of 'int' against 'unsigned char/short'
>   minmax: relax check to allow comparison between unsigned arguments and
>     signed constants
> 
> Jason A. Donenfeld (2):
>   minmax: sanity check constant bounds when clamping
>   minmax: clamp more efficiently by avoiding extra comparison
> 
>  include/linux/compiler.h     |  6 +++
>  include/linux/minmax.h       | 89 ++++++++++++++++++++++++++----------
>  include/linux/overflow.h     |  1 -
>  include/linux/trace_events.h |  2 -
>  4 files changed, 70 insertions(+), 28 deletions(-)
> 

