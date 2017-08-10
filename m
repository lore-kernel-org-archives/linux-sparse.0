From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 10 Aug 2017 11:25:41 -0400
Message-ID: <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com> <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35840 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbdHJPZn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 11:25:43 -0400
Received: by mail-yw0-f194.google.com with SMTP id n83so633754ywn.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 08:25:42 -0700 (PDT)
In-Reply-To: <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 4:43 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 16, 2017 at 1:19 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> The issue is not with the type of %r6 but %arg3 and %arg4 if these
>> happen to be integer constants, and the function is variadic so we
>> cannot work out the type from the function prototype.
>
> Yes. Ok, I see the problem.
>
> I think we could add a 'size' to the pseudo, and solve it that way.
> CSE and other linearization artifacts may mean that the type is
> undefined, but the size should be well-defined.

Sorry for not able to join the discussion earlier. I am catching up
my backlogs of discussion. I have think about this for a while now.
I think there is one alternative solution is just give set_val instruction
a size (not type).

reason being:
1) Necessary for CSE as well.
   If CSE combine two set_val of different size as one pesudo.
   and it is used as two different size. That is likely a bug.
   That is independent of having OP_PUSH or not.

2) Sufficient.
   If we have the size of set_val, we can solve the problem of
   calling function with instant constants and the function is variadic.

That is likely the minimal required change to get both issue
resolved.

Thanks

Chris
