From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sparse preprocessing bug with zero-arg variadic macros
Date: Thu, 31 Aug 2017 10:19:32 -0700
Message-ID: <CA+55aFy8sXZKibU_RK-+hu_SD-QMaWxxsAQNYALkmvMiYfEo=Q@mail.gmail.com>
References: <20170831133400.zjeaxhf25rbdftic@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34787 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdHaRTd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 13:19:33 -0400
Received: by mail-io0-f177.google.com with SMTP id n71so2567738iod.1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2017 10:19:33 -0700 (PDT)
In-Reply-To: <20170831133400.zjeaxhf25rbdftic@treble>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Aug 31, 2017 at 6:34 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> I think I'm seeing a bug in the sparse preprocessor.  I've reduced it to
> the following test case.

I think the real reduced test-case is just this:

    #define ARGS_APPEND(...) ,## __VA_ARGS__
    ARGS_APPEND()

and you can run if through "sparse -E" to see the comma (while gcc -E
does not have it).

I'm adding Al to the cc list because he's the pre-processor person.
Hopefully he has gotten out from under most of his emails from his
move.

sparse gets it right if there is any non-VA_ARGS argument to the
symbol, but not if __VA_ARGS__ is all of the argument to the macro.

Al?

                 Linus
