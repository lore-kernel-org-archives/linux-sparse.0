From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sparse RFC
Date: Mon, 26 Mar 2007 14:21:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703261414400.6730@woody.linux-foundation.org>
References: <1174915776.1142.21.camel@localhost.localdomain>
 <4607F19B.6080303@knosof.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:52583 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbXCZVVb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 17:21:31 -0400
In-Reply-To: <4607F19B.6080303@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, Sparse mailing list <linux-sparse@vger.kernel.org>



On Mon, 26 Mar 2007, Derek M Jones wrote:
> 
> > I have been playing around with the sparse code, and was thinking of
> > adding a few of the checks that my company uses from other code
> > checkers, starting with checking that macro arguments have brackets
> > around them. (Because this is the test my/other code most often fails)
> 
> This is a useful check.  However, you need to make sure that
> cases where the presence of () have no impact are not flagged
> if the parameter is always used in such contexts.  Otherwise the
> noise can be excessive.

Indeed. In the kernel, for example, we sometimes use nested macros for the 
complex cases, and there one of the cases is where the "outer" or inner 
macro adds all required brackets. Ie something like

	#define ALIGN(x,a)              __ALIGN_MASK(x,(typeof(x))(a)-1)
	#define __ALIGN_MASK(x,mask)    (((x)+(mask))&~(mask))

where ALIGN() uses 'x' without any brackets, because it knows the inner 
macro is safe (and a comma expression must have had any brackets of its 
own, otherwise it wouldn't have parsed as a single macro argument anyway!)

> > 2) For the macro argument checking would it be better if I checked for
> > either a bracket or low precedence operator on both sides of the
> > argument ? like either a comma or a type of assignment operator? it
> > would not be a foolproof check then but would seem more sensible to me,
> > and might be more acceptable to users.
> 
> Don't make the assumption that everybody knows the precedence
> of binary operators.  An experiment I ran last year with experienced
> developers (average over 10 years) threw up some unexpected results.
> See: http://www.knosof.co.uk/cbook/accu06a.pdf

Yeah. The only exception is literally the comma expression, because of the 
syntax of macro expansion itself (ie a comma would break a macro argument, 
unless it is bracketed). Pretty much all other precedence rules can pretty 
much be expected to be confused by somebody.

		Linus
