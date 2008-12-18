From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Thu, 18 Dec 2008 01:10:30 +0000
Message-ID: <4949A306.2060200@knosof.co.uk>
References: <20081217190534.24084.94887.stgit@zaytsev.su>	 <49498C67.4000700@cowlark.com> <f19298770812171633w43707eb0h8c0a0be262549ddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:23747 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752761AbYLRBKt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Dec 2008 20:10:49 -0500
In-Reply-To: <f19298770812171633w43707eb0h8c0a0be262549ddf@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>



Alexey ,

>>> unsigned long test1(void *p)
>>> {
>>>         return sizeof(*p);
>>> }
>> TBH, I don't think that's legal --- I know of several compilers that
>> will refuse to compile it, and gcc -pedantic produces a warning, which
>> means it probably falls into the 'undefined behaviour' bucket of the
>> standard. I can't find anything that specifically talks about sizeof
>> void, but 6.3.2.2.1 prohibits doing *anything* with the result of an
>> expression of type void, which sort of applies here.
>>
>> Of course, I'm thinking about this from the sparse-as-a-compiler point
>> of view, where you're probably more interested in replicating gcc's
>> behaviour.
> 
> This seems to be legal, and quite popular in the Linux kernel. GNU C defines
> sizeof(void) being 1.And as it has the -Wpointer-arith flag, this kind of stuff
> may be caught without sparse if deemed undesirable.

It is a constraint violation.

"The sizeof operator shall not be applied to an expression that has 
function type or an incomplete type"

sentence 1118: c0x.coding-guidelines.com/6.5.3.4.html

void is an incomplete type that cannot be completed
sentence 524: c0x.coding-guidelines.com/6.2.5.html

In pre-C90 days, prior to the availability of void, char * was
often used in a context where void * is now used.  Treating void
as being equivalent to char in some kind of compatibility mode
makes sense.  It looks like the gcc maintainers have over stepped
the mark.

I have reported the bug in gcc.  Track Bug: 38563
at: gcc.gnu.org/bugzilla

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
