Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FDDC433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF0364E74
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 19:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhB1Tfa (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhB1Tfa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 14:35:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476BDC06174A;
        Sun, 28 Feb 2021 11:34:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mm21so23962917ejb.12;
        Sun, 28 Feb 2021 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S5KfXXaQvt6j7WDZcPct+Ak/9/AyhidEr7ALQ5SkfaQ=;
        b=hDdtIyyX/3NqIWoSpmfpnm0A3ibi9UTwnDydNYf0r+wE8f5cESO5SdHdVIZ3gWAYQq
         bIAk2d4CUkqPsHAtb9c6mi22POyick7yfTMLyLd9mYAh1wko9B2F2i814+NGYchqxp3X
         wedSrWIA2bt2Emvpeu0kfsDSWBaQLuM/7DFCorLKqa2ymm9tVepMtTIAibWkL9ZmdcZQ
         t3hVboqF+q7y4b9K3FtS/gMwD53abboSbrplKY6TmnK8fU0stFLDqC6a5uExZSesm7Wj
         wzyixWT0kXZ+hArzyvQQ2u0zxGbwwOQw57u3HQYWPjXHWTXAdTJyj3Dmg4QSIb/03bHp
         EnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5KfXXaQvt6j7WDZcPct+Ak/9/AyhidEr7ALQ5SkfaQ=;
        b=Cvo95Qfb4k2s2ZWqJJhZKvzZLNm18bG5dArZjqhAq6L4u8aIjnZEQnY7gGWR7Xcho6
         BnQPJAqSqJUKWEHFXMTYt822fPWOUqX08yM6+6mKxg6cWVIoPj1HvWdy6DDJ1DLajZ+/
         A7x0kXhmUpm2rsfN+xs47UuHRo8E4NpDAiuo8ppHMtgUD3Ge8EkM0TYVJNDvcIEAZRGx
         yU6TpAgMNsTE/PdDC8m/SRE5ZTE0breYfvZnSUvFY5tu53jR4tZthKMfUkd1nJ+LBtq8
         SK5cKLQE04Jbswi/r8MkbjYzBLl/NmGcEfPlZBrs6PAXiV2ITbZCiYaBdUPeZBcWSul5
         dyVA==
X-Gm-Message-State: AOAM531RsmHSTGIxC3Hlz8PsNgH7MqqKxWjgmUJa07CitrKWsIgMyFYa
        qzI4q1M3Wdood+bp3lFZwA/4mxXSiliK
X-Google-Smtp-Source: ABdhPJzABw151d9xu1bnTlvPCib3PdR1IqvQlR23nPm8d5XXRcoPU8P8sWiKj9U+KhFKiXVAHJFtnQ==
X-Received: by 2002:a17:906:7d7:: with SMTP id m23mr12849912ejc.205.1614540888946;
        Sun, 28 Feb 2021 11:34:48 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id c17sm10445730edw.32.2021.02.28.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:34:48 -0800 (PST)
Date:   Sun, 28 Feb 2021 22:34:46 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
Message-ID: <YDvwVlG/fqVxVYlQ@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Feb 28, 2021 at 09:46:17AM -0800, Linus Torvalds wrote:
> On Sun, Feb 28, 2021 at 8:57 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > This is bulk deletion of preprocessor include guards and conversion
> > to #pragma once directive.
> 
> So as mentioned earlier, I'm not 100% convinced about the advantage of
> #pragma once.
> 
> But I decided to actually test it, and it turns out that it causes
> problems for at least sparse.

Oh no.

> Sparse *does* support pragma once, but it does it purely based on
> pathname equality.

Doing what gcc or clang does seems like a smart thing to do.

> So a simple test-program like this:
> 
>  File 'pragma.h':
> 
>     #pragma once
>     #include "header.h"
> 
> works fine. But this doesn't work at all:
> 
>     #pragma once
>     #include "./header.h"
> 
> because it causes the filename to be different every time, and you
> eventually end up with trying to open   "././....../pragma.h" and it
> causes ENAMETOOLONG.
> 
> So at least sparse isn't ready for this.
> 
> I guess sparse could always simplify the name, but that's non-trivial.
> 
> And honestly, using st_dev/st_ino is problematic too, since
> 
>  (a) they can easily be re-used for generated files
> 
>  (b) you'd have to actually open/fstat the filename to use it, which
> obviates one of the optimizations

fstat is more or less necessary anyway to allocate just enough memory
for 1 read. fstat is not a problem, read is (and subsequent parsing).

> Trying the same on gcc, you don't get that endless "add "./" behavior"
> that sparse did, but a quick test shows that it actually opens the
> file and reads it three times: once for "pramga.h", once for
> "./pragma.h" and a third time for "pragma.h". It only seems to
> _expand_ it once, though.
> 
> I have no idea what gcc does. Maybe it does some "different name, so
> let's open and read it, and then does st_dev/st_ino again". But if so,
> why the _third_ time? Is it some guard against "st_ino might have been
> re-used, so I'll open the original name and re-verify"?
> 
> End result: #pragma is fundamentally less reliable than the
> traditional #ifdef guard. The #ifdef guard works fine even if you
> re-read the file for whatever reason, while #pragma relies on some
> kind of magical behavior.
> 
> I'm adding Luc in case he has any ideas of what the magical behavior might be.

gcc does

	open "/" + "whatever between quotes"
	fstat

so that "1.h" and "./1.h" differ

	https://github.com/gcc-mirror/gcc/blob/master/libcpp/files.c#L377

clang does better:

	"./" + "whatever between quotes"
	open
	fstat
	normalise pathname via readlink /proc/*/fd

I think it is quite hard to break something with double inclusion
without trying to actually break stuff. Macros has to be token
for token identical or compiler warn. Types definition too.
Function prototypes and so on.

This is how I found half of the exception list.

The "no leading ./ in includes is trivially enforced with checkpatch.pl
or even grep! And it will optimise the build now that gcc behaviour has
been uncovered.

Include guards aren't without problems.

We have at least 1 identical include guard in the tree for two
completely unrelated headers (allmodconfig of some fringe arch found it)
Nobody complains because only defconfigs are run apparently.

Developer can typo it disabling double inclusion.

	#ifndef FOO_H
	#define FOO_h
	#endif

I've seen a reference to a static checker checking for such stuff
so this problem exists.

Invisibly broken inlcude guards (see qla2xxx patch in the series).
