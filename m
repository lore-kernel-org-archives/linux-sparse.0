From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Bug relate to delete ptr list entry while parent looping on it
Date: Sun, 9 Jul 2017 09:12:36 +0200
Message-ID: <20170709071236.w2cww4r6oac5vdk7@ltop.local>
References: <CANeU7QnEnRiaLgYP-cLOgEJD1Hrc3aUMn7MrpjYJoGFjBzKUnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33724 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdGIHMk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 03:12:40 -0400
Received: by mail-wr0-f170.google.com with SMTP id r103so98081998wrb.0
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 00:12:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnEnRiaLgYP-cLOgEJD1Hrc3aUMn7MrpjYJoGFjBzKUnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 08, 2017 at 10:54:18PM -0700, Christopher Li wrote:
> Hi Luc,
> 
> I make some progress of the ptrlist ref count patch.
> A lot of update to make the ref count right.
> Most of the case is "return" or "jmp" inside a ptrlist
> loop.
Yes, I saw that when running your previous version on the testsuite.

> Another issue I hit is that, if return inside two level
> of ptrlist, it need to release both ptr list.
> 
> My patch can pass the testsuit without complaining
> any more.
> 
> When I use it to check the kernel. I found some thing.
> Looking from the back trace, I think it is a real bug that
> it catch (instead of a false alarm like last one).
> 
> The list in question is pseudo->users.
Yes, the recursive kill_instruction I talked about.
I have already been bitten by it several time (not especially
about ptrlist thing, but other stuff too), it's quite dangerous.

> I am convince this is a real one.
Yes, most probably.

> I think you are the expert in simplify.c, I can use some help here.
> 
> I am looking for simple ways to avoid nested looping delete.
> For example, less aggressive on simplify things is fine.
Alas, I don't think this can be done because:
1) it would be a big code change
2) change in simplification have non-onbious impact on the diagnostics
   that are emitted (simplification -> dead code elimination (1st impact)
   -> branch simplification/mergin (2nd impact)).
But theer exist other simple fixes.

> The goal is find simple way let sparse pass the full kernel check without die on
> the ptr ref count checking patch. Proper fix the ptrlist nested
> looping delete might
> be too big for this up coming release. Avoid it if we can.
> 
> BTW, I am not going to push ptr ref count patch into the 0.5.1 release.
> It is just for checking.

Yes, sure.

-- Luc 
