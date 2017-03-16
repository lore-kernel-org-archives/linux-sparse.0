From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 11:14:07 -0700
Message-ID: <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com> <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37961 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbdCPSO7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 14:14:59 -0400
Received: by mail-it0-f43.google.com with SMTP id m27so54683450iti.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 11:14:08 -0700 (PDT)
In-Reply-To: <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 11:04 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I think that having the size and information whether an integer
> constant is an integer or pointer should be good enough

The thing is, I don't think you should should actually look at the
pseudo for that AT ALL.

The size is encoded in the operation itself, and that's what you should use.

Now, the "integer vs pointer" thing is perhaps more interesting. We do
*not* encode that, and we use the same "add" operation for both
integers and pointer values. That's because basically linearization
treats pointers as integers too, although we do actually keep the
pseudos separate because we consider casts to/from pointers to be
special (so they aren't _purely_ just integers).

So the instruction itself has

 - size

 - sign

 - _much_ of optype

and I think that the proper long-term fix is perhaps to try to make
that "much" into "all". And part of that may actually be about getting
rid of some of the type differences entirely (ie turn pointers truly
into just pointer-sized integers, the way they almost are already).

That does mean that the llvm interface would need to use even more
explicit casts to make llvm happy.

                Linus
