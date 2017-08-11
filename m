From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 10 Aug 2017 22:14:40 -0400
Message-ID: <CANeU7QkDvpMgx4THH83wofZfFb-azJVsv=v9kdeww8A9NcqYTA@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com> <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34888 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbdHKCOl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 22:14:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id l82so1497514ywc.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 19:14:41 -0700 (PDT)
In-Reply-To: <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Aug 10, 2017 at 6:34 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Absolutely not.
> Anyway, currectlyeach distinct value correspond to a *single/unique*
> pseudo. IN other words, there is no need to do any kind of CSE on
> *values*, they are already kinda pre-CSEed at their creation
> (because a constant value is nothing more than this value).

I see. value_pseudo() has the hash for all constant values.

But float is not covered.

#define PI 3.1415

double a;
void foo(void)
{
a = a*PI + a*PI*5;
}

 ./test-linearize /tmp/pi.c
/tmp/pi.c:3:8: warning: symbol 'a' was not declared. Should it be static?
/tmp/pi.c:4:6: warning: symbol 'foo' was not declared. Should it be static?
foo:
.L0:
<entry-point>
load.64     %r1 <- 0[a]
set.64      %r2 <- 3.141500 <================
mulu.64     %r3 <- %r1, %r2
set.64      %r5 <- 3.141500 <===duplicate======
mulu.64     %r6 <- %r1, %r5
set.64      %r7 <- 5.000000
mulu.64     %r8 <- %r6, %r7
add.64      %r9 <- %r3, %r8
store.64    %r9 -> 0[a]
ret

>
> Sorry, this has been tried and discussed already. It doesn't really work.
> * a size is essentially a type, certainly for integers in sparse IR.
> * A constant is a constant, 1 is 1, when it has 1 bit or 64 bits, it's the same
>   constant and follow the same mathematical rules. It's even not signed or
>   unsigned, it's just 1.
> * in sparse, types are conveyed by the *operations* made on their operands.
>   There are lots of good reasons for this. Trying to do the opposite for these
>   constants will just break a lot of things, duplicate a lot of code
> (try it) and
>   bring confusion everywhere (because of simply using the operation you
>   then need at each time check the type of the operands. It's something
>   we want to avoid (like for the discussion about casts we had yesterday)
>   not something we want to add).

I see, thanks for the explain. Let me think about it for a while.

> * the OP_PUSH instructions do a perfect job of giving a type to functions
>   arguments
> * the OP_PUSH instructions also nicely abstract away the *operation* of
>   argument passing that all architectures have. It's a good thing.

I need to take a closer look at that patch.

Chris
