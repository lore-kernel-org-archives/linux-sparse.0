From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bug relate to delete ptr list entry while parent looping on it
Date: Mon, 10 Jul 2017 06:54:06 -0700
Message-ID: <CANeU7QkUcJdG7GErme4+HJOiruSmJAH9AjFZS0kTMcY46Hf3jw@mail.gmail.com>
References: <CANeU7QnEnRiaLgYP-cLOgEJD1Hrc3aUMn7MrpjYJoGFjBzKUnA@mail.gmail.com>
 <20170709071236.w2cww4r6oac5vdk7@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36170 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbdGJNyI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Jul 2017 09:54:08 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so49874425pgb.3
        for <linux-sparse@vger.kernel.org>; Mon, 10 Jul 2017 06:54:07 -0700 (PDT)
In-Reply-To: <20170709071236.w2cww4r6oac5vdk7@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jul 9, 2017 at 12:12 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Most of the case is "return" or "jmp" inside a ptrlist
>> loop.
> Yes, I saw that when running your previous version on the testsuite.

One interesting idea is just use sparse context balance check
to check the sparse code itself. It should work wonderfully
with the ptrlist ref count. Because the loop will always terminate
inside a function. We will never have the false alarm like the kernel
has, which cause by some lock_acquire helper function.

I have been doing it by hand so far. If I know I need to go through
that many attempt to fix it, I might use the context check earlier.

> Yes, the recursive kill_instruction I talked about.
> I have already been bitten by it several time (not especially
> about ptrlist thing, but other stuff too), it's quite dangerous.

I dig a bit deeper. In this case, the outer loop is holding
position 12, and the delete is happen on 11, one entry before.
There for delete entry 11 will cause the list->list[] to slide forward
impact position 12. The situation I am worry about does happen
in real life.

> 1) it would be a big code change
> 2) change in simplification have non-onbious impact on the diagnostics
>    that are emitted (simplification -> dead code elimination (1st impact)
>    -> branch simplification/mergin (2nd impact)).
> But theer exist other simple fixes.

Suggestions of other simple fixes? This bug is holding the release.
I would love to get some simple temporary way to work around the bug.
It does not need to be perfect.

Chris
