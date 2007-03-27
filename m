From: "Darren Jenkins" <darrenrjenkins@gmail.com>
Subject: Re: Sparse RFC
Date: Tue, 27 Mar 2007 13:07:53 +1000
Message-ID: <82faac5b0703262007u71a95cfcre64ff29c5df62b38@mail.gmail.com>
References: <1174915776.1142.21.camel@localhost.localdomain>
	 <4607F19B.6080303@knosof.co.uk>
	 <Pine.LNX.4.64.0703261414400.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:1478 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbXC0DHy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 23:07:54 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2342945wxd
        for <linux-sparse@vger.kernel.org>; Mon, 26 Mar 2007 20:07:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0703261414400.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Derek M Jones <derek@knosof.co.uk>, Sparse mailing list <linux-sparse@vger.kernel.org>

On 3/27/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 26 Mar 2007, Derek M Jones wrote:
>
> > This is a useful check.  However, you need to make sure that
> > cases where the presence of () have no impact are not flagged
> > if the parameter is always used in such contexts.  Otherwise the
> > noise can be excessive.
>
> Indeed. In the kernel, for example, we sometimes use nested macros for the
> complex cases, and there one of the cases is where the "outer" or inner
> macro adds all required brackets. Ie something like
>
>         #define ALIGN(x,a)              __ALIGN_MASK(x,(typeof(x))(a)-1)
>         #define __ALIGN_MASK(x,mask)    (((x)+(mask))&~(mask))
>
> where ALIGN() uses 'x' without any brackets, because it knows the inner
> macro is safe (and a comma expression must have had any brackets of its
> own, otherwise it wouldn't have parsed as a single macro argument anyway!)

Hmm it looks like a 'bracket or comma' check wouid correcly ignore
this particular example.

It is obvious however that I need to think about this a bit more.


> > > 2) For the macro argument checking would it be better if I checked for
> > > either a bracket or low precedence operator on both sides of the
> > > argument ? like either a comma or a type of assignment operator? it
> > > would not be a foolproof check then but would seem more sensible to me,
> > > and might be more acceptable to users.
> >
> > Don't make the assumption that everybody knows the precedence
> > of binary operators.  An experiment I ran last year with experienced
> > developers (average over 10 years) threw up some unexpected results.
> > See: http://www.knosof.co.uk/cbook/accu06a.pdf

Yep I am guilty of getting them wrong before.

> Yeah. The only exception is literally the comma expression, because of the
> syntax of macro expansion itself (ie a comma would break a macro argument,
> unless it is bracketed). Pretty much all other precedence rules can pretty
> much be expected to be confused by somebody.

I didn't look into it but I was thinking that something that evaluated
into a comma, after the initial macro expansion would still be
passible/an issue.



Thanks for the feedback guys. I guess I will keep tinkering with it.

Darren J.
