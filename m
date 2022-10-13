Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15604C4332F
	for <linux-sparse@archiver.kernel.org>; Thu, 13 Oct 2022 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJMLfQ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 13 Oct 2022 07:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJMLfO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Oct 2022 07:35:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3438A0D
        for <linux-sparse@vger.kernel.org>; Thu, 13 Oct 2022 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665660909; x=1697196909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qMj1bKanK1c2EKhcZ1fsPSdUxovkOWrvRQCIDt1v7Z0=;
  b=ltwAydD5wcqcYSX4BowQxjthtE5LYkdvjqlrwlG7t9AJ7X1V287XHFO8
   4w2G0qzzMHfcecjik1aGESliJtE4WlsLUOrDShqnCCGbEWtpYWIUPZYdw
   ljuBGQKZ+cBpmrZxQ9AxY+NDkbkoz+vnZsh3Pc1z///Npq3GONgcwYXBy
   dp7Mp4U1IDNuTo91FmMKvsN2EPY2pEcL1NXcoOKewZlPM5/oyQyS9yfmS
   vCbNbtu1XPlEZ0tWImiluTUmx0Lu5TpCNRNtRt7p/2ZWFKlnwosSdKDQg
   gPDEtpVUfMKrpvz98Umf1PfdhBIyJd5j/df1M4kX3rvxetHY2iKR/I5df
   A==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="118365819"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Oct 2022 04:35:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 13 Oct 2022 04:35:07 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 13 Oct 2022 04:35:06 -0700
Date:   Thu, 13 Oct 2022 12:34:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
CC:     Conor Dooley <conor@kernel.org>, <luc.vanoostenryck@gmail.com>,
        <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add support for the zicbom extension
Message-ID: <Y0f31LvsmVePDzo0@wendy>
References: <Y0ctngWSXWupub2O@spud>
 <mhng-42e79e92-7b14-4539-aed6-f848ac6f10c4@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-42e79e92-7b14-4539-aed6-f848ac6f10c4@palmer-ri-x1c9a>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Oct 12, 2022 at 04:34:00PM -0700, Palmer Dabbelt wrote:
> On Wed, 12 Oct 2022 14:11:58 PDT (-0700), Conor Dooley wrote:
> > On Fri, Aug 12, 2022 at 09:25:23AM +0100, Conor Dooley wrote:
> > > On Wed, Aug 10, 2022 at 08:31:38PM -0700, Palmer Dabbelt wrote:
> > > > This was recently added to binutils and with any luck will soon be in
> > > > Linux, without it sparse will fail when trying to build new kernels on
> > > > systems with new toolchains.
> > > >
> > > 
> > > In passing while testing the zihintpause one:
> > > Tested-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Hey Luc,
> > Would you be able to take a look at this patch and at
> > https://lore.kernel.org/linux-sparse/YvYQSdQBuZGSit2s@wendy/T/#t
> > please? They're causing sparse to fail for recent kernels when the
> > extensions are used.
> 
> Just kind of thinking out loud here, but:

Wee brain dump in response, dunno if I am missing your point & if so
please correct me...

> 
> Another option would be to just convert the kernel over to Kconfig-based
> ifdefs and ignore the -march stuff in sparse.  As per the discussion over
> here <https://github.com/riscv/riscv-isa-manual/issues/869> it looks like

hmm, gnu tools meetings - are bystanders like myself allowed to attend?
I doubt I'd have anything interesting to say, but given the names it
seems like a good thing to keep an eye on.

To be blunt, if the toolchain people are not clear on what the craic is
with how extensions interact how are the rest of us supposed to get it?
In my naivety I'd expect that sort of distinction to be clear from the
spec docs...

By kconfig based, do you mean w/ the sort of thing I was messing with in
this patchset:
https://lore.kernel.org/linux-riscv/20221006173520.1785507-2-conor@kernel.org/

I really don't like having ifdef-ery, seems to just result in missed
conditions as the recent Zicbom stuff has shown. Since it's thinking-
out-loud o clock - while its not my place to make decisions, I think for
future extension patchsets I am going to try and push people towards as
few conditionally defined variables etc as possible.
I think you said the other day that things like __riscv_zmmul are
conditionally defined based on the toolchain supporting them right?
That'd make sense since older toolchains wouldn't know they existed...
Anyways, what I meant by all that is that instead of ifdef-ery, I'd
rather IS_ENABLED() with unconditionally {defined,defined} variables so
that we don't end up with little pockets of code that end up missed
because of some overlapping extension ifdef hell.

Upstream seems to have a lot of people that run bells & whistles
toolchains with the new & shiny toys available or the standard
riscv-gnu-toolchain builds of something significantly older. I'd just be
a little worried about potentially having poor coverage of some odd
combinations of things with #ifdefs.

> we're going to end up with different string->behavior mappings for user-mode
> vs privileged software and compilers will be expected to follow the
> user-mode mappings, so we'll probably have to do this at some point anyway.

Could you explain this one a little more? Even after reading that issue
I am a little unsure what you mean by different string->behaviour
mappings. Something along the lines of some Zfoo extension could deny
user-mode software from using certain instructions but in kernel-land we
would want to (or need to?) use those instructions?

> That would mean sparse only works right for Linux, I'm not sure if that's
> the design point today or not.  If that's an issue we could still convert
> Linux over and then just have some sort of "--sparse-ignore-march-on-riscv"

Do we ignore march, or could we just chop the string after the single
letter extensions? I am not up on how much of (if any) of the march
string is/would ever be used. I had a quick look at target-riscv.c and
it seems we just use it to predefine __riscv_foo & set xlen. Does that
mean if we used ifdef-ery or IS_ENABLED to gate features we could avoid
having to use new __riscv_foo symbols and therefore not have to
predefine them in sparse? Maybe I am misunderstanding - something,
something out of my depth...

> argument so we don't keep coupling kernel builds to sparse updates.  There's
> going to be a ton of new extensions so this kind of thing is just going to
> keep happening.

Yeah, it'd be nice to avoid having to deal with new march updates
constantly, especially since we cannot expect everyone to run ToT sparse
either. The current situation makes me wonder who outside the pair of us
is even running sparse in the first place?

Thanks,
Conor.



> > > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > ---
> > > >  target-riscv.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/target-riscv.c b/target-riscv.c
> > > > index 217ab7e8..db0f7e57 100644
> > > > --- a/target-riscv.c
> > > > +++ b/target-riscv.c
> > > > @@ -19,6 +19,7 @@
> > > >  #define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
> > > >  #define RISCV_ZICSR	(1 << 10)
> > > >  #define RISCV_ZIFENCEI	(1 << 11)
> > > > +#define RISCV_ZICBOM	(1 << 12)
> > > >
> > > >  static unsigned int riscv_flags;
> > > >
> > > > @@ -41,6 +42,7 @@ static void parse_march_riscv(const char *arg)
> > > >  		{ "c",		RISCV_COMP },
> > > >  		{ "_zicsr",	RISCV_ZICSR },
> > > >  		{ "_zifencei",	RISCV_ZIFENCEI },
> > > > +		{ "_zicbom",	RISCV_ZICBOM },
> > > >  	};
> > > >  	int i;
> > > >
> > > > @@ -131,6 +133,8 @@ static void predefine_riscv(const struct target *self)
> > > >  		predefine("__riscv_zicsr", 1, "1");
> > > >  	if (riscv_flags & RISCV_ZIFENCEI)
> > > >  		predefine("__riscv_zifencei", 1, "1");
> > > > +	if (riscv_flags & RISCV_ZICBOM)
> > > > +		predefine("__riscv_zicbom", 1, "1");
> > > >
> > > >  	if (cmodel)
> > > >  		predefine_strong("__riscv_cmodel_%s", cmodel);
> > > > --
> > > > 2.34.1
> > > >
> > > 
> 
