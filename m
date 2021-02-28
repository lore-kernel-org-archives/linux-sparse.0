Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2EEC433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B9F64E62
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 21:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhB1Vek (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 16:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhB1Vei (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 16:34:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19073C06174A
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 13:33:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mm21so24312822ejb.12
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iTZEUc7FkeRoDa2+7BeY9KopsqfDqZ15j0v3RbJcrRs=;
        b=o4QDw9gBvGau9gVoq3/qubXjgj+2oLiYpQWo2x876/0siVeX1SP0PwQQOUu9BD5fsP
         8/YIFYs7H5IkkhHkP/k2Y9dwESv+1C0Cmnx5PU8pRRI0RHo47LBrSpSlri3egJ+T8TW4
         JZgIWpXbY27oxY+Ai3CP94fmTJNCdJRI4+RjpG+8falgYKu//jPvO/x766LXonBgInbQ
         9n2q5j4JujSjQng0ZsW5xSSvbsOLSzjasKhcICmu4pHJa9WaGszRBLmlKuEOh0z0nqrG
         dSTO2uazIAPQZ5XNE4dl5n+vhQfnYHRRt0kQw/2YJ4DWFSllUMG/QTYsXORcDlw4t+0B
         pQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iTZEUc7FkeRoDa2+7BeY9KopsqfDqZ15j0v3RbJcrRs=;
        b=nYTtMjmxo/7RRqp7Qm7U67NjPR5ajrrBXRfceCNzf68d0t4FVJXT1+nzNPmiWDRNWM
         CfNn2ZRxWDJJVFvncTO1+mahJtQPfbPVx7bWBVAXryTsAah1G70hV/tPEnt17gelBfEz
         4mX/DpEoEuLSFv13KLd43m+pyvDHDySYkLP6GooabNY6f4Zr3+Ytn2tcbifHPjWBasfU
         Q+mQolAVKIswGFV6MdQmD8PkFVXzdIw6nh3Z5NHS8aHmwsS66IpBQILKDY6ZCGVKEei2
         5hpW+C7+T87g1MSgWT0Tw1ePJRlPwfuN+ZHbzNr90RlbQ/FdQwfC5jbP8ozfUD6wzAR7
         U2gA==
X-Gm-Message-State: AOAM533ocygTBj9Y+dqf/6Qjocd7K9TPSJuf/SXIMhOoXnbJPwRmA7zq
        8abhxDNQ3MmNx/yX7KhGUxFlzC98/U8=
X-Google-Smtp-Source: ABdhPJyqxZLmVoNsAELogW07EiGyCBQKBn9i93kEOzspOlPvp4IxoMXoH721qgaJ9iKalcYNRNtlAg==
X-Received: by 2002:a17:906:2312:: with SMTP id l18mr13351270eja.468.1614548036864;
        Sun, 28 Feb 2021 13:33:56 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:f064:41f:ed1d:4c78])
        by smtp.gmail.com with ESMTPSA id h10sm123271edk.17.2021.02.28.13.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:33:56 -0800 (PST)
Date:   Sun, 28 Feb 2021 22:33:55 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] linearize.h: fix some 'selfcheck' warnings
Message-ID: <20210228213355.ymko6uwbsxj4expj@mail>
References: <89a7aecb-1a5c-0a43-c9a9-ccee0b12fca6@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89a7aecb-1a5c-0a43-c9a9-ccee0b12fca6@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Feb 26, 2021 at 11:28:43PM +0000, Ramsay Jones wrote:
> 
> Commits 34c57a7f ("asm-mem: does it clobber memory?", 2021-02-20) and
> d6721b38 ("asm-mem: does it output to memory?", 2021-02-20) both add
> a single bit bitfield to the 'struct asm' part of the union contained
> within the 'struct instruction'. This causes the 'selfcheck' target
> to issue several 'dubious one-bit signed bitfield' errors.
> 
> In order to suppress these errors, change the type of the bitfields to
> an unsigned type.

Thank you,
-- Luc
