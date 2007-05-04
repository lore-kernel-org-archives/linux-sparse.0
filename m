From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: inline functions and context
Date: Fri, 4 May 2007 11:52:52 -0700
Message-ID: <70318cbf0705041152x130cce81i20e00f1d9a509575@mail.gmail.com>
References: <4638DDFD.9020609@freedesktop.org>
	 <70318cbf0705031440t3f48d26fs4dab8ec71eb5574f@mail.gmail.com>
	 <463AD737.8010600@freedesktop.org>
	 <70318cbf0705041110m48391b26w5fc5b23c5f2bd74f@mail.gmail.com>
	 <463B790E.10906@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:65464 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161481AbXEDSwy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2007 14:52:54 -0400
Received: by nz-out-0506.google.com with SMTP id o1so957384nzf
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2007 11:52:53 -0700 (PDT)
In-Reply-To: <463B790E.10906@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Adding sparse mailing list as Josh requested.

On 5/4/07, Josh Triplett <josh@freedesktop.org> wrote:
> Christopher Li wrote:
> > On 5/3/07, Josh Triplett <josh@freedesktop.org> wrote:
> >> Perhaps we should add inline functions to the symbols list.  I personally like
> >> the idea of treating them as regular functions that just happen to have the
> >> "inline" attribute, at least until Sparse has a real need to perform inlining.
> >
> > No. That is a bad idea. Inline function get include many times when checking
> > on different source file. You will get tons duplicate warnings because different
> > source file include the same header file. It also slow down the sparse checking.
>
> The same thing happens for any other kind of warning that occurs on something
> in a header file; I don't consider that a problem.

If you do that, you will see tons of repeated warning on the spinlock header
files. Sparse already has pretty high noise level, you really don't want more.

>
> >> Not what I mean.  I don't want to see multiple complaints about an unepected
> >> unlock in unlock_something, one per call to it; I want to see *one* complaint
> >> about an unexpected unlock in unlock_something, emitted when analyzing
> >> unlock_something.  I don't think f should generate any warnings, unless you
> >
> > That is pretty useless. Because we know that unlock_something is just a wrapper
> > of unlocking. Telling me that this function has lock unbalance is not
> > interesting.
>
> How do you know?  Why do we not assume that any function which unlocks without
> locking, like f, "is just a wrapper of unlocking"?  I think we should stop at
> the first function that doesn't explicitly say "I intended to change the
> context", and not propogate the warning outward.
>
> > I actually want to see the user of unlock_something() doing some thing wrong.
>
> How do you know they did something wrong?  Perhaps unlock_something did
> something wrong?  Not every inline function that uses locks serves as a
> trivial lock wrapper.

Sparse can tell who's fault it is by just looking at the inline
function. It also can't
tell if it is unlock_something() wrong or some thing wrong with f(). That is why
it is better report on the f(). We can examine the f(), with ctags we
can find out
what it really does, so if it is fault in unlock_something(), we still can tell.

The reverse it not true. If you only report error in
unlock_something(). It is very
hard to find out which caller trigger the unbalance.

If there is some thing wrong with the inline function, sparse will complain when
some one actually use it. You will not  miss it.

> >> add context annotations to lock_something and unlock_something and they don't
> >> match, or unless Sparse starts doing whole-program analysis and looks inside
> >> both lock_something and unlock_something and finds that they don't match.
> >
> > In your case, you should just add context annotation to declaration of
> >  lock_something.
> > Sparse will take into account that lock_something change context. It
> > will also inline
> > unlock_something, which has some instruction will change context as
> > well. In the end
> > sparse will find out context is balanced at exit. It is not as good as
> > whole-program
> > analysis because you have to annotate lock_something manually. On the
> > other hand,
> > annotation for lock_something is good for reading as well. There is
> > very limited header
> > file need this kind of annotation.
> >
> > The bottom line is, if you annotate the function correctly, sparse
> > will do the right thing
> > on counting the balance..
>
> It seems wrong to me that annotating lock_something and not annotating
> unlock_something will satisfy sparse.

That is because unlock_something has implementation detail get inlined while
lock_something does not. The context annotation for lock_something is to
make up for that.

Chris
