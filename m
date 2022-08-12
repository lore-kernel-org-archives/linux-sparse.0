Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2731C00140
	for <linux-sparse@archiver.kernel.org>; Fri, 12 Aug 2022 08:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiHLIdg (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 12 Aug 2022 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLIdf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 Aug 2022 04:33:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAB9DB55
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2022 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660293211; x=1691829211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VvJQHtYNwinFPWmsvFbxgSiQA5fPUMzGOsaODt3A+T8=;
  b=kPAYmo3aWhG982YMqHHdQMQtOqe88PKHU6z2PNjqarE9umtrxNdMU1WB
   AnM4GCwRe//BDwRHk06ajePCpC+USn/iBR7CAnOJeHxw0owXS5QOmEkAC
   1Yn/TShRa7+0JU3zMNWQwJLo6kE5bosbbMvSMFThXt+UlYQt4kFrHRVRJ
   CoXiP3qku7lkOzN+QWjtv4UhLxMc535WXW2LEVy2o3dwz1uut+dg75YAi
   +wcI/ewoTBgUCVP2OjbgJRx66BYTqW/18ihIT1z93RjKMYl4nOazlm/lr
   eyGGQX61Vk/t57YjH0wjwKYdO4pWHQLakzEwkMMYA7EUIe13BUYcSr5q8
   w==;
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="186191487"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 01:33:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 01:33:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 01:33:30 -0700
Date:   Fri, 12 Aug 2022 09:33:13 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
CC:     <linux-sparse@vger.kernel.org>, <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] RISC-V: Add support fo the zihintpause extension
Message-ID: <YvYQSdQBuZGSit2s@wendy>
References: <20220811053356.17375-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220811053356.17375-1-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Aug 10, 2022 at 10:33:56PM -0700, Palmer Dabbelt wrote:
> This was recently added to binutils and with any luck will soon be in
> Linux, without it sparse will fail when trying to build new kernels on
> systems with new toolchains.

Replied once already but I am not too familar with mutt and screwed up
the CC list.
Not too keen on the released version of sparse not working during the
merge window, but w/e I'll upgrade my CI manually.

Tested-by: Conor Dooley <conor.dooley@microchip.com>
(with riscv-gnu-toolchain 2022.03.09 & clang-15/LLVM=1)

> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I re-indented the other extensions to match, and this one is on top of
> the Zicbom patch as I figured that'd be easier.
> ---
>  target-riscv.c | 50 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/target-riscv.c b/target-riscv.c
> index db0f7e57..23d28d0e 100644
> --- a/target-riscv.c
> +++ b/target-riscv.c
> @@ -5,21 +5,22 @@
>  #include <string.h>
>  #include <stdio.h>
>  
> -#define RISCV_32BIT	(1 << 0)
> -#define RISCV_64BIT	(1 << 1)
> -#define RISCV_MUL	(1 << 2)
> -#define RISCV_DIV	(1 << 3)
> -#define RISCV_ATOMIC	(1 << 4)
> -#define RISCV_FLOAT	(1 << 5)
> -#define RISCV_DOUBLE	(1 << 6)
> -#define RISCV_FDIV	(1 << 7)
> -#define RISCV_COMP	(1 << 8)
> -#define RISCV_EMBD	(1 << 9)
> -#define RISCV_FPU	(RISCV_FLOAT|RISCV_DOUBLE|RISCV_FDIV)
> -#define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
> -#define RISCV_ZICSR	(1 << 10)
> -#define RISCV_ZIFENCEI	(1 << 11)
> -#define RISCV_ZICBOM	(1 << 12)
> +#define RISCV_32BIT		(1 << 0)
> +#define RISCV_64BIT		(1 << 1)
> +#define RISCV_MUL		(1 << 2)
> +#define RISCV_DIV		(1 << 3)
> +#define RISCV_ATOMIC		(1 << 4)
> +#define RISCV_FLOAT		(1 << 5)
> +#define RISCV_DOUBLE		(1 << 6)
> +#define RISCV_FDIV		(1 << 7)
> +#define RISCV_COMP		(1 << 8)
> +#define RISCV_EMBD		(1 << 9)
> +#define RISCV_FPU		(RISCV_FLOAT|RISCV_DOUBLE|RISCV_FDIV)
> +#define RISCV_GENERIC		(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
> +#define RISCV_ZICSR		(1 << 10)
> +#define RISCV_ZIFENCEI		(1 << 11)
> +#define RISCV_ZICBOM		(1 << 12)
> +#define RISCV_ZIHINTPAUSE	(1 << 13)
>  
>  static unsigned int riscv_flags;
>  
> @@ -35,14 +36,15 @@ static void parse_march_riscv(const char *arg)
>  		{ "rv64i",	RISCV_64BIT },
>  		{ "rv64g",	RISCV_64BIT|RISCV_GENERIC },
>  	}, extensions[] = {
> -		{ "m",		RISCV_MUL|RISCV_DIV },
> -		{ "a",		RISCV_ATOMIC },
> -		{ "f",		RISCV_FLOAT|RISCV_FDIV|RISCV_ZICSR },
> -		{ "d",		RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
> -		{ "c",		RISCV_COMP },
> -		{ "_zicsr",	RISCV_ZICSR },
> -		{ "_zifencei",	RISCV_ZIFENCEI },
> -		{ "_zicbom",	RISCV_ZICBOM },
> +		{ "m",			RISCV_MUL|RISCV_DIV },
> +		{ "a",			RISCV_ATOMIC },
> +		{ "f",			RISCV_FLOAT|RISCV_FDIV|RISCV_ZICSR },
> +		{ "d",			RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
> +		{ "c",			RISCV_COMP },
> +		{ "_zicsr",		RISCV_ZICSR },
> +		{ "_zifencei",		RISCV_ZIFENCEI },
> +		{ "_zicbom",		RISCV_ZICBOM },
> +		{ "_zihintpause",	RISCV_ZIHINTPAUSE },
>  	};
>  	int i;
>  
> @@ -135,6 +137,8 @@ static void predefine_riscv(const struct target *self)
>  		predefine("__riscv_zifencei", 1, "1");
>  	if (riscv_flags & RISCV_ZICBOM)
>  		predefine("__riscv_zicbom", 1, "1");
> +	if (riscv_flags & RISCV_ZIHINTPAUSE)
> +		predefine("__riscv_zihintpause", 1, "1");
>  
>  	if (cmodel)
>  		predefine_strong("__riscv_cmodel_%s", cmodel);
> -- 
> 2.34.1
> 
