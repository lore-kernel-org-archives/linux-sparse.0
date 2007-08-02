From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: Re: Finding all typedefs
Date: Thu, 02 Aug 2007 01:15:34 +0100
Message-ID: <46B12226.1070802@codethink.co.uk>
References: <1185574111.2029.10.camel@dv>	 <20070727160147.6ecbfd86.rdunlap@xenotime.net>	 <1185983112.2425.12.camel@dv> <1185987691.3123.33.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:58995 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbXHBANN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Aug 2007 20:13:13 -0400
In-Reply-To: <1185987691.3123.33.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Pavel Roskin <proski@gnu.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

Josh Triplett wrote:
> On Wed, 2007-08-01 at 11:45 -0400, Pavel Roskin wrote:
>> On Fri, 2007-07-27 at 16:01 -0700, Randy Dunlap wrote:
>>> I asked Linus about 3 years ago for something that would dump
>>> global data sizes.  It's attached (updated to recent sparse;
>>> it also has '-keywords' to warn about using C++ keywords, but you
>>> can ignore/delete that part).  It may be fixable to do what you want,
>>> although I have no info on sparse symbol struct contents.
>>> Or maybe Josh et al can do what you want rather easily... :)
>> Sorry for delay.  Thank you!  I'm not sure I can reuse anything from
>> that code to dump typedefs.
>>
>> My point is, I want to write a script that would use existing software
>> to produce checkpatch.pl conforming code.  If I need to hack anything,
>> I'd rather contribute to indent or astyle.  In fact, it would be a much
>> better approach to recognize argument lists and format them differently,
>> rather than deal with a list of typedefs.
>>
>> I hoped that c2xml would give me typedefs, but it doesn't.
> 
> It certainly should; I didn't realize that it didn't.  I'll look into it
> and see if I can change that.
> 
> CCing Rob (the author of c2xml) to see if he has any thoughts on this.

Well, the way a typedef appears in the c2xml output is a symbol with
type="node" and user-type="1", but this also applies to nodes that are
instances of typedefs. I still haven't figured out why I never get any
symbols with MOD_TYPEDEF set. I suspect parse.c:1225:8, though I don't
really understand this bit of code.

Another annoying thing is that the types are always resolved for
typedefs. i.e. for

typedef int foo;
foo bar;

the symbol for bar has a base type of int.

Any suggestions for how to solve this would be greatly appreciated :)

Thanks,
Rob Taylor
