Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A47EC433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EF564E2E
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 21:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhB1Vck (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 16:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhB1Vcj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 16:32:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F2AC06174A
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 13:31:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h10so18090260edl.6
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Meh0UGqSy9BTcV9eAAQYKsqWDe2bsIkMW5lxijaZtE4=;
        b=f8njvFMahj9q+gQ4V6X55yc23kkr9JXhZcU5F4pIQCeOQk0A2SjkQNoa1JfHrMbw32
         eKJN011yjECFU9zYcwJ0c735KqpBCFDzs2npv5SvDBMn2h5+fNtQsPaIUpeffYxpZOuK
         Lh/lFGUGn1ptADyssyJDC7UvOgZtlkh/OBGmzkwwq6sWSMUZeOtfGZsXA4GirMOdQAuA
         5oExr8S9tFonWaZf5G8PfVhSAYR9Ts1xroFZyQBv1T+UCkLI/azXNncpTnRvGE/pdFns
         Qbv4Vc8jMJ2oRrOwgjHL7h6u7xS/Eu6XghvpMs5OUaRXrluxExeLjXq+mtOauxSr55q0
         /9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Meh0UGqSy9BTcV9eAAQYKsqWDe2bsIkMW5lxijaZtE4=;
        b=EuTa8vOfAlwXPTXKLjVQDCgyIeJ74jgOxNj+nsMoraKB3otMiJy5qxACwT0s1yCto5
         M99KPhX5u2C/ynQaH0CXkEUVmsguvjRMvfyyMFZ887GfT+D3GQeah4Pc2anekCh2IEHG
         sQ0vs1TwjuCC965DjDpyF6NyIL66/eOx90jG4Cyc9Q3/9Q7roz1MB2X1S5MOfofxdN2S
         FFXgzgQWkLj7ztOVdmcqfZJnkQe7j+iArDqQMmhiS4y47PUKsQoqxQ3aoOi827Di9okP
         AxJFsD5dfYaSO627PzD17R87QycjatyLeZgs5fyiUj56MbAka1Vtulgm5bCUOQ4NWe6b
         g8NQ==
X-Gm-Message-State: AOAM530f4IPihOfnmG+zYL/hhxFP5jut3Z7dX6XPlfEzi1pvDFci3vgA
        sUOZ4meeKOXvehmxs468seAbxpwru48=
X-Google-Smtp-Source: ABdhPJyqhPi/Y50Gu5/vkFd9Fu4OrBS0CJLzw+ZDClvtK1JSBqq9mWEHAXlzObzqHDENIzRR4DVORg==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr43839edt.249.1614547918314;
        Sun, 28 Feb 2021 13:31:58 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:f064:41f:ed1d:4c78])
        by smtp.gmail.com with ESMTPSA id e22sm12377855edu.61.2021.02.28.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:31:57 -0800 (PST)
Date:   Sun, 28 Feb 2021 22:31:57 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] asm-out0: fix a test failure on 32-bit systems
Message-ID: <20210228213157.nxqmkgtnr7czgzcd@mail>
References: <4626bf8c-6079-976a-f579-f76ed1d2792d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4626bf8c-6079-976a-f579-f76ed1d2792d@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Feb 27, 2021 at 05:15:19PM +0000, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Luc,
> 
> So, I did some 32-bit testing this afternoon ... ;-)

Good :)
 
> The problem here being s/symaddr.64/symaddr.32/, of course. I did the
> minimum necessary to get it to work (adding the -m64), so no creative
> solutions here (not that I could think of any)!
> 
> [I suppose that I could also have created asm-out1.c as a copy and then
> done s/symaddr.64/symaddr.32/, s/-m64/-m32/, but I didn't.]

The ideal solution, at least from a functional point of view, would be
to change the "32" by something like "$POINTER_SIZE$" and doing the
substitution when comparing the files but that would complicate a bit
more the testing and make it slower. Another solution would simply to
add for such tests an option to not display the instruction's size.

In this case, what you did is, IMO, the correct solution because the test
is obviously not size dependent, it's just that the size is displayed.

Thanks,
-- Luc
