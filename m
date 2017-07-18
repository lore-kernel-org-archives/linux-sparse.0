From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Tue, 18 Jul 2017 11:11:50 -0400
Message-ID: <CANeU7QkZmX9YKaT5xs_mdSo0ggvGjefzvfjSrEPZbfKaGzTF1g@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36609 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdGRPLv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 11:11:51 -0400
Received: by mail-pg0-f46.google.com with SMTP id u5so14278693pgq.3
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 08:11:51 -0700 (PDT)
In-Reply-To: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@mykolab.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Jul 18, 2017 at 10:47 AM, Michael Stefaniuc
<mstefani@mykolab.com> wrote:
> But I seem to get an infinite loop with a mem leak: 100% CPU with the
> memory utilization increasing until this line triggers
> sparse/allocate.c:105:                 die("out of memory");

Thank you for the report. I will take a look at it.
> To reproduce:
> git clone git://source.winehq.org/git/wine.git
> cd wine
> ./configure --enable-win64
> make -j`getconf _NPROCESSORS_ONLN` CC=cgcc

I will try to reproduce it.

>
>
> Though I'm not sure that this qualifies as a blocker for the 0.5.1
> release. The Wine code was pretty tough on sparse previously; it has
> been years since I last tried. Crashes and mis-parses were normal back
> then as Wine uses language features that are still unimplemented (wide
> character string literals). But I do not remember to have encountered an
> infinite loop with a mem leak.

That sounds like a blocker to me. Hopefully it is not too hard to fix.

Chris
