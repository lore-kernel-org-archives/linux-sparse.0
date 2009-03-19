From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC] potential DR in handling of signed int and unholy mess in
	our and gcc implementations
Date: Thu, 19 Mar 2009 01:33:58 +0000
Message-ID: <20090319013358.GZ28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34505 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbZCSBeA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Mar 2009 21:34:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1Lk78w-00071w-GZ
	for linux-sparse@vger.kernel.org; Thu, 19 Mar 2009 01:33:58 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

	First of all, C99 has rather unpleasant inconsistency between
6.7.2p5 and footnote in 6.7.2.1p9.  According to the former,
	typedef int T;
	struct {
		T x : 2;
	} y;
is equivalent to
	typedef signed int T;
	struct {
		T x : 2;
	} y;
and in both y.x must be signed.  Indeed, since the first declaration does
not declare a bitfield, int and signed int designate the same type in
it, per 6.7.2p5.

However, the footnote in 6.7.2.1p9 says
  "As specified in 6.7.2 above, if the actual type specifier
   used is int or a typedef-name defined as int, then it is
   implementation-defined whether the bit-field is signed or unsigned."

According to that, y.x in the second case is signed, but in the first one
it's implementation-defined whether it's signed or unsigned.

But 6.7.2 specifies no such thing!  The only place in there that speaks of
bit-fields is 6.7.2p5, which says
  "Each of the comma-separated sets designates the same type, except
   that for bit-fields, it is implementation-defined whether the specifier
   int designates the same type as signed int or the same type as unsigned
   int."
and there's no mentioning whatsoever of typedef-name in such context.

Note that it's not like the situation with char; plain char *IS* a separate
type, distinct from signed char and unsigned char alike.  There's no such
type in case of int; C99 is very clear on that one.  IOW, "explicit signedness"
for int is a property of declaration-specifiers interpretation, not of a type.

The only question is whether this property applies to bitfield declarations
alone (as 6.7.2p5 says) or it applies to typedef-name as well (as the footnote
in 6.7.2.1p9 says, with reference to hell knows what in 6.7.2).

FWIW, gcc follows 6.7.2.1p9 footnote.  It looks if we had 'signed' specifier
or a typedef-name marked explicitly signed; if either happens in typedef
declaration, gcc marks the new typedef-name as explicitly signed; if we
have a bitfield declaration that would result in a signed type *and* if
there's no explicitly signed specifiers in the mix *and* if the target
has unsigned bitfields, the type is replaced with unsigned counterpart.

Note that gcc typeof is *NOT* treated as explicitly signed, no matter what
it resolves to.  IOW, even
	typeof(signed int) x:2;
is treated as
	int x:2;
and if -funsigned-bitfields is present, unsigned it becomes.  How much of
that behaviour is going to remain stable?  No idea.

sparse walks even deeper into that shitpile; we really treat signed int
and int as different types.  Results are not pretty - for stuff like
	signed int *p;
	typeof(*p) .....
we get signed int, for stuff like
	typeof(signed_int_var + 1) .....
et.al. we get either int or signed int, depending on phase of the moon.
Leads to no end of fun in compatible types recognition, etc.

IMO it's a very real DR fodder; either the footnote in 6.7.2.1p9 should be
modified, dropping mentioning of typedef-name (and then e.g. gcc becomes
non-compliant) or 6.7.2 ought to grow some mentioning of 'typedef-name
defined as int' (probably in 6.7.2p5).

I'll probably go for gcc-like behaviour in sparse for now, unless somebody
sees a good reason not to.  At least that one is consistent and doesn't
bring the shitloads of fun questions about behaviour of arithmetic conversions,
etc.

Comments?
