From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Add -gcc-version option
Date: Tue, 18 Jul 2017 19:35:14 -0400
Message-ID: <CANeU7Qn7Te3kxzcWAzC_4Hn2MLSsGFTdNX2AjJwmWdb6e2n+pA@mail.gmail.com>
References: <CAN_72e10vHGWwmovq_ra7FKE9EQgo-T+r8AavwFErkEV9Hnuww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34417 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbdGRXfP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 19:35:15 -0400
Received: by mail-pg0-f43.google.com with SMTP id 123so20688865pgj.1
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 16:35:14 -0700 (PDT)
In-Reply-To: <CAN_72e10vHGWwmovq_ra7FKE9EQgo-T+r8AavwFErkEV9Hnuww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <plroskin@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 18, 2017 at 5:59 PM, Pavel Roskin <plroskin@gmail.com> wrote:
> The option argument is parsed into major, minor and patchlevel versions,
> which are defined as __GNUC__, __GNUC_MINOR__, and __GNUC_PATCHLEVEL__ in
> the preprocessor.
>
> One possible use is running sparse compiled with the lastest gcc compiler
> on a Linux kernel that doesn't support that compiler.

I am curious, can you just invoke sparse with -D__GNUC__=1 -D__GNUC_MINOR__=2
to do the same thing?

The current __GNUC__ was a weak define it is suitable for overriding
if you wants to.

Chris
