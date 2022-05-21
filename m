Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D414C433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbiEUWFi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 18:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiEUWFg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 18:05:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756CB41F88
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 15:05:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so21685048ejd.9
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IV/p119X5594f+38jnuaz7rMoabLXviEZya5rViYhYk=;
        b=RQCuz4T8KGOBZhQJLMhmLCDB0equ0jCfSig9aHx4AuXCr7SpCJp05ZEbPxICY/Oifw
         R+QwlQvFAmgbNic2SLN5gIClrzOc55G1XlIwa+XFfuqaX71BhaFHtFfN1GxM2njuLsvN
         jTHXK5rSn9gfeNDOG7YQtNwImfO3JvWrWhnfTeoamhMlAC1X7apiBWGdDQ35twPmsAiy
         p+uxGXBDDCrxXPuQtiONx0CahCf5qUclg7KP1L5NTASYCBaHWFcT1xXojStSlvzPEjej
         ELt+XniI/OX2tMzQr4vSzlyeKN/9WPanAyoWJzf94KtfJAIRs8Z9Hh2DyGrj73MoGIRm
         yHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IV/p119X5594f+38jnuaz7rMoabLXviEZya5rViYhYk=;
        b=ncmF8Zn/mgbWKALX8Fw77nJsEG9QTzZcMdbnOiSRl4TBbzM6ADAG971YRDUCttLthy
         Ro/xOtzK7Csu2MfWf42JoKUkFv0kNMly5aaGtgzt3ia/Hdhz1qJeLoJFF4MK7ULn3PDn
         jrVDHfC/33jZF/zz0Tkf52fuFkQT7mbReeYTuN3YPZ6eHgo5PPTxJfQFNH+4Y/hvRf6o
         MlQHCsx0eRi9xdzioFVptfOeKkgJ0wLHYbgAmo1pNBJRJI1Yr6KmLwNqhIMbktt8wwew
         5Qs11ST1AHCXVibDFXaav6ivGx68EQsSOxNIzyx5LJXWDYaNmVBCR/CvAPYBvvJru8QI
         disg==
X-Gm-Message-State: AOAM533KY7JUuZ97DPxpnHbV5SvPEB3cDvzH8/j775OdVoTyEzHZz7qo
        dyg9NcXWO4dBqb5ygwLX+4Q=
X-Google-Smtp-Source: ABdhPJxuFycxwe0y2WfTnDJKX4v166SnVzhVUIBbvvDbDO+gVV9Wr8D/pN1WJPeRW5WpmEj4cK8OGA==
X-Received: by 2002:a17:906:c10c:b0:6fa:24e1:2fd3 with SMTP id do12-20020a170906c10c00b006fa24e12fd3mr13946509ejc.231.1653170733968;
        Sat, 21 May 2022 15:05:33 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b0042aaacd4edasm6142427edt.26.2022.05.21.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:05:33 -0700 (PDT)
Date:   Sun, 22 May 2022 00:05:32 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 3/6] RISC-V: Remove the unimplemented ISA extensions
Message-ID: <20220521220532.yfpmrdbvu2gyv2rc@mail>
References: <20220402050041.21302-1-palmer@rivosinc.com>
 <20220402050041.21302-4-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402050041.21302-4-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Apr 01, 2022 at 10:00:38PM -0700, Palmer Dabbelt wrote:
> This made sense when we die()d on unknown ISA extensions, but now that
> we're just warning it's actually a bit detrimental: users won't see that
> their unimplemented ISA extensions are silently having the wrong
> definitions set, which may cause hard to debug failures.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  target-riscv.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/target-riscv.c b/target-riscv.c
> index 494c08db..924259af 100644
> --- a/target-riscv.c
> +++ b/target-riscv.c
> @@ -37,17 +37,7 @@ static void parse_march_riscv(const char *arg)
>  		{ "f",		RISCV_FLOAT|RISCV_FDIV },
>  		{ "d",		RISCV_DOUBLE|RISCV_FDIV },
>  		{ "g",		RISCV_GENERIC },
> -		{ "q",		0 },
> -		{ "l",		0 },
>  		{ "c",		RISCV_COMP },
> -		{ "b",		0 },
> -		{ "j",		0 },
> -		{ "t",		0 },
> -		{ "p",		0 },
> -		{ "v",		0 },
> -		{ "n",		0 },
> -		{ "h",		0 },
> -		{ "s",		0 },

OK, it seems than most of them have anyway no chances to be officialized
anytime soon. Maybe just add the define for p & v together with
the Zb* ones when switching __riscv_arch_test).

-- Luc

