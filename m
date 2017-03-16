From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 18:24:05 +0000
Message-ID: <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com> <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38752 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbdCPSYW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 14:24:22 -0400
Received: by mail-it0-f42.google.com with SMTP id m27so55081792iti.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 11:24:17 -0700 (PDT)
In-Reply-To: <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Hi Linus,

On 16 March 2017 at 18:14, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, Mar 16, 2017 at 11:04 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I think that having the size and information whether an integer
>> constant is an integer or pointer should be good enough
>
> The thing is, I don't think you should should actually look at the
> pseudo for that AT ALL.
>
> The size is encoded in the operation itself, and that's what you should use.
>

Agreed and we are doing that except that the function call instruction
only has the type of the call, not the arguments (as far as I
understand - apologies if I have got this wrong). The original issue
arose out of that - i.e. the code was using the type of the call
instruction to decide the type of the argument. To solve this we are
now using the function prototype to work out the types of arguments -
this works okay except for the variadic case.

> Now, the "integer vs pointer" thing is perhaps more interesting. We do
> *not* encode that, and we use the same "add" operation for both
> integers and pointer values. That's because basically linearization
> treats pointers as integers too, although we do actually keep the
> pseudos separate because we consider casts to/from pointers to be
> special (so they aren't _purely_ just integers).
>
> So the instruction itself has
>
>  - size
>
>  - sign
>
>  - _much_ of optype
>
> and I think that the proper long-term fix is perhaps to try to make
> that "much" into "all". And part of that may actually be about getting
> rid of some of the type differences entirely (ie turn pointers truly
> into just pointer-sized integers, the way they almost are already).
>
> That does mean that the llvm interface would need to use even more
> explicit casts to make llvm happy.
>

I think that is fine. I have ended up always casting values to their
expected types in sparse-llvm on the basis that a) the linearized
output has already worked out that it is legal, and b) the casts are
just to keep LLVM happy.

Thanks and Regards
Dibyendu
