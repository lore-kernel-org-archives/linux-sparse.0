Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838A41C31D
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673211; cv=none; b=bhnxjBHhDXuXHvGJhN6iPmYd5cPlmyC+8S56SZ4UnqD6e6w+yZquq0slHQ8cvinOvSBMhA4sGGwyp7REyqGlKL9cAxyf7ulJss7NfelbmomozT2irz4pRqyLhaeyMpmwwWtpt7A5ozyERwEbvIEtZhoI9OqtITVOBUbkMUSY0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673211; c=relaxed/simple;
	bh=AOqmAhuUrsfkqKxgScTUb+rQe3xsR+Hb7qeo/CZw8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnq1EcPQDyTAKr8rcdIKm4qyxmdjNTnxaKXcYTa7sdS9aJW/53Snr0Tvip9TQcN45dJeIPoldFZD+s9v2cnNwEVgpY1vZYIgDMTLjot4fKfTPkFuxqLLb3BjhKhfZPtIbbCWy6JOF+7dV2BRK0qYLaVP53l1DtQ0DkT8pI/YWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foZ296P4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foZ296P4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso16861265e9.1
        for <linux-sparse@vger.kernel.org>; Fri, 05 Jun 2026 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673208; x=1781278008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Abue9iSn2I8UR9RVOz3isv2SYWk8vOgv9dRkil3ntsU=;
        b=foZ296P4attA6zMR3YzSh8wPE9cippmYQJV47lkROgb4s1hkq0i0VC4BEP66nXt+FH
         ZYaYzVwGrOxW3CSFPHC05qkssjsId2QGIrUhryYOYHth3Cy2WOvfdpuzKcFP0qaYjHeJ
         Ykh+wXWmI5+rrhA2ae8IYJVY95bMjVEL09B0TWb3vKsJEjsJTkwpITXuZZSD5/BFnb9+
         ROs0IkTVarnLIvDnUQdB7x1Y54BT1gKMBhj57T8oVagZE/LYWz6DQGbrH6MmnxAU1inc
         GRTCXtbt+BnEWV2EmL9hidKaE59DCepLXNtRCX6C4RfNBZbqTSKBSyzySDzeMTItxd85
         yqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673208; x=1781278008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abue9iSn2I8UR9RVOz3isv2SYWk8vOgv9dRkil3ntsU=;
        b=USmXTiCUWPD25vzdZ3cOJ3RqEqzh48mlkUEm1WgnJ1jN6H2EOsNFHCaXm9gPriisoq
         5yJwyO6WTAkOBYJO8LTqj1VmO+ktAW3gtgamJ/QrCpwtH3+xmtOiHcZ2uPEpyaXw+KsC
         ZH0vzg/rjTz2L7mX4bVunTovQyRQvQQltKYIjxdUCsciH1ldyzUia8zTsEfiGvHKiDCS
         6DQRLupB+t1u5pqU5rMNsWQWegLkGeVkbKgrH4H9QZ58bVfPFpSaaTxEXDOsVaDcgWVZ
         qi3AJrYpwWRWiLwCsebbbInmDHIKucf5QKmbqSeooLNoKH/SxPN9ZKYL4ElNA6RWL9ND
         pHvw==
X-Forwarded-Encrypted: i=1; AFNElJ836YYa4DY5mPzlWmqIrOWnDx0bK2t6/eo5XbGwyvfALL0xGzj1RGV6ersY+pf98dT+EiDdjUQ83vVK16Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNaOpAyqLZVWRYJT9i+mxzyUZuLxSkADOKHy9+xLIHg8Lh+N+
	bh3bh41Cqhcn3CZEcao2QVjzbN9fG7XIC5G5mEn7D8Nx0i3+hRxKpGBb
X-Gm-Gg: Acq92OGysB0BXX4JLvMS/keWA0L1gk3ASzX5OVJkdPXTPjcU6pXJDr6PoeTbdhD1Fhv
	ZM53Q235H7ExRy2MbML+y21JK6q9xDm34+k/2Ww9yHuqdGAoQ4Hkd2QwzjcbTv3xCBaC546IvOu
	ZZWfmYUIR3hPHqazGrotD7dAZ3TeoXdjxp43HdsA28PAX/h5N5vH0xNUuEKpbsIb8RfQ5elz63o
	M1IpdF98KmFUTsliu5chTnD6NTm5l2kzYcJlMwObf2SJeUYGBt7pGQoY0nSILZ1qib3F8ztkl5T
	1OjwX0WjoVNkM0EmYpCHvQzOrBzjJrFC6Cvs/qDy3nAX6tNaCtnZ/0iw12pEhqqpvUO6cn+iI9J
	zqaUVgHWd0v+xZlsMdJFTywr05SNZBtovOUWDGIcdpjOsaKcC9SMlucuS4z1h1av9GIK9yqxi89
	Vjd6RwJHM4Ggch8/gSoxHKez9AFfwjIg==
X-Received: by 2002:a05:600c:b90:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-490c2613da2mr71335215e9.24.1780673208460;
        Fri, 05 Jun 2026 08:26:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm160507125e9.11.2026.06.05.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:26:47 -0700 (PDT)
Date: Fri, 5 Jun 2026 18:26:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Chris Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] accept an empty attribute argument list
Message-ID: <aiLqtDvo5uzLfdak@stanley.mountain>
References: <20260605113045.483498-1-d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605113045.483498-1-d@ilvokhin.com>

On Fri, Jun 05, 2026 at 11:30:45AM +0000, Dmitry Ilvokhin wrote:
> GCC and clang accept an empty argument list for attributes, e.g.
> __attribute__((nonnull())), and treat it the same as the bare
> __attribute__((nonnull)). sparse instead rejects it with
> "an expression is expected before ')'".
> 
> ignore_attribute() and recover_unknown_attribute() consume the optional
> argument list with parens_expression(), which requires a non-empty
> expression, so an empty () is rejected. The bare form is fine because it
> takes no parentheses and skips that path.
> 
> This turned up in the Linux kernel: the cleanup.h guard macros expand
> __nonnull_args() to __attribute__((__nonnull__())).
> 
>   https://lore.kernel.org/all/aiJi0WcYE8FZt-jO@stanley.mountain/
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  parse.c                              | 17 +++++++++++++----
>  validation/attribute-nonnull-empty.c | 12 ++++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)
>  create mode 100644 validation/attribute-nonnull-empty.c

Thanks so much!

Tested-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

