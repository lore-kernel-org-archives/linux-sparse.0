Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9B125AE
	for <linux-sparse@vger.kernel.org>; Sun,  7 Jan 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KbjO5frO"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e72e3d435so762478e87.2
        for <linux-sparse@vger.kernel.org>; Sat, 06 Jan 2024 21:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704606865; x=1705211665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2+WLp3U3zZ/tGPOXpKoB0JjWL2Gl79ktP3vftiqjZGc=;
        b=KbjO5frOxnYToNMtMVWJ3fVv4+kn92RPn+5+DYVwDzQhcidM+p8LTBLZfVvG8YTFXx
         Q2UDuaDvorMz7BplkrlcbYXOJvBB6Nf6c/OP3F+rc09aknAU9NfnyX3gP1YYqDJf7xKL
         xVdgdh9QS0ki/TBxy/cSwIpnMMEo+Ucs4FRlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704606865; x=1705211665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+WLp3U3zZ/tGPOXpKoB0JjWL2Gl79ktP3vftiqjZGc=;
        b=f+x6osqfFj0tl0h6XQiNTaFffu+B1pgvm+BWZdXYCHGeUZHpDpmTkGhlvQBaYphQNn
         tlG1DXOKMhb+8WfRDfTjHdOT3htn3WcXhlNiCNMQ5UU3AyCEzdM0WY0lO7wpwDRqCmuD
         qH0i2O2ZrD+3bgECBg+vELPzlEGefchKD2/MCmaNSfS7l8w3eseGHqPnj6FxPm3K2q6L
         tGt2Y51TXhVyzO7rRqiJhQpTufPfusb8YJ8d9/Y9AtxMDhNyrSUT1+7ovx59qr726cgl
         oqczVjrl9l7cA71WNfsepLL9VORXTh5Fc41uCMBVUYkjkF0gWJZDf6czHUVb6xgcToUy
         /Iog==
X-Gm-Message-State: AOJu0YxRvswhZGdFP6VcsbvMj0ClkIRUabbNyfRpGgQP8532OeuCci1I
	RRqnN83BPmq9MDk9E97ERhm2yEyTncpJ435yJ023D0hGi5l8k4Gc
X-Google-Smtp-Source: AGHT+IF0hInRntd8IsrR0pGGPsv9P7YNFYXFTi1Rr1HAuwjwDblspPWRZhBt8v6pg0CX3QT8G1KedA==
X-Received: by 2002:a05:6512:2806:b0:50e:5565:6a6 with SMTP id cf6-20020a056512280600b0050e556506a6mr501153lfb.209.1704606864848;
        Sat, 06 Jan 2024 21:54:24 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m4-20020ac24ac4000000b0050e76e0a525sm720020lfp.32.2024.01.06.21.54.23
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 21:54:24 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e72e3d435so762468e87.2
        for <linux-sparse@vger.kernel.org>; Sat, 06 Jan 2024 21:54:23 -0800 (PST)
X-Received: by 2002:a05:6512:98b:b0:50e:6e7b:1acc with SMTP id
 w11-20020a056512098b00b0050e6e7b1accmr424707lft.129.1704606862788; Sat, 06
 Jan 2024 21:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401070147.gqwVulOn-lkp@intel.com> <ZZnzd3s2L-ZwGOlz@google.com>
In-Reply-To: <ZZnzd3s2L-ZwGOlz@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Jan 2024 21:54:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLaBe3Y_H5WArWdQ6d36+UOQ7NSbga1w+esGYJZaVfVg@mail.gmail.com>
Message-ID: <CAHk-=wjLaBe3Y_H5WArWdQ6d36+UOQ7NSbga1w+esGYJZaVfVg@mail.gmail.com>
Subject: Re: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sparse@vger.kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jan 2024 at 16:42, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> This is not really a kernel/driver bug, just sparse being over-eager
> with truncation detection. I wonder if we could make sparse skip this
> check on forced casts like this:

No, please don't.

Just face the fact that using integer casts to mask bits off is a bad idea.

Yes, we could say "explicit casting is ok", since it's really the
hidden implicit casts changing values that sparse complains about, but
your solution is really ugly:

>  static inline void __put_unaligned_be24(const u32 val, u8 *p)
>  {
> -       *p++ = val >> 16;
> -       *p++ = val >> 8;
> -       *p++ = val;
> +       *p++ = (__force u8)(val >> 16);
> +       *p++ = (__force u8)(val >> 8);
> +       *p++ = (__force u8)val;
>  }

That's just disgusting.

The *natural* thing to do is to simply make the masking itself be
explicit - not the cast. IOW, just write it as

        *p++ = (val >> 16) & 0xff;
        *p++ = (val >> 8) & 0xff;
        *p++ = val & 0xff;

and doesn't that look much more natural?

Sure, the compiler will then just notice "you're assigning to a char,
to I don't actually need to do any masking at all", but now sparse
won't complain because there's no "cast silently drops bits" issue any
more.

And while the code is a bit more to read, I think it is actually to
some degree more obvious to a human too what is going on.

No?

              Linus
