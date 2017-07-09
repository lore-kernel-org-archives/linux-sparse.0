From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC 00/34] ptrlist rework with iterator
Date: Sun, 9 Jul 2017 11:52:44 +0200
Message-ID: <20170709095243.7esx42hsa75yy5w3@ltop.local>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qkvy3BLVHszomvdY-SpSZ2A7TSgpofRW9D7Mji=LFub4Q@mail.gmail.com>
 <20170709065004.hkhlj2yy6l7l734y@ltop.local>
 <CANeU7QmEafcK1ScPajnOaDBJHuG8WrK2UiSQNDQug9Ckx1DkJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36524 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdGIJw4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 05:52:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id 77so17919984wrb.3
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 02:52:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmEafcK1ScPajnOaDBJHuG8WrK2UiSQNDQug9Ckx1DkJg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jul 09, 2017 at 01:25:36AM -0700, Christopher Li wrote:
> On Sat, Jul 8, 2017 at 11:50 PM, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> >> It looks very clean on the caller side. It perform extremely
> >> fast. All the internal variable will easy promote to register.
> >
> > But since all real use of the macros will call some functions
> > inside the loops all those nice registers will need to be pushed
> > on the stack.
> 
> Yes, if the loop need to external functions. Those register will
> sync to memory. There is also a lot of loops that don't need to.
> 
> I am looking at simple.c just because I have it open in my editor.
> 
> I count 5 ptrlist loop without function calls, 1 with. Simple.c might
> not be typical because it is likely doing more small stuff. But it
> give an example the loop without function call is not rare at all.

Non-typical example are not very interesting. But yes, some of these
loops doesn't have calls inside. 

> > This sort of artificial benchmark doesn't mean anything, you
> > should know that. What you need to measure is how the stuff is
> 
> I really don't like what you are suggesting. It is fair and straight
> compare. Artificial benchmark usually means pick the workload
> to make certain number look good and ignore the other workload
> which numbers that looks bad.

What you describe is what I would call a 'made-up' benchmark.
It's not what I meant. I just meant 'artificial' as opposing to 'real'.
In other words, not the real (sparse) code with a 'real' workload
(as usually used with sparse, like a kernel compile/checking).

> I thing in this case, it is one sided. If you still think my test is artificial
> and put your ptrlist iteration in unfair situation. I encourage you come
> up with an artificial test which let your version of ptrlist iterator come
> out favorable in performance number. If we can't find such case,
> then it means it is universal not artificial.

I wasn't objecting against the fairness but about the meaningness.
And I certainly won't waste my time to create such 'artificial' benchmark.
 
> > really used to see the real effect on cache and generated code.
> > The we can talk about timing, slowdown & performance.
> > Have you done this and seen a significative difference?
> > (I did it, of course, and there wasn't anything significative,
> > all witihn the noise of the measurements).
> 
> For the record, I did run your code with kernel source checking.
> "wasn't anything significative" by itself was not good enough to
> accept the patch. Such a big rewrite of such fundamental building
> block better have good enough reason for it. I don't see a lot
> of up side to justify it. I definitely see the down side in performance.

And what was this slow down you saw? 5%, 1%, less than 1%? 
It would help to have some number. Like I said above, when
I did the test any speed difference I saw was within the
noise.

> > Also, in November while I was fixing the problem with empty
> > blocks, Linus himself said about the ptrlist macros:
> >         "Some of those inlines look large enough that I wonder
> >          how much sense they make as inlines any more"
> > And indeed, having all those levels of looping inline/in macros
> > is quite questionnable regarding the quality of the code that can
> > be generated and impact on i-cache.
> 
> Maybe he mean just take out the inline keyword and let those
> ptr_xxx function stay as function not inline function?

I think he specically was talking about the code in the macros
but I could be wrong, of course.
 
> ... the performance number is very
> hard for me to swallow.

I understand it, indeed.
You're talking here about the perf number of your small benchmark.
Right?
 
> > It was Linus' remark and combined the issue and the complexity/subtility
> > which motivated me to see what else can be done with these lists.
> 
> The thing is, put those variable in to struct members does not magically
> make it clean and less complex.

Nobody was talking about magic. Do you really believe that this
rework is just about 'put those variable in to struct member'?

If it wasn't clear enough, moving the vars in a struct is just
a side-effect without any interest in itself.
What this rework is all about is to move all the logic into a
small set of primitive functions with minimal interactions
interaction with external and where problems, changes,
debugging, ... can much more easily be done.
And being more i-cache friendly is the second goal.

> I consider those change cosmetic.

Too bad.

> Different people have different preference. It is hard to make every one happy
> on how the code should look. I am reluctant to take *pure* cosmetic change
> without real functional impact. The performance number here is a deal
> breaker for me. There might be other ways to improve it. This is not it.

Yes, yes. I understand. Performance. Performance.
There is also usability, correctness, robustness, maintainability.

And talking about being happy, I really think that the first ones
to be happy should be the users.


Anyway, I posted this series for review, as a starting point to see
where further development can go.
Your "NACK on the function based iterator API" is all what really matter here.

-- Luc
