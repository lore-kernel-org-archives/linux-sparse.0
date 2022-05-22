Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9EC433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 22 May 2022 09:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiEVJiJ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 May 2022 05:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiEVJiI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 May 2022 05:38:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAC43B3CE
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 02:38:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i40so15666360eda.7
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YvoekQFmcXRp2Ey/8juh5JDpufn7lNAy/vcOs6/zL8k=;
        b=R0U3eTPFgRuoIrSQ7kDFHWUQq6P9OFUON1sAkNeHLNdnDV1/BlFAhfuZw2VsNtWtgV
         vEmUch5BDlym2f/vza92Ax17Ov0UCvhXsbLxltQYNQOs9eP/NTSq1kyBYeAN2u8tDRbc
         ENRAZjQdb6tnU3JT+OLAuy4aaRBaFm1LmJ8u83n5nlUFjp9+df1m1VRCqavnD7s0zi+B
         9slR9Bh4OSjOcN5062ZWb6YW/4HM+9AFeIbLb/ed1OE6hd8r0bWxawXFIeYsQFzGRRTm
         vna/dv8d91IsnG5fsPm5TvsKKIYxuEuR/I557KQoCRqfubzHAb44ZuD2nesMwLoG3CC4
         na+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YvoekQFmcXRp2Ey/8juh5JDpufn7lNAy/vcOs6/zL8k=;
        b=KbcUDSPiTro/fUZNsE/IsBqdZlJHm9KQMjzKYTHxFbtfzBN3/7MqwN9s7VOH4blX7g
         eFJ0RJlWwMeM3IQ51yfk/Fow97WIJTruUZBEfz/k+Jr4tW/d0BSPsV8dojwDLG9TloMS
         NcyO1xwu9WgYFDoB8yxnb9/M7DIXKIJQVM9Xey/LvnSCU5AHMdsdvvo83UkYyo+isJab
         qO8bs5LLZWS2zS6R9M+9UwsrH0tlZb280txmjxvl6D5ZPcC3JcueN8xc+zoUaJ/d/XjG
         ul02yGVUTYWaCvw6NLx6PjVwa3BEBZyvZwQ/oWH9pNcQdYKj8PgLq/f6+xFrobndLtnr
         W9tA==
X-Gm-Message-State: AOAM530S/rLacVu0vt0C9+oAeANvwAodG12q7gh/Ewhyez1xcJnXNd1F
        qvLx1dvCgffkUDweSU1tBEg=
X-Google-Smtp-Source: ABdhPJyUHPh9wjuiUp5q/lfb71MErcxnPIidh+VZqq90xo91JGE9fMvFJ3IfIM6Yd02tO2HHkCVznw==
X-Received: by 2002:aa7:d8c2:0:b0:42a:b9fa:bad8 with SMTP id k2-20020aa7d8c2000000b0042ab9fabad8mr19321882eds.304.1653212285085;
        Sun, 22 May 2022 02:38:05 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709070b1200b006fa84a0af2asm5074867ejl.16.2022.05.22.02.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 02:38:04 -0700 (PDT)
Date:   Sun, 22 May 2022 11:38:03 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Tom Rix <trix@redhat.com>
Cc:     linux-sparse@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] cgcc: handle -x assembler
Message-ID: <20220522093803.i4z3hpcuhkz3ohj7@mail>
References: <20220410140026.1830513-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410140026.1830513-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

Sorry for this late reply.
 
On Sun, Apr 10, 2022 at 10:00:26AM -0400, Tom Rix wrote:
> On linux-next, using
> make CC=cgcc
> 
> fails with
> cgcc: unknown assembler invoked
> scripts/Kconfig.include:50: Sorry, this assembler is not supported.
> 
> cgcc is being invoked with
> cgcc -Wa,--version -c -x assembler /dev/null -o /dev/null
> And dieing when the '-x c' is not matched.
>
> Add a check for -x assember.


As you most probably know, cgcc is a wrapper around GCC to transparently
also call sparse on the source code.
This was designed when using sparse on non-kernel code. The kernel doesn't
need it since its build system can do the same directly using the commands:
	make C=1 <...>
or
	make C=2 <...>
insuring it's called with the correct arguments (like the --arch option)
and taking in account a few idiosyncrasies.

Your patch is OK regarding cgcc itself but I don't know what good it will
do after, when calling sparse, since sparse can only process C code an will
surely choke on assembly files.

So, are you sure you must cgcc here and can't use the existing make C=[12]
mechanism? Otherwise, a more correct patch would be to change the check
for '-x c', set $do_check = 0 when the argument is 'assembler' (or
better, when anything other than 'c') and preferably stop to parse the
remaining arguments/directly call the $REAL_CC.

Best regards,
-- Luc
