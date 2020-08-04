Return-Path: <SRS0=xnzy=BO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832F6C433E0
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655BC206D8
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 20:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crdZWV5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHDUZv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHDUZu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Aug 2020 16:25:50 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547DC06174A
        for <linux-sparse@vger.kernel.org>; Tue,  4 Aug 2020 13:25:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l23so17129262edv.11
        for <linux-sparse@vger.kernel.org>; Tue, 04 Aug 2020 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5G5qgEosHt+RiJ9HCVv7XSYAagR/WidQQrAJSs0ZDkk=;
        b=crdZWV5E+ctUBAlflXFfH7jhpSmL8TY9LZwGy3MYywcpn8mL10K7RgpgVmmtJlHqdJ
         I6gLLSiSFvqLBn9p2BhLmYp0zCd/77DYdp+plyGBjRIKVlzv3VhtNQmUMqdyWeX5RlCl
         z8XU7RBB3CrFvReDxXt4jZZ0QWr++mGIUtWVr4MaeNvMnQ7SwRnV2hbvEN4bsSIJBC7z
         EmJ0XvOLvsrteX9JPVh4Wnbw0HHqk2TcNFh9wbUlCVlNCRj24mnUuF/0tv0hU8ayPAyT
         pCtf4YI6a+HuVxl1JJObiYep319qzk8F67a/5Or9zucSZ5+XVdiTbWaUrSv6f4UHR2Up
         J0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5G5qgEosHt+RiJ9HCVv7XSYAagR/WidQQrAJSs0ZDkk=;
        b=dZTFgiENalIOVkrRHNLsEPsM2MnGwEHQJRAIAAXiG3u+o81V8oKa79UdhI6t7hpFjW
         juMVNNac48729dCdAPeCU9hqL0h48wRwgUP/COoBpNKZlMb4qcED08NpT2KCjJyXYYDW
         ihE1qXIwOUlzkOIuHD7bv2MWY2PRtFrC/sjba6GlktLmNfyHYtEHZ+ZhoSPTMvvvY6l+
         jxrdDkmt67SCyP2kmeOmVGodv6DYK1zuIKetYcP4QPZNvOe7s1XcV/un3lxslexJgbtn
         2tgVT77eql5QcwX0v2uEh3mwY1BI8rb53ZHMIDiXNFYRs6ScCo1VG0u09R4VmKwTjB2N
         gvkw==
X-Gm-Message-State: AOAM531hxtfi4kPQvaHPvmTxrc5653m6x5g+bWq0gWHHgGLTBiPDZCaK
        IVTxxMBQuU9EKn6kXRdaI75zpPC6
X-Google-Smtp-Source: ABdhPJzmH+1QrHn9O5MKmU9IBTOAYHFLBlTy3ual6ruDivB8DYe5HF0H7FxvLO+jxjFRMzNx5yYVCQ==
X-Received: by 2002:aa7:da46:: with SMTP id w6mr18881659eds.7.1596572748843;
        Tue, 04 Aug 2020 13:25:48 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d068:a44f:fa3b:62da])
        by smtp.gmail.com with ESMTPSA id o7sm33985edq.53.2020.08.04.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:25:48 -0700 (PDT)
Date:   Tue, 4 Aug 2020 22:25:47 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: Issue with inline functions and switch statements
Message-ID: <20200804202547.vqeihhonjsikxtio@ltop.local>
References: <20200803142903.GK80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803142903.GK80756@lianli.shorne-pla.net>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Aug 03, 2020 at 11:29:03PM +0900, Stafford Horne wrote:
> Hello,

Hi,
 
> I am the maintainer of the OpenRISC architecture linux port, and recently have
> started to look at the kbuild sparse errors.
> 
> The Linux kernel kbuild process is reporting sparse error:
> 
>    net/dccp/proto.c: note: in included file (through include/asm-generic/atomic.h, arch/openrisc/include/asm/atomic.h, include/linux/atomic.h, ...):
>    arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
> 
> Example: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2256733.html
> 
> I have traced this down to the case like the below.
> 
> It reports an unexpected warning:
> 
>    simple_test.c:7:18: warning: shift too big (32) for type int
> 
> This is not pssible because size = 4 should never call shift_small.
> 
> I have debugged sparse when this is running and it seems that when checking the switch
> cases it evaluates all cases, and thinks size = 4 is possible.  I am not sure if this
> is a problem with the sparse front end of the check logic.
> 
> Can you help?

Sure. The problem is sparse sees the expression '1 << (4 * 8)' 
and warns about it before it can know it will never be evaluated.
The exact same problem happens with an even simpler example:
	int foo(void)
	{
		return 0;
		return 1 << 32;
	}

I have an old series for this problem, I would just need to dust off.
It shouldn't take much time, probably just a few days, maximum 10
(but I vaguely remember there was a nasty complication, which is
why it's still pending).

Best regards,
-- Luc
