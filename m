From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 6/9 v2] check context expressions as expressions
Date: Wed, 10 Sep 2008 12:21:30 -0700
Message-ID: <70318cbf0809101221n53dd06c2x19c68a1df336cb35@mail.gmail.com>
References: <20080529085402.814224000@sipsolutions.net>
	 <20080529085516.930777000@sipsolutions.net>
	 <1221032003.12266.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:28103 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYIJTVc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Sep 2008 15:21:32 -0400
Received: by an-out-0708.google.com with SMTP id d40so467661and.103
        for <linux-sparse@vger.kernel.org>; Wed, 10 Sep 2008 12:21:31 -0700 (PDT)
In-Reply-To: <1221032003.12266.4.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org, Harvey Harrison <harvey.harrison@gmail.com>

On Wed, Sep 10, 2008 at 12:33 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:

> +static int ident_equal(struct ident *ident1, struct ident *ident2)
> +{
> +       if (ident1 == ident2)
> +               return 1;
> +       if (!ident1 || !ident2)
> +               return 0;
> +
> +       return ident1->len == ident2->len &&
> +               !strncmp(ident1->name, ident2->name, ident1->len);
> +}

Nah, you pretty should never need to do that.
Ident equal should just need to compare ident1 == ident2.

All ident has been hashed. Same ident, should show up
as same pointer. Doing strncmp again is unnecessary.

I feel that this patch  is adding too much hack to the
sparse front end. At the very least, can you
just change __context__ parsing to accept symbol expression
and the let the checking back end to do the code motions
stuff?

I haven't study the new context checking very carefully.
I actually prefer the Linus's  old simple context checking.
Yes, that does not distinguish which symbols taking the lock.
But other than that it is working and counting the number
correctly. And, it is very simple.

The new context checking seems able to do more features.
But it has too many sore spots. I vote for back it out.

Instead of keep adding more hacks to fix up the problem. I
think we should step back and ask ourselves what do we really
want to achieve.

The fundamental problem I saw here is that, sparse does not
support cross function checking. There is no good way to save
some analyzed result for some function and used it later by other
function. That is why we actually have to put __context__
around so many functions. The __context__ describe what
these functions in forms of source code annotation. There is
only so much we can do with source code annotations.
I am not saying that annotation is not useful. I agree source
code annotation helps on the source code reading. But it
shouldn't limit checker only use the annotations. The checker
should be able to draw intelligent conclusions, by looking the
the function source code itself.

e.g. Why do we have to annotate foo_lock(&bar->lock) will take a lock
on &bar->lock? The checker should be able to find out foo_lock() just
callers some lower level locking functions. For example,  let say if we
can force foo to be inlined into the caller even foo is not declared as
inline. Then there is no need to annotate foo itself. The caller see
exactly what foo does.

So, I think we should implement cross functions checking capability
systematically rather than putting more hacks on source code
annotation. The writer patch I send out earlier is one step towards it.
I will write up more detail proposal.

Chris
