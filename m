From: Christopher Li <sparse@chrisli.org>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 14:22:12 -0400
Message-ID: <CANeU7Qkn69crpxr2gR=jHsVPVyk=FfE-vkjGCkfM_yhNcsiAXA@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <20170820151513.ddoxdwo7iwd2nefh@ltop.local> <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
 <CA+55aFwzXM1e+7uDA_3fSWn1Jof3YFQ4y+r16MaRYF09KU5Xcg@mail.gmail.com>
 <CACXZuxcsTb9mzX-4P6QGCHxVY_=MjTwJexF8BnoFErotCTFjdg@mail.gmail.com> <CA+55aFx1QVQg4fsgXtduexbx4YdQe1QBPQiA6GK37CVi=3cBpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36396 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbdHTSWO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 14:22:14 -0400
Received: by mail-yw0-f173.google.com with SMTP id o192so1795282ywd.3
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 11:22:13 -0700 (PDT)
In-Reply-To: <CA+55aFx1QVQg4fsgXtduexbx4YdQe1QBPQiA6GK37CVi=3cBpw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 12:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I wouldn't guarantee it - I *think* it may be the case that even the
> initial linearization is actually proper SSA (just with everything
> going through memory), but I don't think it's necessarily a real

I think the initial linearize byte code, the internal usage of pseudo
is SSA and that is by choice.

> design choice. We do have a "non-SSA" mode that turns phi sources into
> OP_COPY that is very much not SSA.

"non-SSA" should happen in a much later stage, when we done with
all the optimization transformation that require SSA. We can remove
SSA. When emit to real machine code, the real machine code does
not have any thing similar to the phi function, which select register
base one where it come from. So the SSA form need to be undo, at
very late stage. SSA is just a tool to help optimizations, not the final
goal.

> So our linearization form does support a non-SSA mode, although
> honestly, I'm not sure how useful it is.

I don't think there is any real use for non-SSA mode in sparse right
now.

Chris
