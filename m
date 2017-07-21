From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Thu, 20 Jul 2017 23:40:32 -0400
Message-ID: <CANeU7QkgF5N_Byw3j4G-dV1ZoWR6CW+y+UZa3MkrVcFNZmYz8Q@mail.gmail.com>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local> <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
 <20170719221738.2gkctzmdjajz4uec@ltop.local> <CANeU7QkevpEdcp-WmM820sjJ4-LhVyPHeGHETh64WG3jPzewhA@mail.gmail.com>
 <20170720223554.54ohh7pfl7qm43dc@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35257 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966051AbdGUDke (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Jul 2017 23:40:34 -0400
Received: by mail-pf0-f170.google.com with SMTP id r76so2213727pfj.2
        for <linux-sparse@vger.kernel.org>; Thu, 20 Jul 2017 20:40:34 -0700 (PDT)
In-Reply-To: <20170720223554.54ohh7pfl7qm43dc@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 20, 2017 at 6:35 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> You don't need a test case to *think* about the code or simply read
> the explanation I wrote here under.

It is very hard to reason the bug from the description. At most I can kind
of see how we get to that bad spot. It is very hard for me to think is there
other ways to fix it from the description. If you have the code, that is a lot
easier for me to understand the problem and how to approach the fix.

Thank you from your description below, I can construct a program
to show sparse-next has the "crazy programmer" and your patch
did not. I will take a closer look tomorrow.
> OK, it wasn't clear enough.
>
> It will be a few more days before I can access to my usual dev stuff
> where my tests and tests results are.

I have the test C code follow:

int *ptr;
int foo( int i)
{
int *p;
switch (i - i) {        // will be optimized to 0
case 0:                 // will be the simple branch
return 0;
case 1:                 // will be optimized away
do {            // will be an unreachable loop
   *p++ = 123;
} while (--i);
}
return 1;
}

Which will show "crazy programmer" in sparse-next but not your patch.

The crazy programmer error message deserve a better description.
I will take a closer look tomorrow. For now I am happy, I get what
I ask for.  A test program.

Thanks again.

Chris
