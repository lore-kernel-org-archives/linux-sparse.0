From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: master branch for upcoming RC5
Date: Fri, 11 Aug 2017 16:00:33 +0100
Message-ID: <CACXZuxeQoL-zfoAqxwMLfRKCEt_TbZp-8gONQJgkWn98WF7=sA@mail.gmail.com>
References: <CANeU7QnAL0XxRHXifJunkPi1+My-vUJ84neaMPjPR+v7-UQmSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:37265 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbdHKPAf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 11:00:35 -0400
Received: by mail-ua0-f170.google.com with SMTP id f9so16021657uaf.4
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 08:00:34 -0700 (PDT)
In-Reply-To: <CANeU7QnAL0XxRHXifJunkPi1+My-vUJ84neaMPjPR+v7-UQmSQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 11 August 2017 at 14:49, Christopher Li <sparse@chrisli.org> wrote:
> - the wine bug is nail down for good. Thanks Luc for the hard
>    work there.
> - The ptrlist delete while looping is checked and the offender
>    has been change to mark delete rather than actual delete.

Were these two issues caused by recent changes - or are they bugs in
the released version of Sparse?
I ran the test case kill-unreachable-phi.c in my repository and did
not see an infinite loop. My repository is way behind the latest
changes in Sparse as I last synced up earlier this year so maybe I am
not seeing this issue?

Regards
Dibyendu
