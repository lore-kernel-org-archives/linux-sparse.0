Return-Path: <SRS0=cI6h=EL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45401C4741F
	for <linux-sparse@archiver.kernel.org>; Thu,  5 Nov 2020 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DEA20735
	for <linux-sparse@archiver.kernel.org>; Thu,  5 Nov 2020 21:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMO3CCTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgKEVNq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKEVNq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Nov 2020 16:13:46 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F2C0613CF
        for <linux-sparse@vger.kernel.org>; Thu,  5 Nov 2020 13:13:45 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k9so3088890edo.5
        for <linux-sparse@vger.kernel.org>; Thu, 05 Nov 2020 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5eemxUb0VrjJBbNMq5om1hiSlPQvYroFm6VpwFTk7wk=;
        b=kMO3CCTA+6rKQQYj0I+4dl/b7HHzgs0biqJQNNQdfA05a8hHEmzPBlaFpn07oE50uH
         n02zEWokMhs2rUAPEnaE77j8LJySSjCuNchtFCPoDVlzWOazxL4/1+jVqk6la5tJvG+V
         PIp3UV/JkhqBwqEbpvod2R7TsIixEaW+lgWBG5aX4gfR76kOPY+2ZPWKa0s08x2TjR0f
         uH8cznBm5wd9lzmEqUUWax3RCWh5h+E44VOPkoMlkw6amBIlajgV10lgxtjKlIRsUxar
         k/R3Opu4nhuJxpOFv/4sPSwN9KjCmIS7pMBsPytTEvsEDwPiNuv4iuVaOXcF49WrJ55d
         wdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5eemxUb0VrjJBbNMq5om1hiSlPQvYroFm6VpwFTk7wk=;
        b=QGyrARxuN6AOeGTKsk3WXyoxDysEJykkIeEYmgQW+KjGHkOXuIxbNi8MlU6/JLrmbO
         XW7JcJHPX6BtLRA5+I3zNcXqp75nsk3Apc8ykYNsYK+hRWYXYKzO5BK6QX66g7znz7Q4
         3QE432MSHaNCC+EfEhBUrh28kc2Fka/H5E6Z+hHkf6yD7nBEDFyI4QbVPhCI41vVTMHU
         gj6CGisVFnNZyQDgdw0PttvaQOjKpwSDg4DIFBYxRsvQyLIfKL4Tytqe8aSyYFFTU90a
         zTSr5qMHiIXOfOQCQhgCvOFkgBSgDbWazoDYCCJcV7Zc0oXEJPERL9HxJcKJyCNI+bwd
         IyYg==
X-Gm-Message-State: AOAM531gLhgDs8lLHLawYwDerUJ2S3TDaHg9+nZxlM7sSYhnHc2VMjrx
        a5q9Kxn0fp16IT9aBHp6PRo=
X-Google-Smtp-Source: ABdhPJwtBBi0Ypv1JDnDuseKcDeMbKrCpSLIXjJL4Cr03pxuUL2yvHEcbiBBcxDAUAv5QToInFWFUQ==
X-Received: by 2002:aa7:cb4a:: with SMTP id w10mr4773575edt.343.1604610824611;
        Thu, 05 Nov 2020 13:13:44 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:2c53:3401:ac35:76c0])
        by smtp.gmail.com with ESMTPSA id b21sm1648178ejg.93.2020.11.05.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:13:43 -0800 (PST)
Date:   Thu, 5 Nov 2020 22:13:42 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Message-ID: <20201105211342.6mglug2a74bi5hvd@ltop.local>
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Nov 05, 2020 at 07:34:55PM +0000, Song Liu wrote:
> Hi, 
> 
> We are trying to fix some sparse warning in kernel/bpf/hashtab.c (in bpf-next tree). 
> The sparse I use was v0.6.3-76-gf680124b. 
> 
> These new warnings are introduced by [1]. Before [1], hashtab.c got
> 
> [...]
> kernel/bpf/hashtab.c:2089:19: error: subtraction of functions? Share your drugs
> kernel/bpf/hashtab.c:1421:9: warning: context imbalance in '__htab_map_lookup_and_delete_batch' - different lock contexts for basic block
> kernel/bpf/hashtab.c: note: in included file (through include/linux/workqueue.h, include/linux/bpf.h):
> ./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_map_seq_find_next' - unexpected unlock
> ./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_map_seq_stop' - unexpected unlock
> 
> With [1], we got a few more warnings:
> 
> [...]
> kernel/bpf/hashtab.c:2141:19: error: subtraction of functions? Share your drugs
> kernel/bpf/hashtab.c:1292:27: warning: context imbalance in 'htab_map_delete_elem' - unexpected unlock
> kernel/bpf/hashtab.c:1325:27: warning: context imbalance in 'htab_lru_map_delete_elem' - unexpected unlock
> kernel/bpf/hashtab.c: note: in included file (through include/linux/workqueue.h, include/linux/bpf.h):
> ./include/linux/rcupdate.h:693:9: warning: context imbalance in '__htab_map_lookup_and_delete_batch' - unexpected unlock
> ./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_map_seq_find_next' - unexpected unlock
> ./include/linux/rcupdate.h:693:9: warning: context imbalance in 'bpf_hash_map_seq_stop' - unexpected unlock
> 
> So htab_map_delete_elem() and htab_lru_map_delete_elem() got new warnings, and 
> __htab_map_lookup_and_delete_batch() got a slightly different warning. 
> 
> After trying different annotations, including the attached foo.diff by Daniel,
> we found the simplest fix was something like:

Annotations can't fix anything here. The patch [1] changes htab_lock_bucket(),
into conditionally taking a lock while before it took it unconditionally.
So, each point where its value is tested now becomes the confluence of 2
distinct paths: one with the lock taken and one with the lock not taken.
This is what is meant by 'context imbalance'.

It should be noted that this 'context imbalance' doesn't mean things like
'this section of code can be executed without the lock held'. 

In the present case, if Sparse would be smarter (move around condition testing)
it would be able to see something like 'OK, there is an imbalance but this has
no impact on the lock being held when needed'. But, in the general case, it's
impossible to do and so Sparse doesn't even try.

-- Luc Van Oostenryck
