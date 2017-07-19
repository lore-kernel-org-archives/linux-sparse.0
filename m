From: Pavel Roskin <plroskin@gmail.com>
Subject: Re: [PATCH] Add -gcc-version option
Date: Wed, 19 Jul 2017 10:27:07 -0700
Message-ID: <CAN_72e0f6Zg3YeDrMmb5OOHHr4qj14Wc_WeomeZirjXx0zOU=w@mail.gmail.com>
References: <CAN_72e10vHGWwmovq_ra7FKE9EQgo-T+r8AavwFErkEV9Hnuww@mail.gmail.com>
 <CANeU7Qn7Te3kxzcWAzC_4Hn2MLSsGFTdNX2AjJwmWdb6e2n+pA@mail.gmail.com>
 <CAN_72e2SE4pcUNNUSOJVRW31YdXmm-tR0ybOjpT7QDV2fmne4g@mail.gmail.com> <CANeU7Q=HYVQY3HkSqKPekxSMhzFsxpV2UV905h3Qyf2sNGF1ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36317 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbdGSR1I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 13:27:08 -0400
Received: by mail-oi0-f42.google.com with SMTP id x187so6693062oig.3
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 10:27:08 -0700 (PDT)
In-Reply-To: <CANeU7Q=HYVQY3HkSqKPekxSMhzFsxpV2UV905h3Qyf2sNGF1ug@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 6:07 AM, Christopher Li <sparse@chrisli.org> wrote:

> When you specify the gcc version, there is also implicit version
> specific behavior
> go with it. I can see user file bugs said I give sparse gcc version X,
> but gcc has
> macro Y in X. That is not the case with sparse, that is a bug. I don't
> want to give
> the user false impression that sparse can set a gcc version and simulate the gcc
> version specific behavior.

Makes sense.

> It is simpler just put the version specific macro into a header file and ask
> sparse to include it. You should be able to add that to command line as well.
>
> Chris

I did not realize that sparse supports -include. It turns out it does,
which is even better than specifying three defines.

I don't see any references to -D or -include in the sparse manual
page. I think they should be documented.

-- 
Regards,
Pavel Roskin
