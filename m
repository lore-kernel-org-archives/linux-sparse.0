From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Booleans, what a wonderful type!
Date: Thu, 19 Jul 2007 08:30:52 +0100
Message-ID: <20070719073052.GU21668@ftp.linux.org.uk>
References: <1184723019.469d704b6111b@portal.student.luth.se> <20070718022519.GT21668@ftp.linux.org.uk> <1184805503.469eb27f82f96@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55454 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbXGSHax (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Jul 2007 03:30:53 -0400
Content-Disposition: inline
In-Reply-To: <1184805503.469eb27f82f96@portal.student.luth.se>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ricknu-0@student.ltu.se
Cc: linux-sparse@vger.kernel.org

On Thu, Jul 19, 2007 at 02:38:23AM +0200, ricknu-0@student.ltu.se wrote:
> > Er...  Of _course_ booleans are values.  And yes, you can say true + false.
> > Guaranteed to evaluate to int, value of expression being 1.  It's perfectly
> > correct C99.  Same as true + true is guaranteed to be 2 (int, again);
> > assigning
> > that to _Bool variable is guaranteed to give 1, aka true (see the rules
> > for conversion to _Bool).
> Can you really say it really is a value? With C definition: ex an positiv
> integer value => 'true' => value not zero, if converted from integer to boolean
> and back. A value would return a specific value on the secound step, right?

Yes.  RTFStandard, please.
 
> > Now, sparse handling of _Bool sucks in quite a few places (e.g. conversion
> > to it is not reduction modulo 2, it's comparison with 0), but I wonder if
> > that's what you have in mind...
> My main goal is to make it able to find possible places where an integer is used
> as an boolean.

I'm afraid that you are confused; what exactly do you mean by "boolean"?
Note that type of 1 == 1 is *not* _Bool; it's defined as int.  You can
convert it to _Bool, but that's it.

Please, read through the relevant sections of standard, starting with
6.3.1.2 and 6.3.1.1[2].  See also 6.5.3.4[5], 6.5.8, 6.5.9, 6.5.13 and
6.5.14 for operations resulting in int 0 or 1.  See 7.16 for stdbool
stuff.
