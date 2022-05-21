Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7CC433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 13:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiEUNye (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiEUNyd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 09:54:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72C2C125
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 06:54:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f9so20348686ejc.0
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ae1dukdPieX0hd4XhhBQX+KcrIqrePVSZQ1+XjWq5Qs=;
        b=A/6tu/tOWmXCCTfzMKQp6TiNXuQzJ/nzJMmqiyUlzxsLwPWx50MMN9+7KgLSheTl9i
         41xbymQtr47N3RaG3zGYItrP+SKKS269D8eKoLY7uDsM/RdtzSLiHKNKkTpkjGJKn2Ch
         iTULvNwQrHnV0hqSJIQ16R68YGxhH3T60tw1TEWUcMFDZO7v6X86qFA0sib7PL3Fk7LL
         13qotyD4jBSTQUcNutpRw5r1OQVjTlW5j1lmKMut2n6V/dHDkoN2Qa8AummiF7a9XLOR
         1g7euxCqRdqhVqTEn8K5ImFLzHI/gb16zvRy4vj5mzBz+7aLnbNebxFmXZ7N6HydtOAr
         S3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ae1dukdPieX0hd4XhhBQX+KcrIqrePVSZQ1+XjWq5Qs=;
        b=SNRTYxP7XhtoMfRarriE/5JHj2g9W78xMksTEZSKD3zAGyEYnwkfeaP3BhbL2DgXdf
         +7WCXshFAxnbzc5Sd6/BE66S39FpNyiUAx3ka//jv47ZCZo0pmrJn1v/GKJG6hkEIjy6
         eCrNzp5ubh8I3FY91IWZBJfaC9n16YECuPAxpaqbZLqdE3c/Y/tu+6GhK4qUlZM28re3
         vHJkMI8DIeRllS1FjKGU2Utwx9Fj20PD1ohT5T2UOJbv6cm42TcpiuebOMsW84jL0Alh
         x+y22X/Up2i2xitfp4SB6eqxPnzr5Nbq3QvPFbD2TMlnUA+0/YVuDYoTapl5gdN0hVzr
         ooVw==
X-Gm-Message-State: AOAM532FGr03EA1XucDU/yaDSYFCbjlm2ExqLbLIn7O2W5lG8j56JRiA
        8UNzSi6BXbW6ipQwI8MdWRo=
X-Google-Smtp-Source: ABdhPJzexTLEQQ1qQBbebLEwzB479c7f+DhooYbVxCqiB20rpEj07paknO/08kdMQPpypTKhS57Ngw==
X-Received: by 2002:a17:907:7f8e:b0:6f4:2c01:5565 with SMTP id qk14-20020a1709077f8e00b006f42c015565mr13032036ejc.234.1653141271120;
        Sat, 21 May 2022 06:54:31 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id zl20-20020a170906991400b006feb479fcb4sm1508368ejb.44.2022.05.21.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:54:30 -0700 (PDT)
Date:   Sat, 21 May 2022 15:54:28 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: sparse v0.6.4
Message-ID: <20220521135428.g5l47v2lsltv7lod@mail>
References: <e9edc9f5-9b88-4a6a-17f8-544270ec2450@ramsayjones.plus.com>
 <33a053bc-1d81-49f4-0c8a-879a5519c433@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a053bc-1d81-49f4-0c8a-879a5519c433@infradead.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jan 14, 2022 at 08:25:31PM -0800, Randy Dunlap wrote:
> Hi Luc,

Hi Randy,

Apologies for this reply delayed for much too long.
 
> It seems that $subject version adds builtins for ATOMIC_ACQUIRE and
> ATOMIC_RELEASE, but GCC has those too, so there are a few thousand
> (OK, I didn't count them - I killed it quickly) of these: (e.g.)

Yes indeed, it was one of the things added in this release.
 
> ..  CHECK   ../init/do_mounts_initrd.c
> .command-line: note: in included file:
> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_ACQUIRE redefined
> builtin:0:0: sparse: this was the original definition
> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_SEQ_CST redefined
> builtin:0:0: sparse: this was the original definition
> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_ACQ_REL redefined
> builtin:0:0: sparse: this was the original definition
> builtin:1:9: sparse: warning: preprocessor token __ATOMIC_RELEASE redefined
> builtin:0:0: sparse: this was the original definition
> 
> Any suggestions for how to avoid these warnings?

Do you still see these? If yes, can you tell a bit about your setup and
the exact command line used?

I'm asking because I never saw a problem with this, same for the test bots.
It should be exactly the same as for any other predefined value.
However, as predefined, they should all be reported from 'builtin:0:0:'
and the 'builtin:1:9:' look as if those are from a '-include <somefile.h>'
on the command line.

Best regards,
-- Luc
