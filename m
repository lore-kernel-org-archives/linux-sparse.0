Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6390AC433EF
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Mar 2022 19:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiCaTYQ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiCaTYP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 15:24:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9A51D8330
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:22:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so908965lfg.7
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OEPCdXe2i+3HQ35ixV974j36LoFDje9fVp8XGNtV2Q=;
        b=eL2A6Cvg7uxcHXGn1hbZHGQljpZsd0M8iYfcUVnx0fvYFqMz6SXL8ynxO++N5U/VIC
         5QO+Wz5iKKDOyk7Mb4qVdTEtD5HACDEHmPGh3/2KaeRMUTbudvdjWtm5YDYrdeiRFluN
         dXfcGe0Penkw+spvE141N2Hn8xGzo8QnNjWNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OEPCdXe2i+3HQ35ixV974j36LoFDje9fVp8XGNtV2Q=;
        b=kn4KXLT6b3Z5HZKAZY1+Ij5MerfI7P4gSVfOLiUK3jLmiA6TDiqlaPtHeKiJ70JvSg
         v5AyZ4yTWIzWcyoyDVSc440wUYprgI8/msY5GAH9OeMP2jzhjenB26pqfpEHgZzhI8+x
         tUkSapLUaAaL8Z7tZqCpZuA804OwMs1tGGxER6ejv3shwMxYTbNJwM5he6ISi20HIib2
         r7st4+7O4jX8s+xhQai4Jb3Fn6ckecr9cZZ/hBXHd6ALknyORvZlZvwBFK13lYfLZERK
         9eqm/vXZ/JXVCymuOXi1nR+PNZzxPh/d/+JN2YV2bVdvmKUVH+j6IzO+b67RZ9mYVKM1
         MRnw==
X-Gm-Message-State: AOAM531IoAFaMe0c0UZu+IMLVP/p5jgvLkD5PERxOKE7v8B4pp/RgANF
        hVzbL9/zWyChI5XFY74GE+ntM7gzHHmYVMo0kns=
X-Google-Smtp-Source: ABdhPJyoVKlBlksPwbnlVmhZEvMPCN5eo0lsBNCZBOSE0ZcXOPSY2943MAeJSDNtlE3yVyYiVyzklA==
X-Received: by 2002:a05:6512:2348:b0:44a:3134:7d52 with SMTP id p8-20020a056512234800b0044a31347d52mr11351881lfu.207.1648754545931;
        Thu, 31 Mar 2022 12:22:25 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k10-20020a05651c10aa00b002497c4f7fadsm13015ljn.111.2022.03.31.12.22.25
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 12:22:25 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id h7so965906lfl.2
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:22:25 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr11864936lfs.27.1648754544690; Thu, 31
 Mar 2022 12:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220331110118.vr4miyyytqlssjoi@pengutronix.de> <CAHk-=wjeC-x28rn50T1oLXayZUm_xYhmRV+N8ewAXjJVZnyUAg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeC-x28rn50T1oLXayZUm_xYhmRV+N8ewAXjJVZnyUAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 12:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeYjkXDpdHwobJ1X+Tk+N8xYPe_O6CbB3zg=fKRVhYJg@mail.gmail.com>
Message-ID: <CAHk-=wjeYjkXDpdHwobJ1X+Tk+N8xYPe_O6CbB3zg=fKRVhYJg@mail.gmail.com>
Subject: Re: building Linux for ARMv7 with llvm breaks sparse
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Mar 31, 2022 at 12:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Does it all work if we just make the kernel use the normal
>
>   -meabi=gnu
>
> syntax instead?

IOW, just something like this

    --- a/arch/arm/Makefile
    +++ b/arch/arm/Makefile
    @@ -110,7 +110,7 @@ CFLAGS_ABI      +=-funwind-tables
     endif

     ifeq ($(CONFIG_CC_IS_CLANG),y)
    -CFLAGS_ABI += -meabi gnu
    +CFLAGS_ABI += -meabi=gnu
     endif

     ifeq ($(CONFIG_CURRENT_POINTER_IN_TPIDRURO),y)

that's basically what we do for all the other '-mxyz=abc' cases, so
it's really that use of -meabi that stands out as being the odd man
out.

        Linus
