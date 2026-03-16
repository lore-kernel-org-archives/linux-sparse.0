Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C963CD8B8
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679342; cv=none; b=NiHMM/dv4xm0U25/zKebxqWyOvKqHcH2SVppr0M/iaQTXEnJfjC+HQ4wXnskRJSj79BT3sux53KRWCf0r+SatQudeBSfRDhzgHDY8NZfsXURwY+4P9D9lVi3i/AVdfxpUiQVyTMtx4unGAeICCGoqSM7kHJ0Gu8GmIfpR+gqhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679342; c=relaxed/simple;
	bh=DLq1w6M0CLOFz4xDhFxcWDwkZmeIOkH4/2erumOz53Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSCVzlAzV620yw9O3upyezmvmfIMmz9VAasPCUAfapjQH9aCQt2flEnLFNmJd4D5k/Bp+Kig22dcpQoUbM4iCBz+YHwhkGdpzj/tzukEoHTuRI7UKZGClS5XuaQYF5RJHeYLPyaJ7V9D54lKZ+0F8CE+D5NrpvF4Ai86mU5khWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hoHz1MDQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hoHz1MDQ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-661568ce781so6974910a12.0
        for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773679339; x=1774284139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UtLq42yEfhxjR0zZoA37uTk/j1DfywI377aFzp+yYFo=;
        b=hoHz1MDQR9L0VSnG4WWC9Uvc8hhftFdUXIAuqfKsBgyWfUv7oTCdXFJQIU9uqxtLKt
         hMfaE4GkT1jcQRUdHFbbsgijJCHPvz8FsrPdHz9GNXvnxQkAb/4e3MhL5mEcNoNtQv66
         4E8S2MVvB+X3+Buynsiint0hHoCM6nTPROsYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773679339; x=1774284139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtLq42yEfhxjR0zZoA37uTk/j1DfywI377aFzp+yYFo=;
        b=BUJ47wB9HinU0ol7nfu7UeBJAwqP+61aLzKSbJwv31Y3g/jFf3mocBszBbGm3a9VAJ
         cc9vymnTnHrYMhFGKbz0Wiy2CDEj7sTLa24vgw3uKrqcznZ9JrZaFw+Mn7M+OHqH4I1I
         1ZEeTUwHOQbbWtReixTY9bFLh6bUysRmkWs8HDVSt1vllnMzQRowicAGK5ypBO797erC
         334TqqyiuGSe/KVfrA6zMWIrEQo72DD68AH+sRMehthP9FTvTqOppL5akyr8GRMdf9FX
         Zv51WJDTnoaAfV6d17oFi0QTbasp6bwpaDRWzPUtgf3mrVhURnwaHYx0GisjOuNJ0/gu
         P+dA==
X-Forwarded-Encrypted: i=1; AJvYcCW71yJ/I+tkr/HAyIdrKJbm/kPUT37e7kFh4MwqVbML9s9xHE/esom6zWKGit2j1N6dyPIu3aAOz3eq+Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkhdwuZcJWE9Ck6PGy4EF+KoPGJqrSuLzOcqrGk6ZYPkKDkmC
	1f4M7Tb266XoEY5+Ump0zCqdGw7v786Y8XjamaDxfmjM/fNdO0x8MfCFh3ic8oDq3fkBGe0jnns
	z9u8p8xo=
X-Gm-Gg: ATEYQzxIGKIna2GayN+xYvoL7bpMSKJd+MDN+gS0NL9qcMMMDs4cRvB/PEVlbfv03ay
	HvBA1K9Vwr1CmdDAXI2NFRoFXaTgRo6t4RsW8p67ag51svClg77HLgOdxX4dUOAO1SEAUm7kUtc
	P/aXuks/4ZMobxO1Y90Z2igqlnAHj6Npn28xqzcYlRH/F0k1b/52fjZKDpZ9FTOCdo7yB2cutys
	7IVdBuGpKR78M4/6xB+qMV8XMeJMLVyoVkw8yUOlbhg6Oxa7ZlVrjk9oE+KRs/s+7UjxuMogb70
	m8l90YTGjv3lV+02cri/IIsi8RF3YVwJ6sBWazVd9+9np2oUZ8zHVkWm+/5YX6FOooCgW7DWwkK
	AD27VQYfWyK5siuSTYw5gFTc5pR6biCLWGrqQkmo+dWmcJhevU6tEWF1nq3zb0Dg1XkCSjd/E+j
	TSzhuXgA0RGBMPfYoZeMmO2C9aDO5X0218uUamy9W8skE+CIb66xCvyEDJawELc5wQaCS5X3wR
X-Received: by 2002:a17:906:f5a9:b0:b97:c801:2c29 with SMTP id a640c23a62f3a-b97c8013c05mr203228366b.7.1773679338503;
        Mon, 16 Mar 2026 09:42:18 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97d201082esm57046666b.63.2026.03.16.09.42.17
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:42:17 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6653b589a78so2226451a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 09:42:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQAuY/c4FeP0iGU8rjOs+k7O4jwE7kfM7xpt07+BgJehP1KWnvAYBSJwFBFoArohhU7rxuiDWMH94vrIE=@vger.kernel.org
X-Received: by 2002:a05:6402:50cf:b0:664:3344:fa06 with SMTP id
 4fb4d7f45d1cf-6643345084dmr6453739a12.24.1773679337562; Mon, 16 Mar 2026
 09:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072731.GA3093958@ZenIV> <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV> <20260226072945.GA4104757@ZenIV> <20260316065622.GA607739@ZenIV>
In-Reply-To: <20260316065622.GA607739@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Mar 2026 09:42:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghBU1bB6E889nv5fg+40b4_n5WnA0h3bVh32EKw0zE2w@mail.gmail.com>
X-Gm-Features: AaiRm505-Eu6y-kPjdMvU4hagfLB9GURdNYSHf5hjoCk4qyaGdrRCsXZNoPDcY4
Message-ID: <CAHk-=wghBU1bB6E889nv5fg+40b4_n5WnA0h3bVh32EKw0zE2w@mail.gmail.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Zhang <zxh@xh-zhang.com>, linux-sparse@vger.kernel.org, 
	dan.carpenter@linaro.org, chriscli@google.com, ben.dooks@codethink.co.uk, 
	rf@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"

I have tested that branch on a few trivial cases, and it looks good to me.

I did write a long rant about how I hate cpp tricks and wish we had a
few simple extensions (__VA_COUNT__ would be the most simple one,
because COUNT_ARGS() is disgusting), but it is what it is, and this
makes things better. So I decided to just delete my rant.

               Linus
