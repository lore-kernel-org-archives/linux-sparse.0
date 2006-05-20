From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH] let sparse warn on &inline_function
Date: Sat, 20 May 2006 16:53:53 +0100
Message-ID: <446F3B91.6020709@knosof.co.uk>
References: <200605201621.48466.mb@bu3sch.de> <446F3149.4060606@knosof.co.uk> <200605201734.40756.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:16055 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751326AbWETPx4 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 May 2006 11:53:56 -0400
In-Reply-To: <200605201734.40756.mb@bu3sch.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-sparse@vger.kernel.org

Michael,

> The whole purpose of sparse is to warn on things that are
> not invalid to do, but don't make much sense. ;)
> It simply does not really make sense to mark something
> as "inline" and take pointers to it.

It makes perfect sense for me to want 'direct' calls to be
inlined and be willing to accept that calls via pointers
will not be inlined.

>> Presumably the address of a function is being taken because
>> it is needed.  What is the developer supposed to do instead?
>> Rewrite an algorithm?
> 
> define the function as outlined.

But then the compiler does not have the opportunity to
inline 'direct' calls.

>> Do you have any examples where this warning was useful?
> 
> In most (all?) cases declaring a function as inline and taking
> a pointer to it afterwards does not make logical sense.
> 
> It was originally done to catch things like:

The only place where I might be interested in a warning is
on the function definition.  The warning might say something like
"This function is only called via pointers, so the compiler never
has the opportunity to inline (unless it can figure out that
the pointer to function only ever points at one function)."

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
