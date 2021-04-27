Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4EAC433ED
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 06:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDCD613B0
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 06:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhD0Ghu (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 27 Apr 2021 02:37:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhD0Ght (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 27 Apr 2021 02:37:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619505425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVIyCdNcsW4x8PjKdsToGgt87+8FemshMVp2gK9444w=;
        b=BB+N8SpyZ6wPmPd5OaJKmHJuI9/qLz3u5wYQyXaGlXAdSLyC91ZGID6eh/PHDrUca1X0XW
        UYDTO0S2Puraw8xaLnxYkWiOhW6Egkyrr2bCv/QBMUSDmrt3xSsut8l+H1QmJWzUNud3oe
        kFD6Nx/OnXc69YBWH7E6N1yy0lCl0thUn7hmaKYQiCFTmUXXO+sCT4FL5v8nHRRC+oZ45x
        veHs40D2TFS21nejiR/qm3D2ufIg2JPivxcG+5lQWvnNBDkhd9FTkqRsCWsMgry7H0ga0n
        IrMQoKzVYga4eHCCZHuYnHVoVSjCYZrmXZeug9nkiH+V+98idVO8tte0oTgMPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619505425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVIyCdNcsW4x8PjKdsToGgt87+8FemshMVp2gK9444w=;
        b=JvcKvt9vsjPSpdmCREmF7BVAGbfk4ykNd2XSlefb/SIce8nk8s4yLG5LhEq/7/jyqb9xIr
        UqmTAAGtAO6FO9AQ==
To:     kernel test robot <lkp@intel.com>, Balbir Singh <sblbir@amazon.com>
Cc:     kbuild-all@lists.01.org
Cc:     linux-sparse@vger.kernel.org, luc.vanoostenryck@gmail.com
Subject: Re: [tglx-devel:x86/l1dflush 7/9] arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces)
In-Reply-To: <202104271144.G4fgnYlt-lkp@intel.com>
References: <202104271144.G4fgnYlt-lkp@intel.com>
Date:   Tue, 27 Apr 2021 08:37:05 +0200
Message-ID: <87r1iwnsha.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Apr 27 2021 at 11:00, kernel test robot wrote:

Cc+ sparse folks

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/l1dflush
> head:   6955fbfdad4241331d1e33362306aec3a410803a
> commit: 193cb89595f7f3f4549b03ab9392fb9838d123e3 [7/9] x86/mm: Prepare for opt-in based L1D flush in switch_mm()
> config: i386-randconfig-s032-20210426 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=193cb89595f7f3f4549b03ab9392fb9838d123e3
>         git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
>         git fetch --no-tags tglx-devel x86/l1dflush
>         git checkout 193cb89595f7f3f4549b03ab9392fb9838d123e3
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=i386 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>>> arch/x86/mm/tlb.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
>    arch/x86/mm/tlb.c:354:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
>    arch/x86/mm/tlb.c:354:13: sparse:     got bool *
>
> vim +354 arch/x86/mm/tlb.c
>
>    336	
>    337	static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
>    338					struct task_struct *next)
>    339	{
>    340		/* Flush L1D if the outgoing task requests it */
>    341		if (prev_mm & LAST_USER_MM_L1D_FLUSH)
>    342			wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
>    343	
>    344		/* Check whether the incoming task opted in for L1D flush */
>    345		if (likely(!(next_mm & LAST_USER_MM_L1D_FLUSH)))
>    346			return;
>    347	
>    348		/*
>    349		 * Validate that it is not running on an SMT sibling as this would
>    350		 * make the excercise pointless because the siblings share L1D. If
>    351		 * it runs on a SMT sibling, notify it with SIGBUS on return to
>    352		 * user/guest
>    353		 */
>  > 354		if (this_cpu_read(cpu_info.smt_active)) {

That's a valid construct and the kernel of full of percpuvar.member reads/writes.

>    355			clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
>    356			next->l1d_flush_kill.func = l1d_flush_force_sigbus;
>    357			task_work_add(next, &next->l1d_flush_kill, TWA_RESUME);
>    358		}
>    359	}
>    360	

Thanks,

        tglx
