From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] Give the constant pseudo value a size
Date: Mon, 14 Aug 2017 18:35:17 +0100
Message-ID: <CACXZuxeteW+qcbMzbV1zazPL-YKJmvpA46G4PQ4dJoG7DO1M+Q@mail.gmail.com>
References: <CANeU7Q=irkzkaKdaZT-0POrhj73ac3X8Bk-MW+jvFGtr1h5z0w@mail.gmail.com>
 <CACXZuxekYwfO5LRYDbCQoP9eqRvYJvnCSj8YQ=TAw6wt6Q1KsA@mail.gmail.com> <CANeU7Q=gK9fgX6RkHdOmnvSB8iEEsJzC-RCgXfu=Y6gED=pUxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34406 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdHNRfS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 13:35:18 -0400
Received: by mail-ua0-f170.google.com with SMTP id q25so39359078uah.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 10:35:18 -0700 (PDT)
In-Reply-To: <CANeU7Q=gK9fgX6RkHdOmnvSB8iEEsJzC-RCgXfu=Y6gED=pUxg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 14 August 2017 at 18:23, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 14, 2017 at 1:11 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> The push approach has the benefit that it makes clear what arguments
>> are being passed in a call. Previously this information was not
>> revealed in the Sparse linearized dump. It would be a shame to lose
>> that information - perhaps you could still dump the arguments along
>> with a call?
>
> Are you sure?
> Here is what I have for RC5:
> ./test-linearize cse.c
>
> .L414:
> load.64     %r1052 <- 0[insn]
> call.64     %r1053 <- try_to_cse, %arg1, %r1044(last), %r1052
> store.64    %r1053 -> 0[insn]
> phisrc.64   %phi474 <- %r1053
> br          .L413
>
> You can see exactly what is the calling arguments. There is an pseudo_list
> for the arguments.
>

Ah okay - I don't see that in dmrC output. It must have been removed
as part of the push change.

Regards
Dibyendu
