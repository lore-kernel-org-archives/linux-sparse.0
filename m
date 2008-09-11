From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 6/9 v2] check context expressions as expressions
Date: Wed, 10 Sep 2008 17:15:00 -0700
Message-ID: <70318cbf0809101715v4baa40b1pf90d2b59f3078f72@mail.gmail.com>
References: <20080529085402.814224000@sipsolutions.net>
	 <20080529085516.930777000@sipsolutions.net>
	 <1221032003.12266.4.camel@johannes.berg>
	 <70318cbf0809101221n53dd06c2x19c68a1df336cb35@mail.gmail.com>
	 <1221082440.3804.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:6358 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYIKAPD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Sep 2008 20:15:03 -0400
Received: by gv-out-0910.google.com with SMTP id e6so61143gvc.37
        for <linux-sparse@vger.kernel.org>; Wed, 10 Sep 2008 17:15:01 -0700 (PDT)
In-Reply-To: <1221082440.3804.40.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org, Harvey Harrison <harvey.harrison@gmail.com>

On Wed, Sep 10, 2008 at 2:34 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>> I feel that this patch  is adding too much hack to the
>> sparse front end. At the very least, can you
>> just change __context__ parsing to accept symbol expression
>> and the let the checking back end to do the code motions
>> stuff?
>
> Can you explain?

Maybe you can help to explain why do you need to make so
many front end(parser) changes. I especially don't like the part
that does the replace ident.

From what I can tell, you just need to know that context are
using the same expression on accessing the locks. Let's put
aside that it is right assumption or not. From the back end side,
you should able to get to all the expression and verify they are
the same without doing much front end changes.

All the code for "expression is equal test" should be move to
back end using linearized byte code. As matter of fact, sparse
have a simple common expression eliminate already.

> Well, yeah, it's very simple, and that doesn't help. And it's not about
> cross-function checking either:
>
> extern spinlock_t a;
>
> spin_lock(&a);
> rcu_read_unlock()

As I said, it is simple and does not take into account of which symbol
take the lock. But using same expression is not solid either.
How about:
extern spinlock_t a;

spinlock_t *p = &a;

spin_lock(&a);
spin_unlock(p);

> will not result in an error which is a pain.
>
>> The new context checking seems able to do more features.
>> But it has too many sore spots. I vote for back it out.
>
> I don't care, I don't have any more cycles to burn on this. For all I'm
> concerned it works pretty well and is a HUGE improvement over the
> current sparse which
>  * doesn't tell you what line the error really is in, it only warns
>   about the last line of the function
>  * isn't able to check different contexts despite documenting it
>   (see above)

You should able to do the same thing in the linearized back byte code.
You just linearized the context expression using pseudo. Then on
the checker side you can use the byte code to evaluate the expression
is same or not, by comparing expression instructions.
You can even get around the p=&a problem I mention above because
in the linearized byte code level, you can do some real data flow
analyze.

I think it is unnecessary to change the front end code to track
expression. In the back end you can do that much better.
That is the main reason I object to this patch.

>> I am not saying that annotation is not useful. I agree source
>> code annotation helps on the source code reading. But it
>
> Actually, I kinda disagree. Annotating *each and every function* with
> the locks it requires is _very_ useful, not just for sparse but also for
> human readers of the code. Hence, I don't just want sparse to check
> across functions, I want to be able to tell people what to do for
> calling a given function as well. The fact that sparse can check my
> annotations is great, but having them would be useful without that as
> well.

I don't think we have disagreement here. I do agree having source
code annotation is good for human reading. Please read my email.
But that shouldn't stop you having the checker to understand your code.

Even better, how do you know your annotation is in sync with your
code? You can have the checker to warn you that your annotation
is not in sync with code.

>
>
> It used to be like that. But I'm arguing (and others backed me up on
> this) that inlines are really just functions and as such should be
> annotated, not magically inlined into the code and then checked as
> sparse behaves right now.

First of all, I am just give it as example of idea how this problem can
be solved.

About annotate inline function or not, I don't have strong preference
against it. But I can see it is imposing a burden to maintain the additional
annotation. Now you update the code and you have to update the annotation
as well. You require developers who write new function to understand
the spase context checking and maintain the annotation as well.
You are creating addition work for kernel developers.

> Please don't focus on cross-function checking so much. Having different
> contexts is way more desirable, and cross-function checking probably is
> _not_ desirable in that you _want_ the annotations.

That is not what I said, you can keep your precious annotations for
human reading. But that does not mean sparse checker should limited
itself to only using annotations if it can be smarter about it.

Having cross-function checking is not exclusive to the annotations.
But having cross-function checking can enable some very useful
feature which we can't do right now.

Chris
