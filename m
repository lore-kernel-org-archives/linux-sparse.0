From: Christopher Li <sparse@chrisli.org>
Subject: Re: master branch for upcoming RC5
Date: Fri, 11 Aug 2017 11:20:05 -0400
Message-ID: <CANeU7QmtU5fa9PhT8K1FqZ4D9M8wL5m9tqZYyKQ8K0yrJJy7jw@mail.gmail.com>
References: <CANeU7QnAL0XxRHXifJunkPi1+My-vUJ84neaMPjPR+v7-UQmSQ@mail.gmail.com>
 <CACXZuxeQoL-zfoAqxwMLfRKCEt_TbZp-8gONQJgkWn98WF7=sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33799 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbdHKPUH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 11:20:07 -0400
Received: by mail-yw0-f175.google.com with SMTP id s143so24189025ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 08:20:06 -0700 (PDT)
In-Reply-To: <CACXZuxeQoL-zfoAqxwMLfRKCEt_TbZp-8gONQJgkWn98WF7=sA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 11, 2017 at 11:00 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Were these two issues caused by recent changes - or are they bugs in
> the released version of Sparse?

The bug is there in the v0.5.0 version of sparse but not trigger-able.
That is until Luc submit some patch kill dead bb and dead instructions
which make the bug trigger-able.

There is a revert on sparse-next to temporary stop the bug, by just
revert some change that Luc introduced. The change itself is fine and
remain on RC5, it just make the bug trigger-able as side effect. The
real fix is submitted by Luc later.

> I ran the test case kill-unreachable-phi.c in my repository and did
> not see an infinite loop. My repository is way behind the latest
> changes in Sparse as I last synced up earlier this year so maybe I am
> not seeing this issue?

Try that on RC4 and you will see the dead loop.

Chris
