Return-Path: <SRS0=iZGx=72=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA696C433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 13 Jun 2020 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A450320792
	for <linux-sparse@archiver.kernel.org>; Sat, 13 Jun 2020 14:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXuwHu8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFMO3H (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 13 Jun 2020 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMO3G (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 13 Jun 2020 10:29:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437E6C03E96F;
        Sat, 13 Jun 2020 07:29:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o15so12894719ejm.12;
        Sat, 13 Jun 2020 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+BkDFDheDHOPpgm1F921wfzFLj6m4THP0S3m//P7le8=;
        b=YXuwHu8ff6zs06tRTRiny1vPe+ybEdBxhKg3ZxyfyYe7KYTwOOBXiAZvIOiaTbMNhn
         kjL5Oy4TstXbciUqXyk7vCU0SyxhF+M72/6jIHSPdB8OdgncpWF8t0oqtDdqftiMKYBp
         /Xfwbyrq/Z+O4JgYekypIXuKk9nAYMjkB3iBu/iT+13fPC2JGFC1CSettBsCP73ueL33
         7u9jsAHqQosNR9ONydbExpvsuDphj5siDsLsnX4P6Vq72i3gGVMTw6vM6CU2ySvt7KT1
         R3R8CxG8nc1kyW7YZRER94kPfzruQZPXDqeVKJSe77qYUDA9Wn6mS1W9NPJN4/uZt3id
         8HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+BkDFDheDHOPpgm1F921wfzFLj6m4THP0S3m//P7le8=;
        b=VsuiuW2yAfKTGSexszQLi5xI7I89EDVqxdKJGlt1TLCnWXqE67jGP5OhGL8BgsAaBK
         SGqAmtZv74gbbW7/cMrRKqQqRXNlWNgGXqmvS5n54FRgMVuuc8c+K/DbkzjO5xWPY+6v
         9ofncDPKnKjBIIEX/qZOn8WKtWDHZwixksdD0L+IqWpamntOLKAThhxvR8nDeMYquJDX
         vkcW0RoqjqZMGT4jkGDBbbZvrP8s1+sDdj+b9xVzcVYoRyq3zp2P9FaWGT9W+9H7N98y
         H/a6iZfQlqESf4TMBPcHNULRt5mdP5CFOr1dDyVdaHD43tt/g4hZvrLckVjfdTS+CdtM
         tKDQ==
X-Gm-Message-State: AOAM530LHIhkv6mEaYPpp73ufR0/7GT4jTMcR9sdrY0PxfHUDjrcbG66
        i8HZxet0dz+PJ8MEfUNnZc0=
X-Google-Smtp-Source: ABdhPJxyhQNJ4bAigIo3yiP/n0LNFOOCbb92aqQdHj+9uqkoQCfYdiBa+7gwIZiftbFKMs6lLBaCuQ==
X-Received: by 2002:a17:906:c102:: with SMTP id do2mr17440801ejc.126.1592058543630;
        Sat, 13 Jun 2020 07:29:03 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:2959:2a41:9bce:9e89])
        by smtp.gmail.com with ESMTPSA id j2sm5001629edn.30.2020.06.13.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 07:29:02 -0700 (PDT)
Date:   Sat, 13 Jun 2020 16:29:01 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>, linux-sparse@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200613142901.65xieioomt6bbqa6@ltop.local>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200613122834.GA23739@xsang-OptiPlex-9020>
 <20200613130949.GA22005@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200613130949.GA22005@gondor.apana.org.au>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200613142901.qqsiYgseNT5jpuoY0rmBYXN_0z0eFkUKhx_6nw5a5y8@z>

On Sat, Jun 13, 2020 at 11:09:49PM +1000, Herbert Xu wrote:
> On Sat, Jun 13, 2020 at 08:28:34PM +0800, kernel test robot wrote:
> > 
> > Hi Herbert,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v5.7 next-20200611]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Herbert-Xu/printk-Make-linux-printk-h-self-contained/20200611-205340
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b29482fde649c72441d5478a4ea2c52c56d97a5e
> > :::::: branch date: 13 hours ago
> > :::::: commit date: 13 hours ago
> > config: powerpc-randconfig-s031-20200611 (attached as .config)
> > compiler: powerpc64le-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-250-g42323db3-dirty
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 ARCH=powerpc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
> >    include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
> >    include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
> >    include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
> >    include/linux/ratelimit_types.h:24:1: sparse: sparse: got }
> 
> This looks like a bug in sparse as the same code compiles just
> fine.

Hi,

When trying to reproduce, before using sparse, I get:
      CC      kernel/ptrace.o
    In file included from ./include/linux/printk.h:10:0,
                     from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/lockdep.h:43,
                     from ./include/linux/spinlock_types.h:18,
                     from ./arch/powerpc/include/asm/lppaca.h:45,
                     from ./arch/powerpc/include/asm/paca.h:17,
                     from ./arch/powerpc/include/asm/current.h:13,
                     from ./include/linux/sched.h:12,
                     from kernel/ptrace.c:13:
    ./include/linux/ratelimit_types.h:16:2: error: unknown type name ‘raw_spinlock_t’
      raw_spinlock_t lock;  /* protect the state */
      ^
    In file included from ./include/linux/wait.h:9:0,
                     from ./include/linux/pid.h:6,
                     from ./include/linux/sched.h:14,
                     from kernel/ptrace.c:13:
    ./include/linux/ratelimit.h: In function ‘ratelimit_state_init’:
    ./include/linux/spinlock.h:100:16: warning: passing argument 1 of ‘__raw_spin_lock_init’ from incompatible pointer type [enabled by default]
      static struct lock_class_key __key;    \
                    ^
    ./include/linux/ratelimit.h:14:2: note: in expansion of macro ‘raw_spin_lock_init’
      raw_spin_lock_init(&rs->lock);
      ^
    ./include/linux/spinlock.h:95:15: note: expected ‘struct raw_spinlock_t *’ but argument is of type ‘int *’
       extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
                   ^
    make[1]: *** [scripts/Makefile.build:281: kernel/ptrace.o] Error 1
    make: *** [Makefile:1777: kernel] Error 2


while there is no such problem with the previous commit.
I think the problem is that:
* ratelimit.h needs raw_spinlock_t
* spinlock_types.h needs lockdep.h
* lockdep.h needs ratelimit.h


Best regards,
Luc
