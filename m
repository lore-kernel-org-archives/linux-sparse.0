Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A662C433E0
	for <linux-sparse@archiver.kernel.org>; Mon,  1 Mar 2021 00:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162C364E2E
	for <linux-sparse@archiver.kernel.org>; Mon,  1 Mar 2021 00:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCAAag (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 19:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhCAAaf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 19:30:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28186C061756;
        Sun, 28 Feb 2021 16:29:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w9so2352145edt.13;
        Sun, 28 Feb 2021 16:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hYl5yZ67XPPXJBjZ3ChyGvfn2enthXOBJf/j62FmLk8=;
        b=hgrq06bxM7WCL+R5T3iRLyNUPmd9T6fFk2Th5JaKyIuNaXEQJGJ340aoJOuJ9Ozgb6
         DVuAmiBma43jiRsHOvwF6MNYmGTSNB5nwkPZ5JH9p0EOx8uDcdaEZ3vJEW6P0s22rovi
         df8ZNfiN/ATdsY/jcHKRTCouJVi0oeqKQj/qcKfnCGJYx0cDczwFxtBHXwJdl9l8pTvT
         SdPwo5VRJ1jsGj7F9pX/5X+bRi7tezdwig1Q1SJriVUih3JdxURxVsZqwVgxGCxAjfq/
         OqC8Vrptf26sptdg3LgzX1eLVwN5oc1gXfZ/KvkvDxxaZ+yyOEIwscmtbuY/DdK8x9Be
         O+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hYl5yZ67XPPXJBjZ3ChyGvfn2enthXOBJf/j62FmLk8=;
        b=tFe/0FCakhy0g/B/QafLEBGsWdesRPjYOHsC75tDoR/grUu7RDAlbQgQrpU3wg2SZg
         2UVePiBb0q3fx7eqe0Va2h0wu5sNaFm4SJmx3IRl3bXMPS9w7CtmPPSGxyFgTyBL7k4S
         iZYPsMfrecv4/DNS1+0FUU+0x9WpShhDmFAPyzvQkvMdDksNo5mfG1/3T1NTVAy7eAOI
         +HFEX3402xTZJk8IWgqSOLZl1HZK3COCxhnOM0UaxLvmAXMjR74OnXUku8X87mGPT5KR
         6Xv7k46AP/TwCgh760mH9eKqO47oGdYK9/QrorCxMQcnz5GnT5PcGTr6coMCQ1PHh6wk
         Hhzg==
X-Gm-Message-State: AOAM533fC6au3R85EaaqBrQ/SpdSqj2M2u4XFODBzKYDGPTx/1DhYscm
        Y/FFCRZyxEUTQDGOIsSk+P8=
X-Google-Smtp-Source: ABdhPJz9/R7B2rr5e1Ps4iYhwy8u4+ibcngFTH7ZEAbdMJTsWbLWBnt4hIiMNVY8gcEIJO1EZaIblA==
X-Received: by 2002:a05:6402:946:: with SMTP id h6mr14356827edz.188.1614558593957;
        Sun, 28 Feb 2021 16:29:53 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:a098:f2e1:a530:fb8])
        by smtp.gmail.com with ESMTPSA id z13sm12905687edc.73.2021.02.28.16.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 16:29:53 -0800 (PST)
Date:   Mon, 1 Mar 2021 01:29:52 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
Message-ID: <20210301002952.hdn5fngwfeo5nhce@mail>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDvwVlG/fqVxVYlQ@localhost.localdomain>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Feb 28, 2021 at 10:34:46PM +0300, Alexey Dobriyan wrote:
> 
> gcc does
> 
> 	open "/" + "whatever between quotes"
> 	fstat
> 
> so that "1.h" and "./1.h" differ

When I try the following with GCC 10.2:
	$ cat header.h
	#pragma once
	#include "./header.h"
	.. plenty of stuff ..

	$ strace -f gcc -E header.h

I see that the file is opened 4 times (3 times with the name "header.h"
and once with "./header.h"). Each of these open is followed by a fstat().
More annoyingly, the file is also read 4 times (3 times entirely and once
only the fist 4096 bytes).

When the equivalent is done with an include guard instead, the file is
only read twice (once with each names) and read twice (entirely).

-- Luc
