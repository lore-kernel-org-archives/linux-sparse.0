From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 10:25:08 -0700
Message-ID: <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38911 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbdCPRZK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 13:25:10 -0400
Received: by mail-it0-f50.google.com with SMTP id m27so52673495iti.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 10:25:09 -0700 (PDT)
In-Reply-To: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Sorry for not reacting to this earlier..

On Sat, Mar 11, 2017 at 7:47 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This is a RFC for giving a type to constants/PSEUDO_VALs.

This seems completely broken. Not from an implementation standpoint,
but from a conceptual one.

To explain, let me give a completely idiotic example:

    unsigned int test(int arg)
    {
        return arg + (unsigned int)arg;
    }

note how we're adding a "int" and an "unsigned int" together. But the
CSE etc doesn't actually care at all, and we will linearize this to
just

    test:
        add.32      %r5 <- %arg1, %arg1
        ret.32      %r5

because the type just isn't relevant at the linearization phase.

You can tell that there *used* to be multiple pseudos from the
numbering ("%r5"? What happened to "%r1..4"?), but they have all been
smushed together.

Linearization has fundamentally gotten rid of all the C types, and all
you can find are some rough remnants of them (you can find the *size*
of the type, and you can find the rough "type" of type - is it a
pointer, FP value or integer. There aren't even any signs, although
some _operations_ are signed (but not the pseudos).

The same pseudo can have many different types.

                    Linus
