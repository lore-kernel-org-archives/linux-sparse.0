From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 08:39:35 -0700
Message-ID: <1182958775.8970.56.camel@josh-work.beaverton.ibm.com>
References: <20070627103320.GA11047@localhost.sw.ru>
	 <1182956472.8970.35.camel@josh-work.beaverton.ibm.com>
	 <46827F4D.7010305@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:47004 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbXF0Pjf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 11:39:35 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l5RFYZoq028326
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 11:34:35 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5RFdYDD214732
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 09:39:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5RFdXgr020334
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 09:39:34 -0600
In-Reply-To: <46827F4D.7010305@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Alexey Dobriyan <adobriyan@sw.ru>, linux-sparse@vger.kernel.org, adobriyan@gmail.com

On Wed, 2007-06-27 at 16:16 +0100, Derek M Jones wrote:
> Alex, Josh,
> 
> > On Wed, 2007-06-27 at 14:33 +0400, Alexey Dobriyan wrote:
> >> sparse silently accepts some peculiar combinations of declaration
> >> specifiers:
> 
> These are all permitted by the syntax of C.
> 
> 6.7 Declarations, the init-declarator-list is optional.

Huh; interesting.  That explains "int volatile;" as well; it doesn't
parse as an attempt to declare an integer named volatile, but as a
declaration with no variable.

> >> "typedef extern;" passes.
> ...
> >> Not sure how many different bugs there are here, though...
> 
> Sparse might flag the usage as suspicious, but it is not a bug.

Probably not worth the trouble of flagging.

> > Several more:
> 
> The syntax permits:
> 
> signed unsigned short long double int;

I would hope it does not permit "double int".

Sparse will in fact spew errors about *that* syntax:
/dev/stdin:1:8: error: You cannot have both signed and unsigned modifiers.
/dev/stdin:1:17: error: You cannot have both signed and unsigned modifiers.
/dev/stdin:1:23: error: You cannot have both long and short modifiers.
/dev/stdin:1:23: error: You cannot have both signed and unsigned modifiers.
/dev/stdin:1:28: error: modifier [signed] [unsigned] is invalid in this context
/dev/stdin:1:28: error: You cannot have both signed and unsigned modifiers.
/dev/stdin:1:35: error: Trying to use reserved word 'int' as identifier

- Josh Triplett
