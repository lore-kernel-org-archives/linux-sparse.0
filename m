Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE15C433B4
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F2F61168
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhD0RBz (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 27 Apr 2021 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbhD0RBv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 27 Apr 2021 13:01:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFCFC061574
        for <linux-sparse@vger.kernel.org>; Tue, 27 Apr 2021 10:01:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u20so69000226lja.13
        for <linux-sparse@vger.kernel.org>; Tue, 27 Apr 2021 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ou6Ji6Qk6xqPOVVVdgTd/5J5sCVvkIOXU4iarRF6BjU=;
        b=JlZ7dAFn1ER4uLH1d1RupAU/lxxgpurUmnblqyRptg6CwCP/+fU0qMMAuZGwqxDmCz
         zzPU+wyiPZeb/eW7tbOoKc+XRYqgyRoakozLRcIDdT8PWkDZkeUHTJvVaa1aSrOd3lw1
         B5kwhmWBlVYxZLcvG+ghIoGAwxDqRnicJtGIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ou6Ji6Qk6xqPOVVVdgTd/5J5sCVvkIOXU4iarRF6BjU=;
        b=uPlUBhagK/xqN1O9v1e9sds8S2aR/yTpwEDt7ZNNcPKdjK0mcq5hejvx6WOtPCuG2/
         OVsirfXev/JSCSMCgi5r837to2qjT2WYa/Q977sfE8lAYd34awEeyQFEEyOcpsbEbgXg
         WttHIMXshL+0iBgq9Dc+qlE/RGMMc3aTW4LInnDPEjRS+mBZ6G0MJucadbvXhwIhfCj1
         BEamqYxEqHcbPqbk1wANPI3OKQ6ikhI9/StN63s4X2aI0VSmnYi+aNmzUHdKHCngAxji
         UJLIhmRKZAN+CWhJGCb3whqux1W/kdfyBbHTd7T2wJDhbr7P0s1i86nJXLDul/RR1z+s
         VW+g==
X-Gm-Message-State: AOAM530sqV6MWVfF2qi3H+V2IhavF7BtA4z8ZelW0fs8s4bhiztbY1EM
        38xcY+NFDgt7qScmI4FIX2xyoWn1BPc9tPF+
X-Google-Smtp-Source: ABdhPJwM8+lvKP5AFVhsOxh1Z69ab70aYDLcBQLzjS/g1gkY6YsbTq6iYx7LN+XcRLJzEDV9HHfIPA==
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr16889910ljr.467.1619542864867;
        Tue, 27 Apr 2021 10:01:04 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id j10sm99332lfb.176.2021.04.27.10.01.04
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 10:01:04 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id o16so68973738ljp.3
        for <linux-sparse@vger.kernel.org>; Tue, 27 Apr 2021 10:01:04 -0700 (PDT)
X-Received: by 2002:a2e:1406:: with SMTP id u6mr16701419ljd.61.1619542864130;
 Tue, 27 Apr 2021 10:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <202104271144.G4fgnYlt-lkp@intel.com> <87r1iwnsha.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87r1iwnsha.ffs@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 10:00:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ7_LCn19AGj+8mS5bV1jr4S1_6errsnfoZc0PdCNp9A@mail.gmail.com>
Message-ID: <CAHk-=wiJ7_LCn19AGj+8mS5bV1jr4S1_6errsnfoZc0PdCNp9A@mail.gmail.com>
Subject: Re: [tglx-devel:x86/l1dflush 7/9] arch/x86/mm/tlb.c:354:13: sparse:
 sparse: incorrect type in initializer (different address spaces)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Balbir Singh <sblbir@amazon.com>, kbuild-all@lists.01.org,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Apr 26, 2021 at 11:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> >  > 354                if (this_cpu_read(cpu_info.smt_active)) {
>
> That's a valid construct and the kernel of full of percpuvar.member reads/writes.

Hmm. "cpu_info" doesn't seem to be marked as a percpu data structure.

Is this perhaps a UP config? Because we have:

  extern struct cpuinfo_x86       boot_cpu_data;
    ...
  #ifdef CONFIG_SMP
  DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
  #define cpu_data(cpu)           per_cpu(cpu_info, cpu)
  #else
  #define cpu_info                boot_cpu_data
  #define cpu_data(cpu)           boot_cpu_data
  #endif

and notice how if CONFIG_SMP isn't set, 'cpu_info' just turns into a
regular non-percpu thing.

But the sparse checking doesn't go away just because it's compiled for UP.

              Linus
