Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18234C433F5
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Mar 2022 22:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiC1WjY (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiC1WjY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Mar 2022 18:39:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B794925E
        for <linux-sparse@vger.kernel.org>; Mon, 28 Mar 2022 15:37:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u26so18608880eda.12
        for <linux-sparse@vger.kernel.org>; Mon, 28 Mar 2022 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koFN17ulxhdVtMhymKzO/TIc0UlPzvBHq58ZjJYY7jM=;
        b=AIfvTei1IeVbt+Bk9bsDu8i0OAjWtkFUIv7yu6nVy8c08SnnefFP7cH85NLEj/wNCw
         i2/jbg5t6KzHaYJu21vb1zZZOPfSMKIAjkR+wE9H95LVEpePX5UnIgZg54doj1ggCPBc
         +E5bTjIsBu2ynhVqQIXJaZyKH5zDOCTzn7NjYEQi1hJkAah/ZByHz5rUdih+9IMXoZKn
         kj1nSrlWjgLfiTlk1zuDCj6eG9iDc1KzyG+e9pGVIJXj8bktP0wojYEZJz2sgMCIF8R4
         iQhNT1pJbGBi/pDON8VfwJv3viJtAZLBCCh4o1dGEvU7Ij2Ep6L7qPMlleiNsd5gbyl1
         8vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koFN17ulxhdVtMhymKzO/TIc0UlPzvBHq58ZjJYY7jM=;
        b=3XhlmJ3gMiMXaxAarIn8tLCwO/V3tVMDUGmfMuBe3ejXR4/1yqp3J5se1OutLOVBvW
         0zJrnTm4OBOM650Ny/VyzqOks623/VknOnu7xyCcPdroVskPvG/4GYmq54IT/7FM9G+p
         Zg3+uRs0QykBQIsbtD/VzBA2drULT4Ns0/xehl99kXvYTTnGVfEFB41G73kf+G1NUjwa
         DPtnLN648oeyQHgi0fKVaO3ZMB8/+bBv6i6fq+GP22DHdz+VVa3XWerveMyzE95uYybx
         spfwwUqYUa6WkhwFBZyXuwR5GTfigxFxuu1w7DD2fpJy1oPFEW6OyKhF7PZjIq7UIe65
         8+gQ==
X-Gm-Message-State: AOAM5339Z/qFCBKdMJZuGeFqlG5pu/X4HM+I1Htls98yaDvwN+thwkch
        DGufe2tPkK1jD3X/njBqfWOSX6LoiYBJAl2DasA5XA==
X-Google-Smtp-Source: ABdhPJy4H1cvLXKft5SWJwyRx3X+cyr/G//Qw0QJiCqbwIOBZEWToj35RPb4cu1OUszYCjHF8kvRJgf830piojgobh0=
X-Received: by 2002:a50:c307:0:b0:418:ec3b:2242 with SMTP id
 a7-20020a50c307000000b00418ec3b2242mr147905edb.229.1648507059439; Mon, 28 Mar
 2022 15:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Mar 2022 17:37:28 -0500
Message-ID: <CAGS_qxpjj1W54BM7v2Cszne4nh5kUXZt89Dq-5nO3nD7RWhsRQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Add a section for static
 analysis tools
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     corbet@lwn.net, mchehab+huawei@kernel.org, davidgow@google.com,
        linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Mar 28, 2022 at 4:20 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>


> ---
> Hey everyone,
>
> I think this patch can be a good addition to the documentation as
> discussed in the thread for the testing guide documentation page:
> Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/
>
> If you think it would be worth it, I can try making something more

Nice!
This is definitely worth including, but I'm out of my depth here.
Some ideas below in case they're helpful.

Acked-by: Daniel Latypov <dlatypov@google.com>

> elaborated. Maybe provide some guidance on when to use each tool.
> I've been studying how Linux device drivers are tested.
> Here's a post I wrote talking about some testing tools.
> Link: https://marcelosc.gitlab.io/how-is-linux-tested/
>
> Best regards,
> Marcelo
>
>  Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b00511109a9d 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
>  Some of these tools integrate with KUnit or kselftest and will
>  automatically fail tests if an issue is detected.
>
> +Static Analysis Tools
> +======================
> +
> +In addition to testing a running kernel, one may also scout for bugs by
> +analyzing the source code semantics. Three tools are well known for serving this
> +purpose.
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +
> +Smatch extends Sparse and provides additional checks for programming logic

Coming from a place of ignorance, when should I use sparse vs smatch?
Is there an existing consensus on this, or is that a controversial question?

I assume other newcomers like me will have the same question and be
unsure if they should spend time learning about sparse.
In general, I think the main point of this page is to explain both
what the tools do and give an idea of _why_ someone might want to
consider using them.

> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +We also have Coccinelle as an option within static analyzers. Coccinelle is
> +often used to aid collateral evolution of source code, but it can also help to
> +avoid certain bugs that have been expressed semantically. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +These static analysis tools support running tests on the whole source tree or
> +over a specific file or directory.

Personal preference:
I'd personally put this up before we go into details about each tool.

E.g. perhaps like

In addition to testing a running kernel, one can also analyze kernel
source code directly (the whole tree or specific files) using **static
analysis** tools.
Some tools commonly used in the kernel are ...

> --
> 2.35.1
>
