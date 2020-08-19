Return-Path: <SRS0=hg07=B5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07BCC433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B048F2083B
	for <linux-sparse@archiver.kernel.org>; Wed, 19 Aug 2020 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J++SgnXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSUHC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSUHB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Aug 2020 16:07:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB268C061757
        for <linux-sparse@vger.kernel.org>; Wed, 19 Aug 2020 13:07:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so27744332eje.10
        for <linux-sparse@vger.kernel.org>; Wed, 19 Aug 2020 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n9sK111cs+ItqB+H+stQ+4MARCts9jNu0B9tV89oUgs=;
        b=J++SgnXB9A1/wxvgwOGCkKqZXOM+ezy24bjOBUZjDf1PZn4g4vLcBEGnuOP4oVdsz3
         yHXYx8sDN65S+C3qkAluSQDx0tfraQ9eHd8VLOtKXwspalRmq5qCtlA+U4LLK6j99Yiy
         dfKVa+rH4rmBqe2k85eJqbbZNeeHdGILA1l+nx9aNv/lvMpuD43nx5MCZntMWfNXGuVq
         5nkLLFqwrJsBaxc2TXWGILnbpsPb4gl7gOgVYiWCF7YST3BA84NbLQjbb9KiC29bxm3w
         47APC9tam7EvSWL8BuFnSvxKLINS9tyBIRojseyFZZzKg9uPinWWvoYHLxMXgMbUcCVx
         nU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9sK111cs+ItqB+H+stQ+4MARCts9jNu0B9tV89oUgs=;
        b=di+TS6PM9yb8rqc/mQdT7G84BiKTLWwzb4nIn4OWNpojZUDF7n+SgTC+XZ75hpiPiB
         scUzZ5j1Nx1du6lnHpHLnE4rV4GzorrLeweUKtYXA8Ur93cFxJPnQWLHVgyTnumtTVib
         B6far133oiWZiEXg1VDdfvePFG/aKS8wzs+Ndr8uTXvhPece3WTOyYPeYwzAGHB2/NZu
         +f+sUvNBBytNEMG841sL6KBCl7E4vakGh7BO3L98XnB+ABD8R0pvvBmXoQ1izm62pGGw
         jys3QYuhBQMSyIQylHKQGxP/mWB1Pwu0c7KqEnW0D7WcXDIvOBcOKsE7lj+JZ0ihPkz7
         rDxA==
X-Gm-Message-State: AOAM531jJryCMHmY9yA4QZfKfYFx+duCeUcd8Vm0fkZau3W7kR//kviC
        Rio8WKyEavMC5aku3sLvXPcEqJYBnO4=
X-Google-Smtp-Source: ABdhPJxnKAT4d1XD/A4tHHLNPmVCfIBCe7Ky8HPBvsGjNhoUZZEY3KrxxRL8E99AH3pa7V4TYqJ5TQ==
X-Received: by 2002:a17:906:15c7:: with SMTP id l7mr3712ejd.208.1597867619460;
        Wed, 19 Aug 2020 13:06:59 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:3df2:5395:4551:8abb])
        by smtp.gmail.com with ESMTPSA id d20sm19299238ejj.10.2020.08.19.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 13:06:58 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:06:55 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux-Sparse <linux-sparse@vger.kernel.org>
Subject: Re: sparse multiple address spaces?
Message-ID: <20200819200655.mqpjzfwlbyfxrksa@ltop.local>
References: <e9deb689-e470-49e5-a339-252cb05ee119@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9deb689-e470-49e5-a339-252cb05ee119@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Aug 19, 2020 at 12:15:46PM -0700, Randy Dunlap wrote:
> On Linux kernel tree v5.9-rc1, with sparse v0.6.2-180-g49f7e13a,
> I see this sparse warning which I don't grok:
> 
> ../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given
> 
> for this source code:
> 
> typedef void __signalfn_t(int);
> typedef __signalfn_t __user *__sighandler_t; <<<<< line 19
> 
> Are there multiple address spaces there?  What are they?
> 
> 
> 
> or: is the warning related to the other nearby warnings?  (e.g.:)
> 
> ../kernel/signal.c:541:53: CK: warning: incorrect type in initializer (different address spaces)
> ../kernel/signal.c:541:53: CK:    expected struct k_sigaction *ka
> ../kernel/signal.c:541:53: CK:    got struct k_sigaction [noderef] __rcu *
> ../include/uapi/asm-generic/signal-defs.h:19:29: CK: error: multiple address spaces given
> ../kernel/signal.c:694:33: CK: warning: incorrect type in argument 1 (different address spaces)
> ../kernel/signal.c:694:33: CK:    expected struct spinlock [usertype] *lock
> ../kernel/signal.c:694:33: CK:    got struct spinlock [noderef] __rcu *

I would guess that this __sighandler_t is used somewhere in a
struct which is itself accessed via a __rcu pointer.
But that would not explain the level of dereference.

I'll need to check this one.

-- Luc
