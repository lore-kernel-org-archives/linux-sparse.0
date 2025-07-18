Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196E1C862D
	for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875404; cv=none; b=hf/hqP/NQ9SV/lohpIbolDnuPoXQ6/k0m6C+nH62qAvXhLAGOmMfCXB0UM9bYy2t8aYxmiHcOOQQOsmzYxoU187V9IyATFsJTf+sSV18l++mPbyBSIxJhnFfVE/zOW7rEfP7I4XKqfFQJ3BuiwsfOU8cZtyGomQrqdeuA2345YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875404; c=relaxed/simple;
	bh=ltKlX/6V8eiGzqwSGoa5gPUbAJICZza9LmiBT1RB0UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NObx5fx91LSpWZVRPOChpqb8/yHhRHhFvjLpelSlvAyxHYQbzq+dNIPT26B9fhd8Czdk9BMNSsKEXPP6LQ2tCMJVIWKUwnjysrUXARnimrxbDQamNLtQv4NgShNTCkTglFlF+rMQ7ZtY9sXhJlCuhWv8da2C5swQtPV2McjBYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=APZLIMPU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="APZLIMPU"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so4025309a12.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752875401; x=1753480201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=APZLIMPUFjefReqtZfijKApI+3OUjRLp3GbM2ZKeqmvTAa+ZcaDH/qpzwrCml8v9s3
         0oKyL8vaRzpDW1VmPBvRO9nnw4RsIh29Vv0x6T+RoerKCAYjro3giCWG31eLLrTzbudN
         gToEqpO7xCLb2qsnise1az0Qg01yjONOA71YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875401; x=1753480201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=KPehv7B0fSqWgCk4wUzHyLUKtyWp5Mr3JLPtoK6ETNZeiX8fH4uPCxGTbnC4dnJ2DP
         ncIH2oAOWwaTA6KxfgaXUieD9GbgC2CLh8q/W38MREbesMbFFNoEk3V9OULeDFGpeder
         qZF216sY/EVbP4hablzz/gitjjZ5azILf0dHvpRfjOmrcZHWlXnKnls9B2ULXKARqaHv
         f/8g+hApBLwtc01M/wV0htgn7OGImrImxWGjRACWlIBg3DYEcyHzz21EJZ4LmLwyyjSq
         ayChfKkP5SySHiMJrhYmXSJRxtattXc4UhHIBi3mQU25K9p/dtfN5uiQoDTUpGNcKLrs
         JC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUr4Hj+DqNOqbBUhOOD2KRXDoWfIn56HINJMQfVlVtGzr+HlDXFSE5oBjupgGlL2mSC9mPCecAmhBI+CaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywirvxa0L9i85cVCo0UxtZ7oRyTXCGNaD0+ELc8Yf6EqZHTLXjR
	Qr0jt57jhHgTtaCUFrxrLuuseFUzOx/GykX43IXaL7aHzNLeycJk49mHnCZMtZtypQkC8iPieNX
	vEbWLsYo=
X-Gm-Gg: ASbGnctMBLXCbkh+mZtdRyHt2o5zfz/kLbvjeR629/zyvLaq8ittJEX4EZIFGpSYbzI
	3a77N7K6+0BBKRPoAftOR5fAMs3P5JEW2WdcQsgAKX+tTyZHZ5oHcHfVxcfYShmvoKtPXok+yP4
	lAxBpLmmYsK9oM5BNbaVEHaxh+kJA/unVZI7knAZTcssxzIIFnPQWt8j0K64rW+a9jVj770ngBT
	pdDk4joBgKHGt1jPMUJKdPbWthzftG23O/xxN3s79oWKYhp+KCBBPInPRqM2z6GeLoDv81OMK0M
	FdXfrAuoc9K8iU0MejP8Rcy9BeTmtH+u7ntF0AbwqP67VdnnGFBdU2yfFBYMwW69ELcQ2otveAZ
	HQ8Ul6xnt1IJv0FgzIBXjy3dQPDc0g7mGCGj/sekivlF4k7EDHdSiZPcdOrHHH8XlYum4/ZEf
X-Google-Smtp-Source: AGHT+IFqMN4J8vt8uMDivPkqv/h03vTwYU1wo+7xitn7E392akH6s5pNA85g0bHZGjANo9iTGS4z/g==
X-Received: by 2002:a17:907:3cc4:b0:ae3:cec8:1c7e with SMTP id a640c23a62f3a-aec66017822mr476145066b.20.1752875400871;
        Fri, 18 Jul 2025 14:50:00 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c795282sm188479566b.6.2025.07.18.14.50.00
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:50:00 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so5559938a12.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Jul 2025 14:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAp4XC/xIzI/h970QH6LBBZyDfYvseGbpw6zcAxi2aQnIqCj33GSJWRYRAi6GpV9cipal5SQEhoEbF9r4=@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:60c:3ecd:5140 with SMTP id
 4fb4d7f45d1cf-612c0091a9amr4324302a12.0.1752875399525; Fri, 18 Jul 2025
 14:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
In-Reply-To: <20250718213252.2384177-5-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 14:49:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Gm-Features: Ac12FXwcle_QXTMWRdj0MWMkwuJCKrti8An2oscUa99HJ5SDjVBQa7FesoFMBkk
Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
>
> -       __auto_type __pu_ptr = (ptr);                                   \
> +       auto __pu_ptr = (ptr);                                  \
>         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \

Side note: I think some coccinelle (or sed) script that replaces that
older form of

       typeof(x) Y = (typeof(x))(Z);

or

        typeof(Z) Y = Z;


with just

        auto Y = Z;

is also worthwhile at some point.

We have more of those, because that's the really traditional gcc way
to do things that predates __auto_type.

And the patterns are a bit more complicated, so they need care: not
all of the "typeof (x) Z = Y" patterns have the same type in the
assignment.

So it's not the universal case, but it's the _common_ case, I think.

For example, it's obviously the case in the above, where we use the
exact same "typeof" on both sides, but in other uaccess.h files we
also have patterns like

        __typeof__(*(ptr)) __x = (x); /* eval x once */
        __typeof__(ptr) __ptr = (ptr); /* eval ptr once */

where that *first* case very much needs to use that "__typeof__"
model, because 'x' typically does not necessarily have the same type
as '*(ptr)' (and we absolutely do not want to use a cast: we want
integer types to convert naturally, but we very much want warnings if
somebody were to mix types wrong).

But that second case obviously is exactly the "auto type" case, just
written using __typeof__.

               Linus
