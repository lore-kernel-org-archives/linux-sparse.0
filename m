From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Fri, 30 Jun 2017 01:13:37 -0700
Message-ID: <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33306 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdF3INi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 30 Jun 2017 04:13:38 -0400
Received: by mail-io0-f196.google.com with SMTP id z62so2516077ioi.0
        for <linux-sparse@vger.kernel.org>; Fri, 30 Jun 2017 01:13:38 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jun 28, 2017 at 10:16 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> What can be win with these small changes is quite appreciable:
> about 30% with some gain in speed too (but this are harder to
> put numbers on it, 5% or a bit more seems quite common for
> big files).

I am curious about the performance difference against the full kernel
source check with sparse.
I have some benchmark script build for that with linux "allmodconfig".

My test environment will only do sparse portion of the checking and
save the result
into files. The makefile is non-recursive so it is much faster than
running sparse
from the kernel build. A kernel no change incremental build take about 2m10s.
On my non-recursive makefile for sparse it is only 4 seconds. So  the overhead
of make itself is very light.

Any way, the two run of normal build of RC3:
$ time make -f $PWD/linux-checker.make -j12 -C ../linux name=master
real 2m31.778s
user 18m18.019s
sys 8m19.468s

real 2m29.668s
user 18m12.991s
sys 8m12.728s

two run with LIST_NODE_NR = 13 version of sparse

real 2m27.166s
user 18m3.866s
sys 7m51.140s

real 2m28.089s
user 18m5.966s
sys 7m49.956s

So it is barely able to register a real world difference, consider the
run to run variance is about 2 second as well.

The number for the pure sparse run is about 1.3% difference on
the full kernel allmodconfig build.

Chris
