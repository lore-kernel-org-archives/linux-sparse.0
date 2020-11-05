Return-Path: <SRS0=cI6h=EL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB2C388F7
	for <linux-sparse@archiver.kernel.org>; Thu,  5 Nov 2020 21:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F4D2080D
	for <linux-sparse@archiver.kernel.org>; Thu,  5 Nov 2020 21:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnOLxd9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgKEVu1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEVu1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Nov 2020 16:50:27 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AFEC0613CF
        for <linux-sparse@vger.kernel.org>; Thu,  5 Nov 2020 13:50:27 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o21so4847830ejb.3
        for <linux-sparse@vger.kernel.org>; Thu, 05 Nov 2020 13:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yzjl/j5g9WwMlLORlAjetokKmY381kmET6osxKABWFw=;
        b=dnOLxd9l+f2RLHa3zrF3cRi+8Hpv4X2Uk3X8blTCQ9mR1Z1spkJD7Kfg+KJXTcHgbW
         NviG18O4ScEZFsukbDRs0oVe6kzrFvqsLT0wPz6Xka3XS9yIz2Ip2RYk+i/cjlgydbGk
         gsasn+UeXAFcNQ0fvPhCObccI3asVD7X3xbMfs4GvGXjWKNcDCpKwBAoxx36Jc8pgqpA
         hg2jwibwl84TD9/0lPE4E3DBh9cioHSrxHmlpmw6TxpeNJpuath23ubquXld7FBEHUHr
         s0wxoZo2JWA8PX2W4MA3TOX/knn5A792AafQ1f1ZDqYeuAR1icEHcZikcIkHSoB7y8ps
         Re8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yzjl/j5g9WwMlLORlAjetokKmY381kmET6osxKABWFw=;
        b=fiVghlEvM1TKDRmwT3ostUijr3VxCx1z0bMlIa4dA0qFNn/Ybk39hgIKyyCNQc7jow
         FMZXgdtBiOisTIiOSu0KUyuHCajh/09DmJQye0HOn7cnleLYmCxuLC+qihi4BnqLY7Gr
         ihrK0HgIbDO5vjhtzAm752/brQMu707k5w3b5V/4w6VSotU2WNWgm1WXk5NSaqN18cuX
         py2oUx20UzBzT1OOP8pihRHgD8nH56/e8a28gMJVzqO1VTl8FBg/7Qih4NWGaDUNEynS
         2FY6r5t7TU+btJoVauyP6gZZ4zVLThclXvFTcIBuuzoTBxX6+fm/INIXSEiVb+HOWE68
         FBMA==
X-Gm-Message-State: AOAM532wD5oMOSlYw5U+Sjax9YioERaG1lD2uUEfLAqc5yv2enhbE3+3
        Plx2q/7RMbh89V022Bciq34=
X-Google-Smtp-Source: ABdhPJzpuXHisRC8pU8b5pOKSC5G0vE9G73uv3QqVVXaU38C8cl7UTrGuG95BD/YMNL7/VKQ/HePnw==
X-Received: by 2002:a17:906:c298:: with SMTP id r24mr4452282ejz.76.1604613025821;
        Thu, 05 Nov 2020 13:50:25 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:2c53:3401:ac35:76c0])
        by smtp.gmail.com with ESMTPSA id dn16sm1582155edb.19.2020.11.05.13.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:50:25 -0800 (PST)
Date:   Thu, 5 Nov 2020 22:50:23 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Message-ID: <20201105215023.wvekadtkdwgz7yim@ltop.local>
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
 <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Nov 05, 2020 at 01:18:02PM -0800, Linus Torvalds wrote:
> On Thu, Nov 5, 2020 at 1:13 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Annotations can't fix anything here. The patch [1] changes htab_lock_bucket(),
> > into conditionally taking a lock while before it took it unconditionally.
> > So, each point where its value is tested now becomes the confluence of 2
> > distinct paths: one with the lock taken and one with the lock not taken.
> > This is what is meant by 'context imbalance'.
> 
> I think the point Song makes is that if sparse did a few more
> optimizations, it would see the context imbalance go away, because the
> value it tests would become constant.

It's not how I understood it, but yes, I agree. It's what I tried to
briefly explain the in the last paragraph.

From what I know from these situations, in most cases, simple
'expression' optimizations are not enough but simple forms of
code hoisting would often anything that's needed.

-- Luc
