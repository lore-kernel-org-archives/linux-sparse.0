From: Christopher Li <sparse@chrisli.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Wed, 6 Aug 2014 02:15:18 -0700
Message-ID: <CANeU7QkJdCWZggG=XnsdD54+2FUvG9SKLKG7141s62jOesJ_nA@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
	<CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
	<CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com>
	<CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
	<CA+55aFzWAZ-ZQ6DSvnj6vQnwCHyDX11an1nOAo43UGaLcfshwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:53634 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbaHFJPT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Aug 2014 05:15:19 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so2352948qgd.33
        for <linux-sparse@vger.kernel.org>; Wed, 06 Aug 2014 02:15:18 -0700 (PDT)
In-Reply-To: <CA+55aFzWAZ-ZQ6DSvnj6vQnwCHyDX11an1nOAo43UGaLcfshwg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 2, 2014 at 12:53 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Aug 2, 2014 at 11:10 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>> Actually, the "find_identifier" call inside function "check_designators" already
>>> calculate the correct offset. Only if we can pass that offset to
>>> "convert_ident()".
>>
>> I actu
> My stupid test-case is this incredibly hacky thing:
>
>     struct A {
>         int aa;
>         int bb;
>     };
>
>     struct S {
>         int a;
>         union {
>             int b;
>             int c;
>         } u[10];
>         int dummy;
>         union {
>             int d;
>             int e;
>         };
>     };
>
>     int fn(void)
>     {
>         struct S s = {
>             .a = 1,
>             .u[2].b = 2,
>             .dummy = 1,
>              { 3 }
>         };
>         return s.dummy*1000 + s.d*100 + s.u[2].b*10 + s.a; // 1321
>     }
>
> where I use "./test-linearize" to verify that the initializer layout
> matches the code generation layout (so that 'fn' function *should*
> linearize to just a simple "ret.32 $1321", and with this patch it
> does).
>
> But I bet this misses some case. However, the current state wrt
> initializer offsets really is very broken, so maybe it's ok.
>
> Can anybody see anything wrong with it? It's reasonably simple. Every
> place that initializes "expr->field" for an EXPR_IDENTIFIER now also
> initializes "expr->offset".

I did not see any thing wrong with it. The only thing is it bump up the
expression struct size. Definitely better than what we have right now.

Chris
