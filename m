From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 13:43:05 -0700
Message-ID: <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com> <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38279 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdCPUnn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 16:43:43 -0400
Received: by mail-it0-f43.google.com with SMTP id m27so2752420iti.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 13:43:06 -0700 (PDT)
In-Reply-To: <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 1:19 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> The issue is not with the type of %r6 but %arg3 and %arg4 if these
> happen to be integer constants, and the function is variadic so we
> cannot work out the type from the function prototype.

Yes. Ok, I see the problem.

I think we could add a 'size' to the pseudo, and solve it that way.
CSE and other linearization artifacts may mean that the type is
undefined, but the size should be well-defined.

Alternatively - and this might be the better solution - the OP_CALL
instruction might be better off split up a bit. Instead of having just
that

    struct pseudo_list *arguments;

that lists the arguments, maybe it should have a

    struct instruction_list *arguments;

with a new OP_ARG instruction to generate the argument.

That way all the arguments would have a size, and always a generating
instruction.

              Linus
