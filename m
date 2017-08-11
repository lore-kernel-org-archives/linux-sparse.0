From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 07:51:09 -0400
Message-ID: <CANeU7QnymR-7QBtYUUTj8ZSgEktH0RATM3i6X3g7zZKqJWNmzA@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com> <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33132 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdHKLvL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 07:51:11 -0400
Received: by mail-yw0-f195.google.com with SMTP id u207so2066191ywc.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 04:51:11 -0700 (PDT)
In-Reply-To: <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Aug 10, 2017 at 6:34 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 10, 2017 at 5:25 PM, Christopher Li <sparse@chrisli.org> wrote:
>> On Thu, Mar 16, 2017 at 4:43 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> Sorry for not able to join the discussion earlier. I am catching up
>> my backlogs of discussion. I have think about this for a while now.
>> I think there is one alternative solution is just give set_val instruction
>> a size (not type).
>>
>> reason being:
>> 1) Necessary for CSE as well.
>>    If CSE combine two set_val of different size as one pesudo.
>>    and it is used as two different size. That is likely a bug.
>
> Absolutely not.
> Anyway, currectlyeach distinct value correspond to a *single/unique*
> pseudo. IN other words, there is no need to do any kind of CSE on
> *values*, they are already kinda pre-CSEed at their creation
> (because a constant value is nothing more than this value).
>
> Sorry, this has been tried and discussed already. It doesn't really work.
> * a size is essentially a type, certainly for integers in sparse IR.
> * A constant is a constant, 1 is 1, when it has 1 bit or 64 bits, it's the same
>   constant and follow the same mathematical rules. It's even not signed or
>   unsigned, it's just 1.
> * in sparse, types are conveyed by the *operations* made on their operands.
>   There are lots of good reasons for this. Trying to do the opposite for these
>   constants will just break a lot of things, duplicate a lot of code
> (try it) and

OK. I have think about it. I look back the email. It is actually on the
email I reply to (and quoted) . So Linus was thinking two solutions.
One of them is add size to pseudo. The other is add push instruction.
He said that after he said pseudo shouldn't have the size,
which is what you are repeating here. So the reason you use are
actually older one, which already overrule by Linus. He thinks have
size for pseudo is acceptable.

He said the type might be undefined, the size is well-defined.
I totally agree.

What I am popularizing is actually along the line of Linus' first
suggestion. Except that I don't give size to *all* the pseudo,
only the OP_SETVAL, via the instruction to acquire the size.

I have to look at what impact it has on CSE. It might not  be that
big a deal.

Chris

======quote from Linus email May 16 on this thread ========
Yes. Ok, I see the problem.

I think we could add a 'size' to the pseudo, and solve it that way.
CSE and other linearization artifacts may mean that the type is
undefined, but the size should be well-defined.

Alternatively - and this might be the better solution - the OP_CALL
instruction might be better off split up a bit. Instead of having just
that
==================================================
