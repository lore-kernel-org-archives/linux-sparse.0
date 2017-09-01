From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse preprocessing bug with zero-arg variadic macros
Date: Thu, 31 Aug 2017 20:06:12 -0400
Message-ID: <CANeU7Q=CK7v0y3gmMzMOoduc2vV9bhPz_iCKQLFJXTPP54+t0g@mail.gmail.com>
References: <20170831133400.zjeaxhf25rbdftic@treble> <CA+55aFy8sXZKibU_RK-+hu_SD-QMaWxxsAQNYALkmvMiYfEo=Q@mail.gmail.com>
 <20170831205433.GQ5426@ZenIV.linux.org.uk> <20170831210922.GA9227@ZenIV.linux.org.uk>
 <20170831213444.6yeyfcrry6utaeih@cloud> <20170831214810.GS5426@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33588 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdIAAGN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 20:06:13 -0400
Received: by mail-yw0-f195.google.com with SMTP id w138so802356yww.0
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2017 17:06:13 -0700 (PDT)
In-Reply-To: <20170831214810.GS5426@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Aug 31, 2017 at 5:48 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> throw this in, perhaps?
>
> diff --git a/validation/preprocessor/preprocessor23.c b/validation/preprocessor/preprocessor23.c
> index 25be508..a778483 100644

This one does not have a signed off.
I will combine it with your previous patch.

I have test with your patch.
It fixes the simplified test example Linus give out.
I also do the stress test on allmodconfig kernel
source. There is no impact on sparse warning
given on kernel source. The stress test timing
is close enough.

I already apply the patch. I will push to master soon.

Thanks for the quick reply to fix this bug.

Chris
