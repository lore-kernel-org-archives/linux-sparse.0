From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: pointer arithmetics and casts
Date: Sat, 26 May 2007 12:44:09 +0900
Message-ID: <20070526034409.GO2547@daikokuya.co.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7510 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752021AbXEZDnZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 23:43:25 -0400
Content-Disposition: inline
In-Reply-To: <20070525212300.GL4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

Al Viro wrote:-

> But that means a fsckload of extra nodes allocated on pretty much any
> program - use of arrays is not rare and indices tend to be int, so we
> hit an extra allocated node on each such place.
> 
> Another possible solution is to add a primitive for combined conversion
> and multiplication - basically, convert the first argument to the type of
> the second one and multiply.  We would actually need it only for ptrdiff_t;
> sizeof(*p) is going to fit into the range anyway (it has to - the difference
> between (char *)(p+1) and (char *)p must fit into it, or we couldn't do any
> arithmetics on that pointer type at all; as soon as product overflows
> ptrdiff_t we are free to do whatever the hell we like, since that's an
> undefined behaviour and "multiply as ptrdiff_t values" gives an reasonable
> result even in such cases).

Perhaps not overloading the "+" node; reserve that for arithmetic types.
Have a ptr_add, (maybe) ptr_sub, and ptr_diff operations.

GCC's moved to having at least a ptr_add recently.

Neil.
