From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 08:34:11 +0200
Message-ID: <CAExDi1T_G=R8-H7ZgQ6xnzr+-8nDVZtmjwObKdzocr=HEFp_Cw@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
 <20170910015622.42436-1-luc.vanoostenryck@gmail.com> <CANeU7Qn-8nLGr_JF61SGGPA=LDAs_h1C578B0RBb2u_KQn9UVA@mail.gmail.com>
 <CAExDi1SO=ztWy4hhW1FE5PzXh_DYb7RD17HqnzH8C0JP=5GUvw@mail.gmail.com> <CANeU7QkeWt7FcP1F3=bJx7tqo07+CkSOzucEcdLdxZ3bUOqMhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33660 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbdILGeN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 02:34:13 -0400
Received: by mail-lf0-f68.google.com with SMTP id y15so4902734lfd.0
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 23:34:13 -0700 (PDT)
In-Reply-To: <CANeU7QkeWt7FcP1F3=bJx7tqo07+CkSOzucEcdLdxZ3bUOqMhQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Tue, Sep 12, 2017 at 8:27 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Sep 12, 2017 at 2:12 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> Everything is temporary, isn't it? ;)
>>
>
> Of course :-)
>
>> In the other thread I explained the nature of the problem, it's *just* a
>> question to match the options for the model/sub-architecture between
>> LLVM compiler and the assembler.
>> Easy to do if you choose the dumbest (generic) model, pretty annoying
>> otherwise and a nightmare to test.
>
> Yes, I saw the other email you have it pretty much figure out
> already. I am tempting just pick up an used apple G5 and install
> Linux on it for ppc64 testing.

It's not the problem.
I tested it on a ppc64le (power8) machine while I investigated the
problem. So let's say that it's solved/tested for ppc64. Then what
about all the other models & archs?

-- Luc
