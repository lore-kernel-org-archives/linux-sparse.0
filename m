Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE5CC4332F
	for <linux-sparse@archiver.kernel.org>; Wed, 12 Oct 2022 23:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJLXeD (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 12 Oct 2022 19:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJLXeC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Oct 2022 19:34:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59168792E8
        for <linux-sparse@vger.kernel.org>; Wed, 12 Oct 2022 16:34:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n7so324644plp.1
        for <linux-sparse@vger.kernel.org>; Wed, 12 Oct 2022 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWYZ5J1tnbJKX6/CtyunBkjkf9bQiY8i4mqhDK+wTL4=;
        b=bT6BDiswhS/ABgb6nudPCgrt/zDOFLyeZMziqLuUf1gDBLiIPBSDRMP9ZN05ULfpUL
         sLMzC+XIgx+3KXx10ox04GvJ3fj7yXvkJ5DLDso96/EA+dlTDLrvX88o669CNaDl2w+4
         jTdqUDszmTM1+XSt52L0I71oy/yaahVlIVCRB44mD7MiKEUjBvHiwNtbY1Exkvtb/8aH
         Dl68j0HjvfRDQZggcxFSelXtCYpTwPeDnkBqwCf19acz0OHTnply30gHO2PhSQUihD+Q
         spZa94lAcgE3xh1ZZT3a2eYzqohNwZ2ranvePkfFigzrGS4/P6+zZ+FSi/FSJUpHqei8
         cBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWYZ5J1tnbJKX6/CtyunBkjkf9bQiY8i4mqhDK+wTL4=;
        b=fTFJ1wSJjlHdMiwf72GBH/KNAQdVNcUdKikXXHL8fvx7k+FUYc/4p1CKTt+Iss5lJ/
         jxPZfeFErOeciLJFKpkY6DOWBtbpcm1/HxtwAtsm8gS0On/5VrCvqClBu8PJcWkUmpAx
         zIz81MVPqbc9fa5134Y/BjHi2BRSf5AuD7ULlMEkBOKMoOakRqao44h/0JejAj0NZct4
         KxgiK/gmucvnKBuJIuonwcce4nfGHq263K4XACNx8zcq9ewaBosxR2axjjWVIs54F7sR
         kegDgyQEeBmAGq7UfTwqfqV5S17woZVbhb/UnZrJowROlaqieQs6uTqiUUf6wHdY9an4
         FDtw==
X-Gm-Message-State: ACrzQf1Lx+mdorvI4gIwFxBWlADqwpEh3YuPr8Q1lXT924l8iSXHR+2t
        31uV+GEE44cjIgy9Qn7F4BbDqsCxfQlF8A==
X-Google-Smtp-Source: AMsMyM6pBn693Ns4xp+qY1HZ0uTrotYdw16sW2A293DC5FvltlVyoCYM2rrOfTy4/nOpmf1C9hWztA==
X-Received: by 2002:a17:903:2d1:b0:183:2b26:575d with SMTP id s17-20020a17090302d100b001832b26575dmr14492510plk.77.1665617640652;
        Wed, 12 Oct 2022 16:34:00 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v125-20020a622f83000000b00562ef28aac6sm385288pfv.185.2022.10.12.16.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 16:34:00 -0700 (PDT)
Date:   Wed, 12 Oct 2022 16:34:00 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Oct 2022 16:34:10 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Add support for the zicbom extension
In-Reply-To: <Y0ctngWSXWupub2O@spud>
CC:     conor.dooley@microchip.com, luc.vanoostenryck@gmail.com,
        linux-sparse@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-42e79e92-7b14-4539-aed6-f848ac6f10c4@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, 12 Oct 2022 14:11:58 PDT (-0700), Conor Dooley wrote:
> On Fri, Aug 12, 2022 at 09:25:23AM +0100, Conor Dooley wrote:
>> On Wed, Aug 10, 2022 at 08:31:38PM -0700, Palmer Dabbelt wrote:
>> > This was recently added to binutils and with any luck will soon be in
>> > Linux, without it sparse will fail when trying to build new kernels on
>> > systems with new toolchains.
>> >
>>
>> In passing while testing the zihintpause one:
>> Tested-by: Conor Dooley <conor.dooley@microchip.com>
>
> Hey Luc,
> Would you be able to take a look at this patch and at
> https://lore.kernel.org/linux-sparse/YvYQSdQBuZGSit2s@wendy/T/#t
> please? They're causing sparse to fail for recent kernels when the
> extensions are used.

Just kind of thinking out loud here, but:

Another option would be to just convert the kernel over to Kconfig-based 
ifdefs and ignore the -march stuff in sparse.  As per the discussion 
over here <https://github.com/riscv/riscv-isa-manual/issues/869> it 
looks like we're going to end up with different string->behavior 
mappings for user-mode vs privileged software and compilers will be 
expected to follow the user-mode mappings, so we'll probably have to do 
this at some point anyway.

That would mean sparse only works right for Linux, I'm not sure if 
that's the design point today or not.  If that's an issue we could still 
convert Linux over and then just have some sort of 
"--sparse-ignore-march-on-riscv" argument so we don't keep coupling 
kernel builds to sparse updates.  There's going to be a ton of new 
extensions so this kind of thing is just going to keep happening.

>
> Thanks,
> Conor.
>
>>
>> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > ---
>> >  target-riscv.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/target-riscv.c b/target-riscv.c
>> > index 217ab7e8..db0f7e57 100644
>> > --- a/target-riscv.c
>> > +++ b/target-riscv.c
>> > @@ -19,6 +19,7 @@
>> >  #define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
>> >  #define RISCV_ZICSR	(1 << 10)
>> >  #define RISCV_ZIFENCEI	(1 << 11)
>> > +#define RISCV_ZICBOM	(1 << 12)
>> >
>> >  static unsigned int riscv_flags;
>> >
>> > @@ -41,6 +42,7 @@ static void parse_march_riscv(const char *arg)
>> >  		{ "c",		RISCV_COMP },
>> >  		{ "_zicsr",	RISCV_ZICSR },
>> >  		{ "_zifencei",	RISCV_ZIFENCEI },
>> > +		{ "_zicbom",	RISCV_ZICBOM },
>> >  	};
>> >  	int i;
>> >
>> > @@ -131,6 +133,8 @@ static void predefine_riscv(const struct target *self)
>> >  		predefine("__riscv_zicsr", 1, "1");
>> >  	if (riscv_flags & RISCV_ZIFENCEI)
>> >  		predefine("__riscv_zifencei", 1, "1");
>> > +	if (riscv_flags & RISCV_ZICBOM)
>> > +		predefine("__riscv_zicbom", 1, "1");
>> >
>> >  	if (cmodel)
>> >  		predefine_strong("__riscv_cmodel_%s", cmodel);
>> > --
>> > 2.34.1
>> >
>>
