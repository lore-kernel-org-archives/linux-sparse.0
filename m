Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218D7C433FE
	for <linux-sparse@archiver.kernel.org>; Wed, 12 Oct 2022 21:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJLVMG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJLVME (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Oct 2022 17:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC07114DD3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Oct 2022 14:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D56615CC
        for <linux-sparse@vger.kernel.org>; Wed, 12 Oct 2022 21:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABCBC433D7;
        Wed, 12 Oct 2022 21:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665609122;
        bh=enT/8dP0no2FJ5bL94/4xdu02Cr7eKBJwr0Ayx9BG+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjMMnbRGj1LNO6DQL2/ps6Q2ZRctMbb9+7TErMmxT07cqVXi8PaMjlpoRhB9A415d
         B2Y1aODrLBgo2QnPfX8Yg8FkJVaLCcuYOIPHS1IB/hLRU8+GNm2oT9YjekRNjIRUdd
         7ixRzIQ9rBjwJ84eSwRNjoBjuHlGcJ6kmsAD/IGZYCCBgAp0mP217p5kG/brluaZlD
         AJI+hor2suoLBPzGPTNVxOlEWsH3QL8rr3frktXqTS7KeRAr5A+hALLZNkPjwR+8TS
         7j565wccg4h8bLgQ78zUFIw1CF55qCC8sBBwn/gyy1IDiOry2fu/g4ui0cN+EuBS27
         gileBuPpfFxRw==
Date:   Wed, 12 Oct 2022 22:11:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        luc.vanoostenryck@gmail.com
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, luc.vanoostenryck@gmail.com,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Add support for the zicbom extension
Message-ID: <Y0ctngWSXWupub2O@spud>
References: <20220811033138.20676-1-palmer@rivosinc.com>
 <YvYOc9Mk8y1dFvnp@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvYOc9Mk8y1dFvnp@wendy>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Aug 12, 2022 at 09:25:23AM +0100, Conor Dooley wrote:
> On Wed, Aug 10, 2022 at 08:31:38PM -0700, Palmer Dabbelt wrote:
> > This was recently added to binutils and with any luck will soon be in
> > Linux, without it sparse will fail when trying to build new kernels on
> > systems with new toolchains.
> > 
> 
> In passing while testing the zihintpause one:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Hey Luc,
Would you be able to take a look at this patch and at
https://lore.kernel.org/linux-sparse/YvYQSdQBuZGSit2s@wendy/T/#t
please? They're causing sparse to fail for recent kernels when the
extensions are used.

Thanks,
Conor.

> 
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  target-riscv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/target-riscv.c b/target-riscv.c
> > index 217ab7e8..db0f7e57 100644
> > --- a/target-riscv.c
> > +++ b/target-riscv.c
> > @@ -19,6 +19,7 @@
> >  #define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
> >  #define RISCV_ZICSR	(1 << 10)
> >  #define RISCV_ZIFENCEI	(1 << 11)
> > +#define RISCV_ZICBOM	(1 << 12)
> >  
> >  static unsigned int riscv_flags;
> >  
> > @@ -41,6 +42,7 @@ static void parse_march_riscv(const char *arg)
> >  		{ "c",		RISCV_COMP },
> >  		{ "_zicsr",	RISCV_ZICSR },
> >  		{ "_zifencei",	RISCV_ZIFENCEI },
> > +		{ "_zicbom",	RISCV_ZICBOM },
> >  	};
> >  	int i;
> >  
> > @@ -131,6 +133,8 @@ static void predefine_riscv(const struct target *self)
> >  		predefine("__riscv_zicsr", 1, "1");
> >  	if (riscv_flags & RISCV_ZIFENCEI)
> >  		predefine("__riscv_zifencei", 1, "1");
> > +	if (riscv_flags & RISCV_ZICBOM)
> > +		predefine("__riscv_zicbom", 1, "1");
> >  
> >  	if (cmodel)
> >  		predefine_strong("__riscv_cmodel_%s", cmodel);
> > -- 
> > 2.34.1
> > 
> 
