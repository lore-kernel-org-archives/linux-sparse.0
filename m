From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Interesting (?) failure case
Date: Thu, 9 Apr 2020 08:23:19 +0200
Message-ID: <20200409062319.ykuewl7z3dc3a55n@ltop.local>
References: <CAHk-=wg=Fs=EecQCNNzofn8+QXuB-sYy9m+YVPAmzDesmqFsbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38698 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIGXW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Apr 2020 02:23:22 -0400
Received: by mail-wm1-f48.google.com with SMTP id f20so2928073wmh.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Apr 2020 23:23:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=Fs=EecQCNNzofn8+QXuB-sYy9m+YVPAmzDesmqFsbg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Apr 08, 2020 at 09:02:59PM -0700, Linus Torvalds wrote:
> Try linearizing this with 'sparse', and see it fail miserably:
> 
>    int t(void)
>    {
>         goto inside;
>         return 0 ?
>                  ({ inside: return 3; 1; })
>                 :
>                  2;
>    }
> 
> I came up with that disgusting example after talking to Nick
> Desaulniers about how sparse does some front-end optimizations early,
> and it made me go "Hmm... What about.."

Funny, I worked on something very similar last week:
	void f(int x, int y)
	{
		1 ? x : ({
	a:
			 y;
		});
		goto a;
	}

> There are two reasonable approaches for the above:
> 
>  - return 3 (due to the "goto inside")
> 
>  - tell the user to pound sand for doing crazy things and jumping into
> a statement expression from outside.
> 
> clang does #1. gcc does #2.
> 
> sparse does something bad, and just generates garbage silently.

Yes, the problem is caused at expand_conditional() where one of
the sides is throwed away if the condition is known. So the label
doesn't exist anymore and at linearization Sparse ends with a
jump to an unexisting BB.

I tried to simply discard the early optimization in expand but
then when testing the kernel I got a whole bunch of warnings
(bad type or dereference of noderef type, I don't remember).
So it seems that in general (when nobody jump into the expression
statement) the conditional needs to be simplified before evaluation.

I tried also to warn on gotos jumping into an expression statement.
The idea was to give a new 'label_scope' for each such statement.
Things are a bit complicated because the labels are implicitly
declared by the gotos.

I'll need to look a bit more at this.

-- Luc
