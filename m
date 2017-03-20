From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Possible linearizer issue
Date: Mon, 20 Mar 2017 23:43:33 +0000
Message-ID: <CACXZuxdw6ifjMUWv4TDh+0KCTvaG-AK14=78mdPcPN7eqk4MHg@mail.gmail.com>
References: <CACXZuxeuav4vrT=xKxLcV7RpUET8NM7VLuviTNr4N_XfGQxmHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35483 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755849AbdCTXnf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 19:43:35 -0400
Received: by mail-io0-f181.google.com with SMTP id z13so39697171iof.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 16:43:34 -0700 (PDT)
In-Reply-To: <CACXZuxeuav4vrT=xKxLcV7RpUET8NM7VLuviTNr4N_XfGQxmHQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 18 March 2017 at 11:41, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I am investigating a failure in one of the tests. The generated
> linearized code has instructions such as:
>
> .L363:
>  br          VOID, .L366, .L439
> .L366:
>  load.32     %r413 <- 44[%arg1]
>  br          %r413, .L368, .L369
> .L368:
>  load.64     %r415 <- 0[s7813er]
>  call.32     %r416 <- printf, %r415, $2
>  br          .L369
> .L369:
>  phisrc.32   %phi97(rc) <- $2
>  br          .L439
> .L439:
>  phi.32      %r557 <- %phi95(rc), VOID, %phi97(rc), VOID, VOID, VOID
>
> The test program is here:
>
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/set1/cq2.c
>

It seems that the issue is occurring in simplify_flow(). If I disable
the call to this, then the program compiles successfully and also
runs. None of my other tests fail with this step disabled.

Any clues what might be going wrong?

Does disabling simplify_flow() have any other effect except for missed
optimizations?

Thanks and Regards
Dibyendu
