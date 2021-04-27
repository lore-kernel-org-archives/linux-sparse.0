Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C6C433ED
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 19:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC77D60BBB
	for <linux-sparse@archiver.kernel.org>; Tue, 27 Apr 2021 19:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhD0TYF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbhD0TX5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 27 Apr 2021 15:23:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC56C061574
        for <linux-sparse@vger.kernel.org>; Tue, 27 Apr 2021 12:23:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z5so34816661edr.11
        for <linux-sparse@vger.kernel.org>; Tue, 27 Apr 2021 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Th6CHuv/BavKWVhjOR3C+azFZHY5/Y0kXS0Bq1FxIQ=;
        b=MAkUDvfDv1fDJ8jrD9KnXjvibaAseAZGPYEgEMmkYM5dPkkGDluw+a3Q5SN0GZSevJ
         yf12GOPP+gELEekqslMIapbSEqXSQAwwO4OFsT0Vbi4npBRMCfZdoB7YhGvScPveSBJM
         3GOh0GZuI1K/Ztyy+N0Yo3U18ntz3EWM+faVkw6SPzBoPWcSNDd2UWNRXxCXjbR9CeQf
         o6Ytxjr1cVOt8NYaxDmd/bfMon8BpPulqKmYkCr/vThE9m4Ir2+TUuiY7KMibVLfXO8v
         VDUM7QNiyXzZ7Lzuw/C+KY5IsWEo5ushIgw7Xg8WMuuOohiP+jLBvfSZKvgLdFTAj3c+
         Bg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Th6CHuv/BavKWVhjOR3C+azFZHY5/Y0kXS0Bq1FxIQ=;
        b=Z3ipZ8pKhrW6SYqcYegxV3VRn6ffYI+yeNvqcfAB66GrT7aZk8uK986WuOs2tED2HJ
         fW07cuGs65etrHGxn3eJuxctifoyIOFqTI8Bt4ViSskHLeqL2NOaoJ/vU0fCRUhDUjsJ
         KY7PDOb3NmKtURm6ql2xoJzi6Ni6R56NOChJ66irQc7gknZNeP+kayN8UXYUUulhvYZJ
         cfkgHXQOAsPhJgx70M4WhdjF9he8M19SkYSBlrJ9lAGfJoyadguJMqlIi1PWsP6w1R7t
         HHpSiJ+bFBQZr9CP+r/h+6UpXJ1pAqFhwHteaYfmfRZ9PC3itLTxLmSQmkn84zzHQ6qA
         0opA==
X-Gm-Message-State: AOAM5334+KpWYkKv3HgqgWSsweiJYW9pTkb98tHDBYbHFlgvxverdHot
        uCCv2xc9i4//locADbNcR4A=
X-Google-Smtp-Source: ABdhPJxIFTCDFgo4wD/oqaxCjCAZbxVMIqpuHqbhWBCn1bB5mhx5MO7IupMt4UpkJhCWKteEYHPZyA==
X-Received: by 2002:a05:6402:682:: with SMTP id f2mr6280206edy.297.1619551391306;
        Tue, 27 Apr 2021 12:23:11 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:a991:30f3:a399:4cad])
        by smtp.gmail.com with ESMTPSA id e16sm3068837edu.94.2021.04.27.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:23:10 -0700 (PDT)
Date:   Tue, 27 Apr 2021 21:23:09 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        Balbir Singh <sblbir@amazon.com>, kbuild-all@lists.01.org,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [tglx-devel:x86/l1dflush 7/9] arch/x86/mm/tlb.c:354:13: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <20210427192309.4xlodmvsppcdoa4l@mail>
References: <202104271144.G4fgnYlt-lkp@intel.com>
 <87r1iwnsha.ffs@nanos.tec.linutronix.de>
 <CAHk-=wiJ7_LCn19AGj+8mS5bV1jr4S1_6errsnfoZc0PdCNp9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJ7_LCn19AGj+8mS5bV1jr4S1_6errsnfoZc0PdCNp9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Apr 27, 2021 at 10:00:48AM -0700, Linus Torvalds wrote:
> On Mon, Apr 26, 2021 at 11:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > >  > 354                if (this_cpu_read(cpu_info.smt_active)) {
> >
> > That's a valid construct and the kernel of full of percpuvar.member reads/writes.
> 
> Hmm. "cpu_info" doesn't seem to be marked as a percpu data structure.
> 
> Is this perhaps a UP config? Because we have:

Yes, most probably.
Just to be sure, I checked with i386_defconfig (which is SMP) and
sparse doesn't complain (but then does if CONFIG_SMP is set to 'n').

-- Luc
