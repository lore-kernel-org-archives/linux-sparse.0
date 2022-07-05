Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD3C433EF
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jul 2022 23:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiGEXJF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 5 Jul 2022 19:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiGEXJC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 5 Jul 2022 19:09:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90150140BB
        for <linux-sparse@vger.kernel.org>; Tue,  5 Jul 2022 16:09:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id o18so11458539pgu.9
        for <linux-sparse@vger.kernel.org>; Tue, 05 Jul 2022 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=z8EKfgRX0wThVoewP5wZ3r1yeN0h/8IMac2/h3YDe7I=;
        b=BK8FYUugTCWAPVoY2qcCxvo1PCPnf5zl6hjLvKmhg+LKpoNRDnQEndHZLEYRll0zk3
         8FL0J0rgAkwpOjwIYjSb40V2nKDdipnzi3YMb3rG1UJsltyWDElPNfESAUBXuMY40VSV
         o3K6zIhZRY062fYakbVti4zmlBPCCU6+aNVUQqwkgq7RugpXGgtEWBKodCUgr37tOgC7
         pDjKVjpck+Fdaj3qKrzrNmBz5g9rgxHqKfLBTmLvQTsEWJiZqc/mq1uJnV0rTvWBs152
         ar5AR8G+dduxlYGnzVqbQ9NEXybqKzt/XyBzmmYFHjwO1zT+nOSezNkbPTvMg3gmvBkg
         KkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=z8EKfgRX0wThVoewP5wZ3r1yeN0h/8IMac2/h3YDe7I=;
        b=V47jW3BPLT60P1YqxzJqE6glFf47NqHgREyGsuZ7nW/biHCZQnSsq14U8WLfCZN+Pn
         260Mkk1BRiNq0CHrOM1pm4m+Lukz0bd+9eATeXoyAQJ7vaWUQAd4FfwJWWZG5T595fYR
         CbfgKYqR85vpzLJYF6oek5Mbsn4xAjGFRB8Q6m7kCuqORAtzV/xI+4iW4rmfcCmgqYGY
         AXK0TGzKXwUe78yi8Cpb6Yo6GKVsB+RYh9ivWlp5nCeOU6j/c8FGIO2dkm3AvJZnNRod
         xgq1yAKOea8ZW/KQswZ87JfVN/dLmlfJ18qN9DTFPDh+vz5jP6zxEJFVC5rim1ZyKRM3
         xeFA==
X-Gm-Message-State: AJIora8R2GUg1YsqaX8vp5ZIEmiZ03zAIMIa4EJqzZZoKjfWUidYsY0t
        Ys10krPKl9+MWJXUpBojRIa7cVEnrwMiNg==
X-Google-Smtp-Source: AGRyM1uaXORTwb0ZRybtB59eAa2VAOw3qiqMgTloECFVIf7k0bbcwET7ZNLv2JIxwd1D/fVc/EuK7g==
X-Received: by 2002:a63:9b0a:0:b0:406:8c31:47e6 with SMTP id r10-20020a639b0a000000b004068c3147e6mr31114432pgd.329.1657062540886;
        Tue, 05 Jul 2022 16:09:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b0016bd16f8acbsm7968883plf.114.2022.07.05.16.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 16:09:00 -0700 (PDT)
Date:   Tue, 05 Jul 2022 16:09:00 -0700 (PDT)
X-Google-Original-Date: Tue, 05 Jul 2022 16:08:58 PDT (-0700)
Subject:     Re: [PATCH v1 0/6] RISC-V -march handling improvements
In-Reply-To: <20220521212325.lw6fdzsmlwvioggv@mail>
CC:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     luc.vanoostenryck@gmail.com
Message-ID: <mhng-6db3942c-ae4a-497e-bda1-01e7e2661595@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, 21 May 2022 14:23:25 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> On Fri, Apr 01, 2022 at 10:00:35PM -0700, Palmer Dabbelt wrote:
>
> Hi,
>
> Thank you for these patches and please accept my apologies
> for this much delayed reply.

No worries, looks like we're about equally slow ;)

> I've just pushed the Zicsr and Zifencei patches since these solve
> an immediate problem and I've some minor questions/objections for
> the other ones.

From looking at sparse/master, it looks like a lot of those comments got 
resolved and merged.  That all looks good to me, I pointed my local 
sparse over to ce1a6720 ("Merge branches 'unreplaced' and 'inline'") and 
will be using that (via `make ... C=1 CF="-Wno-sparse-error"`) in my 
pre-merge testing until something changes.

Thanks!
