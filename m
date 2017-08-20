From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 18:45:09 +0200
Message-ID: <CAExDi1T8n+qqjCjA=dHK3K68hvcYqXOTiiUWX+qHzNcVHDSEmQ@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <20170820151513.ddoxdwo7iwd2nefh@ltop.local> <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
 <CA+55aFwzXM1e+7uDA_3fSWn1Jof3YFQ4y+r16MaRYF09KU5Xcg@mail.gmail.com>
 <CACXZuxcsTb9mzX-4P6QGCHxVY_=MjTwJexF8BnoFErotCTFjdg@mail.gmail.com> <CA+55aFx1QVQg4fsgXtduexbx4YdQe1QBPQiA6GK37CVi=3cBpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35654 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdHTQpK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:45:10 -0400
Received: by mail-oi0-f42.google.com with SMTP id e124so135683776oig.2
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:45:10 -0700 (PDT)
In-Reply-To: <CA+55aFx1QVQg4fsgXtduexbx4YdQe1QBPQiA6GK37CVi=3cBpw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 6:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I wouldn't guarantee it - I *think* it may be the case that even the
> initial linearization is actually proper SSA (just with everything
> going through memory)

It's odd to me to talk about SSA when there is no phi-nodes
because all accesses are made via memory, but yes, I'm positively
sure that even before we call simplify_symbol_usage() (which
to me is where the real conversion to SSA is done) no pseudo
is defined at two different places. So yes, the SSA properties is
already true at the initial linearization.

> but I don't think it's necessarily a real
> design choice. We do have a "non-SSA" mode that turns phi sources into
> OP_COPY that is very much not SSA.
>
> So our linearization form does support a non-SSA mode, although
> honestly, I'm not sure how useful it is.
>
> Luc knows this code much better than me by now.

It's not really used. It was written to be used by a backend.
I wrote (a good part of) the backend's code selection (for ARM)
but never wrote the register allocator and glued things together.

-- Luc
