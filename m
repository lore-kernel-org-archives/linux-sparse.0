From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: bitfields treatment
Date: Fri, 20 Mar 2009 21:37:27 +0000
Message-ID: <20090320213727.GJ28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35625 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCTVha (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Mar 2009 17:37:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LkmP9-0002N0-T0
	for linux-sparse@vger.kernel.org; Fri, 20 Mar 2009 21:37:27 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

	Aside of corner cases associated with signedness, there's another
fun pile we are handling strangely.  Namely, treatment of integer promotions
and conversions.

	What standard says:
* there's a well-defined behaviour for bitfields based on _Bool, signed int
and unsigned int (int-based is equivalent to one signed or unsigned).  We
get it right, AFAICS, and so does gcc.
* implementation can do bitfields based on other types.  Fair enough.  Both
sparse and gcc allow those for any integer types.
* standard wording is such that it does *NOT* have integer promotions applied
to such bitfields, even if the size is smaller than int.  Arguably, that's
a hole in standard; in any case, both gcc and sparse *do* integer promotions
on those, with the same behaviour as usual (value-preserving promotion).
* for all bitfields we are told that they act as (signed or unsigned)
integer types of specified width.  That has interesting implications:

unsigned long long f(unsigned long long n)
{
	struct {
		unsigned long long n:33;
	} x = {n};
	return x.n + x.n;
}

*must* be equivalent to (n + n) & 0x1ffffffff on all implementations that
allow such bitfields.  I.e. these suckers are not promoted to base type;
they act as if we really head 33bit unsigned type, usual conversions in
x.n + x.n left the result with that type and addition had been done within
that type.

gcc does it that way, we do not (x.n gets promoted to unsigned long long).

AFAICS, sparse is wrong here; nothing to do about that, C99 is really not
ambiguous in that area.  HOWEVER, that's not the end of story.  It's nice
to say "it's an integer type of this width"; however, it is really not enough.

	What happens when we mix two such suckers with the same width?
I.e. what about their ranks?  gcc seems to do the following: when the width
is equal to that of base type, treat the bitfield as equivalent to the
base type.  When the size is smaller, treat all bitfields with this width
and this signedness as belonging to the same type.  It leaves a corner case,
though - what if the width *is* equal to that of a smaller normal type?
It *is* possible even on amd64 - there's a 128bit integer type (can't get
to it for bitfield without typedef due to cretinous syntax, but
	typedef unsigned __attribute__((mode(TI))) T;
	....
	T x : 64;
will get it for you).  Apparently, that gets treated as equivalent of
the lowest-rank standard type with that size, i.e. unsigned long in case
of amd64.  Fsck knows how stable that assumption would be...  For now, it
seems that they are careful of having such types only with the widths that
do not overlap with those of standard types and having only one signed/unsigned
pair for given size.

	BTW, with typeof() we *can* get to some of those types.  We can't apply
typeof to bitfield, but we can say
	struct {unsigned long long x:33;} x;
	typedef typeof(+x.x) __u33;
and it will actually work as expected with gcc.  Can do pointers to them,
etc.  Can't get smaller-than-int ones, but that's not particulary interesting
due to integer promotions.  I really wonder how well would sparse cope with
that (allocation size > bit_size rounded to byte).
