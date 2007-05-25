From: Al Viro <viro@ftp.linux.org.uk>
Subject: pointer arithmetics and casts
Date: Fri, 25 May 2007 22:23:00 +0100
Message-ID: <20070525212300.GL4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39031 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761664AbXEYVXB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 17:23:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrhFU-00036q-L7
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 22:23:00 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

	Looking through the old problems: pointer addition is not done
right.  What happens is simple - p + i turns into

	BINOP[+]
		<tree for p>
		BINOP[*]
			<tree for i>
			VAL[sizeof(*p)]

and we end up multiplying i and sizeof(*p) in wrong type.  On 64bit host
we _must_ expand i to 64 bits before we multiply; otherwise we get
wraparounds.

The question is, what do we do about that?  The obvious way would be
to do cast_to(), i.e. turn the above into

	BINOP[+]
		<tree for p>
		BINOP[*]
			IMPLICIEDT_CAST[ptrdiff_t]
				<tree for i>
			VAL[sizeof(*p)]

But that means a fsckload of extra nodes allocated on pretty much any
program - use of arrays is not rare and indices tend to be int, so we
hit an extra allocated node on each such place.

Another possible solution is to add a primitive for combined conversion
and multiplication - basically, convert the first argument to the type of
the second one and multiply.  We would actually need it only for ptrdiff_t;
sizeof(*p) is going to fit into the range anyway (it has to - the difference
between (char *)(p+1) and (char *)p must fit into it, or we couldn't do any
arithmetics on that pointer type at all; as soon as product overflows
ptrdiff_t we are free to do whatever the hell we like, since that's an
undefined behaviour and "multiply as ptrdiff_t values" gives an reasonable
result even in such cases).

That would cut down on extra nodes, but we pay for that by getting an
extra node type for linearizer, etc. to deal with.  Not sure how nasty
that's going to be...

Comments?
