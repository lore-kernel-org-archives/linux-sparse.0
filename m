From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: pointer arithmetics and casts
Date: Sat, 26 May 2007 16:45:51 +0100
Message-ID: <20070526154551.GS4095@ftp.linux.org.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk> <20070525220051.GO4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43223 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760861AbXEZPpw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 May 2007 11:45:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrySl-0001px-Pp
	for linux-sparse@vger.kernel.org; Sat, 26 May 2007 16:45:51 +0100
Content-Disposition: inline
In-Reply-To: <20070525220051.GO4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Fri, May 25, 2007 at 11:00:51PM +0100, Al Viro wrote:
> > But that means a fsckload of extra nodes allocated on pretty much any
> > program - use of arrays is not rare and indices tend to be int, so we
> > hit an extra allocated node on each such place.
> 
> Argh...  Question: how much do we care if we see BINOP[+] with 64bit
> type as result and 32bit type in one of the arguments?  That's what
> we get when we have
> 	char *p;
> 	int i;
> 
> 	p + i
> 
> with -m64.  IOW, how much does it violate the assumptions outside of
> frontend?  We do not allocate any new nodes if sizeof(*p) is 1...

Actually, turns out that at least on the kernel builds a straightforward
variant (IMPLIED_CAST when width of i is smaller than bits_in_pointer,
whatever sizeof(*p) might be) isn't visibly smaller...  It would need
more profiling, but there's a chance that nothing trickier would be
needed.

BTW, _Bool is seriously mishandled - for one thing, some places treat it 
as one-bit unsigned integer (i.e. (_Bool)2 becomes 0 with a warning, while
it should yield 1).  For another, sizeof(_Bool) becomes 0, with all obvious
breakage.  And finally, assignment of pointer to _Bool generates a warning
and cast.1 in linearizer.  Correct behaviour is (a) no warning whatsoever
and (b) replacement with b = (p != NULL).  The same thing applies in
passing arguments and in return statement, of course...

Oh, and type of comparison result is int, not _Bool...  It rarely matters,
but sometimes it does - e.g. sizeof(0 == 0) should evaluate to sizeof(int),
not sizeof(_Bool) (which basically casts the damn thing in stone - changing
the type of == result on valid C90 arguments would break existing programs).

I agree that use of bool_ctype in evaluate_compare() is very natural, but
we should at least take care interaction with sizeof ;-/
