From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC 00/34] ptrlist rework with iterator
Date: Sun, 9 Jul 2017 01:25:36 -0700
Message-ID: <CANeU7QmEafcK1ScPajnOaDBJHuG8WrK2UiSQNDQug9Ckx1DkJg@mail.gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qkvy3BLVHszomvdY-SpSZ2A7TSgpofRW9D7Mji=LFub4Q@mail.gmail.com> <20170709065004.hkhlj2yy6l7l734y@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36853 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdGIIZn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 04:25:43 -0400
Received: by mail-pg0-f47.google.com with SMTP id u62so35364886pgb.3
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 01:25:37 -0700 (PDT)
In-Reply-To: <20170709065004.hkhlj2yy6l7l734y@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 8, 2017 at 11:50 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> It looks very clean on the caller side. It perform extremely
>> fast. All the internal variable will easy promote to register.
>
> But since all real use of the macros will call some functions
> inside the loops all those nice registers will need to be pushed
> on the stack.

Yes, if the loop need to external functions. Those register will
sync to memory. There is also a lot of loops that don't need to.

I am looking at simple.c just because I have it open in my editor.

I count 5 ptrlist loop without function calls, 1 with. Simple.c might
not be typical because it is likely doing more small stuff. But it
give an example the loop without function call is not rare at all.

>
> This sort of artificial benchmark doesn't mean anything, you
> should know that. What you need to measure is how the stuff is

I really don't like what you are suggesting. It is fair and straight
compare. Artificial benchmark usually means pick the workload
to make certain number look good and ignore the other workload
which numbers that looks bad.

I thing in this case, it is one sided. If you still think my test is artificial
and put your ptrlist iteration in unfair situation. I encourage you come
up with an artificial test which let your version of ptrlist iterator come
out favorable in performance number. If we can't find such case,
then it means it is universal not artificial.

> really used to see the real effect on cache and generated code.
> The we can talk about timing, slowdown & performance.
> Have you done this and seen a significative difference?
> (I did it, of course, and there wasn't anything significative,
> all witihn the noise of the measurements).

For the record, I did run your code with kernel source checking.
"wasn't anything significative" by itself was not good enough to
accept the patch. Such a big rewrite of such fundamental building
block better have good enough reason for it. I don't see a lot
of up side to justify it. I definitely see the down side in performance.


>
> Also, in November while I was fixing the problem with empty
> blocks, Linus himself said about the ptrlist macros:
>         "Some of those inlines look large enough that I wonder
>          how much sense they make as inlines any more"
> And indeed, having all those levels of looping inline/in macros
> is quite questionnable regarding the quality of the code that can
> be generated and impact on i-cache.

Maybe he mean just take out the inline keyword and let those
ptr_xxx function stay as function not inline function?

Anyway, if there is more specific code we can discuss. I can
take a look at what needs to be done as well. It doesn't have
to be a big rewrite, especially the performance number is very
hard for me to swallow.

> It was Linus' remark and combined the issue and the complexity/subtility
> which motivated me to see what else can be done with these lists.

The thing is, put those variable in to struct members does not magically
make it clean and less complex. I consider those change cosmetic.
Different people have different preference. It is hard to make every one happy
on how the code should look. I am reluctant to take *pure* cosmetic change
without real functional impact. The performance number here is a deal
breaker for me. There might be other ways to improve it. This is not it.

Chris
