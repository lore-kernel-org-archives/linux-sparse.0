From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Wed, 29 Mar 2017 00:28:29 +0200
Message-ID: <20170328222828.ahih2egqe7pe5jdw@macpro.local>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local>
 <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <20170328170049.2y6lwxx64yzjjwmc@macpro.local>
 <CA+55aFz6C5bEJqr72mBauWRUQiKYJ8eQpiXrKRW7JEiKXjZdrw@mail.gmail.com>
 <20170328202746.bmamqhxitmpvfsad@macpro.local>
 <CA+55aFyWtn3_o+D5f1V9NvwHSDBFHi57tv4vOjJAffhCyqL7mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33554 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932157AbdC1W2i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 18:28:38 -0400
Received: by mail-wr0-f174.google.com with SMTP id w43so101387288wrb.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 15:28:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFyWtn3_o+D5f1V9NvwHSDBFHi57tv4vOjJAffhCyqL7mA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 02:57:01PM -0700, Linus Torvalds wrote:
> On Tue, Mar 28, 2017 at 1:27 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Tue, Mar 28, 2017 at 11:02:32AM -0700, Linus Torvalds wrote:
> >>
> >> The single-store shortcut is actually pretty important, because it is
> >> what turns a *lot* of local variables from stack memory things into
> >> pseudos. That's partly because the sparse optimizations aren't all
> >> that smart.
> >
> > Everytime I look at this part of the code, I think the same:
> >   why turn all vars into stack memory to have to turn them later
> >   into pseudos?
> 
> Oh, you absolutely *cannot* turn them into pseudo's directly.

No no, of course. I was just thinking loud about how easy it would
be to simplify the case of simple local variables whose address is
not taken.
 
> A pseudo is a "register", and in SSA format. Local variables are not
> registers, and do not honor SSA.
> 
> So local variables are very much *not* pseudos at any time. Local
> variables can have their address taken, local variables can be
> assigned multiple times, local variables can have complex types, none
> of which is pseudo-like behavior.
> 
> Now, some *very* limited cases of local variables end up being
> trivially very similar to pseudos, and those simple cases get turned
> into pseudos. But that only happens for the simple cases - when their
> address is not taken or used, and when they only have a single
> assignment to them.
> 
> But local variables do not start out as pseudos, exactly because the
> pseudo case is a very very very limited case of the full local
> variable case.

I was not thinking to turn them directly into pseudos, just to recognize 
that they will turn into pseudo and this is useless to turn them into
stack memory. So multiple assignmement would be OK, but having its 
address taken would not and being an array would also not be OK.
I have no idea if it would simplify or speedup things though.

-- Luc
