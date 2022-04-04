Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ADFC433FE
	for <linux-sparse@archiver.kernel.org>; Mon,  4 Apr 2022 23:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiDDXTl (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbiDDXT2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Apr 2022 19:19:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE20BEC
        for <linux-sparse@vger.kernel.org>; Mon,  4 Apr 2022 16:15:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j8so9378089pll.11
        for <linux-sparse@vger.kernel.org>; Mon, 04 Apr 2022 16:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=luhYvUXvfK4DVP9pJM1NWeOVtGr2WEnbABS6soGUyts=;
        b=uq7WkCw7lByrl3BHE7CqKiXTN2TC5y0FcPXkQX0UEt7H2VGFFb4sMSvQ5uDampYx1s
         JUOWFbAFNvqWCbctn0+w+Y/idMAgWTyEjbN1SQfpDw6AcrPQdUsDJ5jWYoakVAeip/qo
         Yz1TUE9hbmBbSxSNTyAVB+BlT/TSmVdbAehdUoLQj+dDthMXmq1dbnQp41pxerPp7z+8
         K1m2L5LlGe2zo4C2ZiYUEK5L8sBosz/zprWUdUPGJ7x/m7NBa6KbqB2c672MBJ2ScaXc
         HpOIcCy4pSGmSB6uWPnfo0Jd+s9FHNW2NincqxEWcRbrjPzBeIw5lro7eT8l67dzec6Q
         0NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=luhYvUXvfK4DVP9pJM1NWeOVtGr2WEnbABS6soGUyts=;
        b=w6BfcAce415kBfcH1hKXgDSM2hDk5bY+DEeTA5rrYgDPRoY/11GnLZH0O8M+KGKowF
         korPjnePuxDJcOAJGPqYfwnM+7TNV+6wh/3evNzvr4CC8VB7/8XPXHq6vpfk7HV7dpd9
         OcNg818pEBFYGyim6TkmiKeT6PWdmBL8jGgUu6ZEefIAPtegDI67xa+9nsaAMZGCSY8x
         fUldDjj+1ONkfwghKgESTyRFo2YO+L68hPGYOxiZ1FsosUteS0Ia8m+SqdyLFiuVduxD
         w1XxIfYwBwVc1ADEMiySrnAs6YsouMnhig/d5OnEmFL0PbB27Os1joylaKmgdkX/t/07
         H1rQ==
X-Gm-Message-State: AOAM5318oerFr57c7SFW2OKUgFzji83aWsXEURqkQTSIW25eLipvo0YK
        LX88BVU+wpYWozkyHKi8jYMaGhw5UMoh3g==
X-Google-Smtp-Source: ABdhPJyZ5OoWF4brs8INv2aulrP6DsuD6ciJBAzGCUd61YVylyDM6pcHe6wq7eyGnz0uY0XK20ssBg==
X-Received: by 2002:a17:90a:2f8e:b0:1ca:aefb:c796 with SMTP id t14-20020a17090a2f8e00b001caaefbc796mr751996pjd.66.1649114154995;
        Mon, 04 Apr 2022 16:15:54 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id s24-20020a63af58000000b003981789eadfsm11163921pgo.21.2022.04.04.16.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 16:15:54 -0700 (PDT)
Date:   Mon, 04 Apr 2022 16:15:54 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Apr 2022 16:14:44 PDT (-0700)
Subject:     Re: [PATCH v1 0/6] RISC-V -march handling improvements
In-Reply-To: <20220404175253.dgwhy5ibodrn2lyz@pengutronix.de>
CC:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     mkl@pengutronix.de
Message-ID: <mhng-dbb227f8-f3b4-4528-b9c1-a23cbf7bcfd5@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, 04 Apr 2022 10:52:53 PDT (-0700), mkl@pengutronix.de wrote:
> On 01.04.2022 22:00:35, Palmer Dabbelt wrote:
>> As pointed out recently [1], sparse is parsing -march on RISC-V in order
>> to obtain the default set of preprocessor macros to use.  Back when this
>> was written ISA string was a simple affair, but these days it's a lot
>> more complicated.  It's going to be a big chunk of work to get a proper
>> ISA string parser into sparse, but we can at least fix the breakages for
>> the subset of legal ISA strings that Linux currently uses (and are
>> breaking users).
>> 
>> This patch set does three things:
>> 
>> * Stops die()ing on unknown ISA strings, unless the user has passed
>>   -Wsparse-error.  This prints a warning and guesses at the macros to
>>   use, which is probably fine for Linux.
>> * Cleans up some of the differences between GCC's -march parsing and
>>   sparse's.  None of this should really matter for Linux, as GCC will
>>   blow up on bad ISA strings, but it just seemed worth doing when I was
>>   in there.
>> * Adds support for the Zicsr and Zifencei extensions, which were
>>   recently enabled.  With these the unknown ISA string warning goes away
>>   for Linux builds.
>> 
>> They're all sort of independent (and happen in this order), but they're
>> all touching the same code so I'm just sending it as a series.  It's my
>> first time touching sparse.
>> 
>> I've poked around with the first patch on its own and it seems to
>> largely work as expected: I'm still getting a bunch of sparse-related
>> warnings when I turn on sparse in my builds, but at least I don't get an
>> error (after updating to a binutils that supports the new arguments, so
>> Linux detects them).  I tried CF="-Wsparse-error", which also behaves as
>> expected (that trinary boolean tripped me up for a bit).
>> 
>> The first patch alone should be a sufficient band-aid for systems that
>> are actively broken right now, the rest are cleanups -- these may be
>> necessary to get the RISC-V port sparse-clean, but that's a WIP so there
>> might be more.  I'm going to play around with that, but just looking at
>> the volume of spew it's probably going to take a while.  I gave these
>> patches a bit of testing one-by-one, but not nearly as much as the
>> first.
>> 
>> I just spun up a sparse repo [2] at kernel.org, these are on the riscv
>> branch if that helps for anyone.  I've also started messing around with
>> parsing a few more of the multi-letter extensions, but there's so much
>> coupling I got fed up -- it's on riscv-wip, but I definitely don't like
>> that last patch.  I figured it's better to send out these bits, as they
>> look solid to me and builds are broken.  The new stuff (B, K, and V) are
>> all in GCC-12 anyway, so we have a bit of time before they're useful.
>> 
>> [1]: https://lore.kernel.org/linux-sparse/mhng-c280d48c-477d-4589-baee-255c774b5a51@palmer-mbp2014/T/#maef705f448e4a1f12d853c0d8bc756f037ce1ce0
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/palmer/sparse.git
>
> Works without warnings on Debian testing, with gcc-riscv64-linux-gnu
> 4:11.2.0--1.
>
> Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks.  IIRC you were actually getting the failures from the other 
thread, so I think this is OK, but jus for everyone else:

Unfortunately there's a few more variables than just the GCC version, 
this depends on the binutils version (and IIUC the binutils version GCC 
was compiled with) and how Linux was configured.  I was testing with a 
V=1 build to make sure "-march=rv64imafdc_zicsr_zifence" showed up, it 
should be the same for all files so I was just poking one.

>
> regards,
> Marc
>
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
