Return-Path: <SRS0=4hY4=BM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E49C433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 21:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1221D20722
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 21:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koTBuvHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgHBVai (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHBVai (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 2 Aug 2020 17:30:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81F0C06174A
        for <linux-sparse@vger.kernel.org>; Sun,  2 Aug 2020 14:30:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so12159675edv.11
        for <linux-sparse@vger.kernel.org>; Sun, 02 Aug 2020 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i54K6HAtYaYxXR8nnrsC+4gTetNOyXosgJ6lQtGPV1Y=;
        b=koTBuvHdQ1VwK1D99Hsm66t2lOb30w5wPXn3dd7Qm0b1+7+S7DCyaIQnU1FWYsNFNG
         KnsZ+YmkJg4kRJAYeAf/WA3kgwOW0TMXpfkuZCXg6QIRgVThlVkMOXgC4743LOVNVbF9
         0yDvHgmGEFrEaKy1VmLW+rPnrOvJC/JaZ+HHmX8RvmybvsBshtmbLrdqH2k91v8KQC3d
         5eWHX64l3HoZ9t9pbQLwOqlFVvm4j8T79xPUuhInW+BLBb9BqeRDjSrmtvCI3Kb3VHcj
         lG7KR5gU57oeyYbQLR36A+LzVbiVMn3TsS7hM+M0Dm5FyQKtgGLlVPi19VD9Jo+0zlM/
         ESGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i54K6HAtYaYxXR8nnrsC+4gTetNOyXosgJ6lQtGPV1Y=;
        b=iJC38Z8livjHw0vzSv09X21XSnyIHcN6uCNchdXclV/m9foVXLxmq1MZ4AFLDnQYPG
         HDCKBQdlqpnY9ulqVWCRI8VJ/3ZILS0fXJNeXEgCsd0WsTy5BdY2pwLqFjVz5r8ztuoH
         RhS0VGIk/QTyMYzhWSO8qbZ90GOG3fJeuX7s4MptNwB8ZGwGMcemVvOF9guAGyWSN0wp
         3gCLcM3J/16GRY2Sw7LundqXtnvOGYj4vabH7j0Dq4fIbwn466EO0sQDoiennVcyWKE8
         guQZ6GWb2a9Q8nNRMw8pLPipmHPyrwd9MORG9JApzc4f80riTafBwco7tEyQkZMl9zas
         jVBw==
X-Gm-Message-State: AOAM532VmOZyetbZUK1OzA8zj3GbGItalkLJj1OPqh0RrAc4b5PghVLx
        6rThGBkHq+8bjom0Rqz4DHetdXuR
X-Google-Smtp-Source: ABdhPJylNmdbg0XX68AFQiN065FcUgdeitdyLnsbUU4FqUrq8Bl5367W2w8nQBeVgPWFTwcYC/Ruow==
X-Received: by 2002:aa7:cc06:: with SMTP id q6mr1652358edt.10.1596403836420;
        Sun, 02 Aug 2020 14:30:36 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:4c03:fcaa:281b:6f77])
        by smtp.gmail.com with ESMTPSA id w9sm2670420ejk.62.2020.08.02.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 14:30:35 -0700 (PDT)
Date:   Sun, 2 Aug 2020 23:30:35 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>
Cc:     linux-sparse@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200802213035.w7bexg4zdusr25xf@ltop.local>
References: <reply-9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_185002@salsa.debian.org>
 <note_185155@salsa.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <note_185155@salsa.debian.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Aug 02, 2020 at 08:18:42PM +0000, Uwe Kleine-König wrote:
> Uwe Kleine-König commented on a discussion: https://salsa.debian.org/ukleinek/sparse/-/merge_requests/2#note_185155
> 
> There is still another issue that popped up in the meantime: 
> https://bugs.debian.org/966706

Hmmm, I think that a corner of my mind was silently worried it
will happen.

> The options are:
> 
>  - add a Conflicts: biosquid
>    (this is the ugliest option)
>  - rename sindex to something else
>  - convince the bioquid people to rename their sindex
>  - stop shipping sindex
> 
> For now I will go for "stop shipping sindex", do you have an opinion for a long-term plan?

[+CC to sindex's author]

Not really.
Would it be easy to install it under the name 'sparse-sindex' or
'sparse-index'?

One thing I would like (in some future release) is to split
the sparse package at least in 2:
* one with sparse itself
  - it has no dependencies (except the libc, a compiler compatible
    with gcc and GNU make for the build)
  - maybe cgcc should be included in the package too (which would
    add a dependency on perl)
* one with the others tools
  - but maybe it would even be better to the big ones in their
    own packages with their own dependencies)
But this would not really solve the problem here.

-- Luc
