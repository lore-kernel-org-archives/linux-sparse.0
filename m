Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD8C433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E28364DBD
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 20:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhA0Usa (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 27 Jan 2021 15:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhA0Us3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 27 Jan 2021 15:48:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB27C061573
        for <linux-sparse@vger.kernel.org>; Wed, 27 Jan 2021 12:47:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a14so4108796edu.7
        for <linux-sparse@vger.kernel.org>; Wed, 27 Jan 2021 12:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cvfC0nqCScYZIdoRTXGTiz6wjRjexPEvj8XNOmmEpLE=;
        b=DCJt/VWDmfJWRqXTV7gfoj0gxm6Br/wPGuCbX++b3m98a/NdEK4NAHNhmax7m3811N
         0WLkCy7UNNn1AI/ziovreg3s8ki0FgfZZmsBwgWoBui7qubHTBatyE8Io0mK4qf+xHaD
         ow3iQranqH7uOXj9BReQudcTqfp+mH+bvqe0egbON/xktcNlguYINKQs6pXjzthDhtna
         q+LEgbdxrXjFza/YJcezGuQqk4R6Lb3q1aRZYRybMxOPqserCvfN9A3bzRRm41KWS+99
         jUkbnZ3Etu07oap2tNJFYJSVehPTgiGCPPTWfuTxcmFP4rz3Is8meYXgiPORm4HnW9Ko
         f0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cvfC0nqCScYZIdoRTXGTiz6wjRjexPEvj8XNOmmEpLE=;
        b=G1k9THGwZRtghna+QalOOpYSXqRhlrYxcPZ+nEunR7WGPpZuHLWtqjYd+sVj1jQvfv
         32nZI3mY10AUx8a6Rmo8gOn462zw+22mSJNpizEwKIUH+lHYPGf8MmFEbG8Wo6Kh0ySq
         QdCTma+PyS3htWU1pWnCwx1xkjiGOxJsoWhg5YoXkwLUpEvDA1MhQT/QKlnh+v0BexT5
         RVXLkL35QcmSYao6jbZ4q7C5tY708FKoifXN9HLimUyME3dDuVT4Mll3ksXbmHYxChDn
         07ddO1pRDUsaj5LfhzrSbjasfet42S85G40roqfsOdz/o/HbvwTZNhYMAmgV8Slh3346
         pSeQ==
X-Gm-Message-State: AOAM531zikDNxdnAdAUBNfClLV25ZQ62lktTrA7jRU799ti68RwcjgPl
        nVmk7q97isGbMiul7MYuL74=
X-Google-Smtp-Source: ABdhPJyw4UbhHDcvxSjtn2x69aJXSjV3QDli3cD5nJ8GhH9w+8dQso0MzzhdtRUN747eS6ng5mjZdQ==
X-Received: by 2002:a05:6402:228a:: with SMTP id cw10mr10415931edb.195.1611780467532;
        Wed, 27 Jan 2021 12:47:47 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:f4c3:c11b:9b33:9031])
        by smtp.gmail.com with ESMTPSA id rh6sm87999ejb.45.2021.01.27.12.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 12:47:46 -0800 (PST)
Date:   Wed, 27 Jan 2021 21:47:45 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Kyle Russell <bkylerussell@gmail.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH] Makefile: add version.h dependency on all objects
Message-ID: <20210127204745.2k7a3x4djm6mwfwg@mail>
References: <20210127165856.2090337-1-bkylerussell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127165856.2090337-1-bkylerussell@gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Jan 27, 2021 at 11:58:56AM -0500, Kyle Russell wrote:
> This guarantees the generated version.h will exist before attempting
> to compile any c files that include it.
> 
> Several source files include the generated version.h, but not all
> declare a proper make dependency.
> 
> $ grep -r 'version\.h' *.c
> compile-i386.c:#include "version.h"
> lib.c:#include "version.h"
> options.c:#include "version.h"
> 
> This allows a sufficiently parallelized make invocation to encounter
> ENOENT.
> 
>   CC      compile-i386.o
> compile-i386.c:60:21: fatal error: version.h: No such file or directory
> compilation terminated.
> Makefile:253: recipe for target 'compile-i386.o' failed
> make: *** [compile-i386.o] Error 1


Mmmm, yes. I never see this because I always use a plain 'make -j'.
Thanks.

> @@ -249,7 +249,7 @@ libsparse.a: $(LIB_OBJS)
>  cflags   += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
> -%.o: %.c
> +%.o: %.c version.h

This is annoying because now all files need to be rebuild at every changes.
I've modified the patch so that single new file (version.c) includes and
depends on the generated file.

Best regards,
-- Luc
