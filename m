From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 08:00:50 -0400
Message-ID: <CANeU7Qkzpdxc5vCdZT3Uc4Ajj1S7aL6sCR_21xBf1M1iDeSJHA@mail.gmail.com>
References: <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com>
 <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
 <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com> <20170811114937.fqzgxdqcq64jlpgn@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33806 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbdHKMAw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 08:00:52 -0400
Received: by mail-yw0-f169.google.com with SMTP id s143so20899087ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 05:00:51 -0700 (PDT)
In-Reply-To: <20170811114937.fqzgxdqcq64jlpgn@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Fri, Aug 11, 2017 at 7:49 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The first version of the patch gave:
>         arg     %r1, $1
>         arg     %r2, a
>         call    fun, %r1, %r2
>
> The current version gives:
>         push    $1
>         push    a
>         call    fun


I think he means the push instruction is not in the bb->insns list.

I agree with that view. The push instruction is very different than
any other instruction.  It contain mostly "repeated" information.
It is only needed when two things goes together:
1) the functions is varidic,
2) the OP_SETVAL is on the varidic part of the argument.

Which is rare, most of the function call are not varidic.

Another reason is that, it actually mess up with the parsing
state. If I am writing a script to parse the linearized output.
Notice that all other instruction don't have state itself.
The PUSH has state. It need to remember the ordered
position to the parser to figure out which PUSH apply
to which calling argument.

It also take up valuable screen space when I am staring
at the linearized byte code.

That is why I am actually what to explore Linus' alternative
suggest to push. Give OP_SETVAL a size.

Linus proposal two valid solution, add size to pseudo,
or the push. I haven't explore the first one yet.

Chris
