From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Trying to understand linearized output
Date: Sun, 12 Mar 2017 18:00:33 +0000
Message-ID: <CACXZuxdevCRT1VNrPRC1VXSH5nHQj17F9aPpDHOQU++Uu_384A@mail.gmail.com>
References: <CACXZuxfTBH2hr8kOXepJ7VGCrfvjMU3h8GhDfZhtPEA6Ynw6jA@mail.gmail.com>
 <20170312171021.ivhh2fjyyj3xcgb5@macpro.local> <CACXZuxdX3ANytHJ+MPEm9gqcV0D8wJt7cWq4vSVkU7ffmDHFuw@mail.gmail.com>
 <20170312172050.24fwpfamwb3iivru@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36982 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934791AbdCLSBE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 14:01:04 -0400
Received: by mail-it0-f46.google.com with SMTP id g138so20712969itb.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 11:00:34 -0700 (PDT)
In-Reply-To: <20170312172050.24fwpfamwb3iivru@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 12 March 2017 at 17:20, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Mar 12, 2017 at 05:15:54PM +0000, Dibyendu Majumdar wrote:
>> On 12 March 2017 at 17:10, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> > On Sun, Mar 12, 2017 at 02:11:37PM +0000, Dibyendu Majumdar wrote:
>> >> ...
>> >>
>> >> My question is:
>> >>
>> >> phisrc.64   %phi98(current) <- %r333
>> >>
>> >> The phi98 above is presumably referencing a pseudo which has number
>> >> 98. But this is not part of this function, so I am confused. Does this
>> >> look right?
>> >
>> > I didn't checked all the details by it looks right.
>> >
>> > The %phi98 is not referencing a pseudo which has the number 98.
>> > It is a pseudo numbered 98 and which is of type PSEUDO_PHI.
>> > Those kind of pseudos are exclusively created by 'phisrc' instructions
>> > and used by 'phi' instructions.
>> > Here this %phi98 is used by the phi instructions at block .L127
>> >
>> > These 'phi' instructions are the core of the SSA representation of
>> > intermediate code. If needed Wikipedia gives a good introduction:
>> >          https://en.wikipedia.org/wiki/Static_single_assignment_form
>>
>>
>> Thanks. I am familiar with phi instructions in LLVM, but the phisrc
>> instructions in Sparse are new to me.
>
> Good. I wasn't sure.
>
> Those phisrc are unimportant, you can consider them as a kind of 'move'
> which is only but systematically used for each pseudo feeded to a phi
> instruction. They ahev no special semantic, they just make some things
> little bit easier for sparse.
>

I got confused by the numbering initially as I was expecting all
pseudos within a single function to be numbered sequentially.

So I should just read following :

phisrc.64   %phi98(current) <- %r333

As:

%phi98(current) = %r333

And 98 just happens to be the identifier for the pseudo, and 'phi' is
just to help the reader know that the value will go into a phi
instruction later. Is that correct?

Regards
Dibyendu
