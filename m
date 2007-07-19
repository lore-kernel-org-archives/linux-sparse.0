From: ricknu-0@student.ltu.se
Subject: Re: Booleans, what a wonderful type!
Date: Thu, 19 Jul 2007 02:38:23 +0200
Message-ID: <1184805503.469eb27f82f96@portal.student.luth.se>
References: <1184723019.469d704b6111b@portal.student.luth.se> <20070718022519.GT21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:44911 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759333AbXGSAia (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jul 2007 20:38:30 -0400
In-Reply-To: <20070718022519.GT21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

Citerar Al Viro <viro@ftp.linux.org.uk>:

> On Wed, Jul 18, 2007 at 03:43:39AM +0200, ricknu-0@student.ltu.se wrote:
> > Good morning to you all!
> > 
> > As most of you do not know, I am on Google's SoC
> >
> <http://code.google.com/soc/2007/sparse/appinfo.html?csaid=CB0974F67B64AD0C>
> to
> > add the ability to suggestions when booleans could/should be used.
> 
> Er...  Of _course_ booleans are values.  And yes, you can say true + false.
> Guaranteed to evaluate to int, value of expression being 1.  It's perfectly
> correct C99.  Same as true + true is guaranteed to be 2 (int, again);
> assigning
> that to _Bool variable is guaranteed to give 1, aka true (see the rules
> for conversion to _Bool).
Can you really say it really is a value? With C definition: ex an positiv
integer value => 'true' => value not zero, if converted from integer to boolean
and back. A value would return a specific value on the secound step, right?
> 
> Now, sparse handling of _Bool sucks in quite a few places (e.g. conversion
> to it is not reduction modulo 2, it's comparison with 0), but I wonder if
> that's what you have in mind...
My main goal is to make it able to find possible places where an integer is used
as an boolean.

Richard Knutsson

PS
Believe I used "Reply" instead of "Reply all" when I answeared your other mail.
So if you won't reply to any, could you please forward a copy to the list? Thanks.
