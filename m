Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F286C433ED
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B27613EF
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 19:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhD0Tyq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0Tyq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 27 Apr 2021 15:54:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33FAC061574
        for <linux-sparse@vger.kernel.org>; Tue, 27 Apr 2021 12:54:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619553241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3CICRMVpvYe+Jxd0FaD6Rw/LEy+roYh6xNKA3HojBk=;
        b=CjA6RwvS/cylIGTGa0cu4hwZQjIfl12JWiCMhW6ilMQz3sIG+FAH6vXARW3tFvfn1JYvY0
        cOdYDXy9WMBdkaal6a6B+qVKV1Ewaaj/r1rUg+DukSyP+sSgJFF7fJMKTjMLJOXihtIjsc
        sOHv73OouOCzw83nA7MfkaX9+FMPeMCUnOMvuEfAEw48gtkM0ZzlhnJ4btp0HC4B3KzDPE
        oFx4+h3mtIChSIhxQ1ijHHhV6HWnpw9T5z+bOCbXAOnnlNKF047CZdW94QvSbH1X8PTms/
        8WteUtMvgNV7W1GtXGHrNrePc5Tyj6Xz1rQqCMCeHRAJbo7XRjcJ8FVFEc9aQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619553241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3CICRMVpvYe+Jxd0FaD6Rw/LEy+roYh6xNKA3HojBk=;
        b=HWoPL629ZwPmaN8OoKOVWei2dNFW4GEi+eG2l3c2OOq56tfyKfhyjKL2A8KHWH6iDjWkVv
        nO7ES7K+5MhU8HDg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Balbir Singh <sblbir@amazon.com>, kbuild-all@lists.01.org,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [tglx-devel:x86/l1dflush 7/9] arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces)
In-Reply-To: <CAHk-=wiJ7_LCn19AGj+8mS5bV1jr4S1_6errsnfoZc0PdCNp9A@mail.gmail.com>
References: <202104271144.G4fgnYlt-lkp@intel.com> <87r1iwnsha.ffs@nanos.tec.linutronix.de> <CAHk-=wiJ7_LCn19AGj+8mS5bV1jr4S1_6errsnfoZc0PdCNp9A@mail.gmail.com>
Date:   Tue, 27 Apr 2021 21:54:01 +0200
Message-ID: <87a6pjo65i.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Apr 27 2021 at 10:00, Linus Torvalds wrote:
> On Mon, Apr 26, 2021 at 11:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> >  > 354                if (this_cpu_read(cpu_info.smt_active)) {
>>
>> That's a valid construct and the kernel of full of percpuvar.member reads/writes.
>
> Hmm. "cpu_info" doesn't seem to be marked as a percpu data structure.
>
> Is this perhaps a UP config? Because we have:
>
>   extern struct cpuinfo_x86       boot_cpu_data;
>     ...
>   #ifdef CONFIG_SMP
>   DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
>   #define cpu_data(cpu)           per_cpu(cpu_info, cpu)
>   #else
>   #define cpu_info                boot_cpu_data
>   #define cpu_data(cpu)           boot_cpu_data
>   #endif
>
> and notice how if CONFIG_SMP isn't set, 'cpu_info' just turns into a
> regular non-percpu thing.
>
> But the sparse checking doesn't go away just because it's compiled for UP.

Duh yes. I'm a moron.
