From: Pavel Roskin <plroskin@gmail.com>
Subject: Re: [PATCH] Add -gcc-version option
Date: Tue, 18 Jul 2017 16:46:47 -0700
Message-ID: <CAN_72e2SE4pcUNNUSOJVRW31YdXmm-tR0ybOjpT7QDV2fmne4g@mail.gmail.com>
References: <CAN_72e10vHGWwmovq_ra7FKE9EQgo-T+r8AavwFErkEV9Hnuww@mail.gmail.com>
 <CANeU7Qn7Te3kxzcWAzC_4Hn2MLSsGFTdNX2AjJwmWdb6e2n+pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36430 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbdGRXqt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 19:46:49 -0400
Received: by mail-oi0-f45.google.com with SMTP id x187so30453149oig.3
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 16:46:48 -0700 (PDT)
In-Reply-To: <CANeU7Qn7Te3kxzcWAzC_4Hn2MLSsGFTdNX2AjJwmWdb6e2n+pA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 18, 2017 at 4:35 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Jul 18, 2017 at 5:59 PM, Pavel Roskin <plroskin@gmail.com> wrote:
>> The option argument is parsed into major, minor and patchlevel versions,
>> which are defined as __GNUC__, __GNUC_MINOR__, and __GNUC_PATCHLEVEL__ in
>> the preprocessor.
>>
>> One possible use is running sparse compiled with the lastest gcc compiler
>> on a Linux kernel that doesn't support that compiler.
>
> I am curious, can you just invoke sparse with -D__GNUC__=1 -D__GNUC_MINOR__=2
> to do the same thing?
>
> The current __GNUC__ was a weak define it is suitable for overriding
> if you wants to.

Yes, that works! I wish I thought of it earlier and did not waste time
writing that patch.

That option may still be useful if sparse attempts to imitate the
behavior of specific gcc versions (in addition to the defines).

-- 
Regards,
Pavel Roskin
