From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC] explicitly signed and friends
Date: Mon, 2 Jul 2007 21:30:08 +0100
Message-ID: <20070702203008.GH21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49863 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbXGBUaJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jul 2007 16:30:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I5SXA-0007m7-Ns
	for linux-sparse@vger.kernel.org; Mon, 02 Jul 2007 21:30:08 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

	Observations:
1)
	signed int x;
	typedef typeof(x) A;
	struct {
		A x:2;
	};
and
	typedef signed int A;
	struct {
		A x:2;
	};
give different results; the latter is explicitly signed, the former isn't.

2)
	typedef typeof(signed int) A;
	struct {
		A x:2;
	};
doesn't give explicitly signed.

IOW, it looks like gcc turns signed int/long/long long into corresponding
types in all contexts other than bitfield declaration and typedef.  I.e.
it's dealt with in declaration parser; for typedef and bitfield it becomes
a flag of symbol, not a part of type.

3)
In ?: we _can't_ ignore the difference between int * and unsigned *; after
all, in *(n ? p : q) < 0 we want to know whether we get pointer to signed
or pointer to unsigned out of ?:.  IOW, in that context sparse should
scream bloody murder, -Wtypesign or not.  FWIW, gcc recovers in that
case with converting both arguments to void *; as long as we only care
about the address it's OK, but we've lost all information about the
type of object sitting there.

4)
gcc is kinda-sorta tolerant to mixing pointers to signed and unsigned,
unless you explicitly ask to be strict.  However, it's nowhere near
as lenient as sparse.
	* pointer comparison warns, even in absense of any -W...
	* only assignment and equivalents (passing argument, return,
initializer) remains silent and only when we mix pointer to unsigned
with pointer to signed variant of the same.
	* pointer to function returning signed and poitner to function
returning unsigned do not mix (i.e. you always get a warning).
	* pointer to pointer to signed doesn't mix with pointer to pointer
to unsigned.
	* pointer to function with pointer to signed as argument doesn't
mix with pointer to function with pointer to unsigned as argument.
IOW, this stuff should be special-cased in compatible_assignment_types(),
not in type_difference().
	* pointer subtraction even between unsigned * and int * is
a flat-out error.  Even for char *, signed char * and unsigned char *,
in any combination.

It makes sense, actually; being lenient about passing arguments is one
thing, but when it comes to things like pointer subtraction all reasons
for that kind of forgiveness disappear.

IMO we should
	a) get rid of sint_ctype and friends.
	b) when we find MOD_EXPLICITLY_SIGNED in declaration, check
that it's typedef or bitfield and that we have no pointer/array/function
declarators in there.  For typedef set it in resulting SYM_NODE
modifiers, for bitfield use it in choosing MOD_SIGNED or MOD_UNSIGNED.
Normal logics for declaration parsing will have it picked from typedef
to typedef and from typedef to bitfield.
	c) unroll one level of type_difference() for pointers in
compatible_assignment_types().  We need special handling of null pointer
constants and void * there anyway; might as well do handling of !Wtypesign
in there.  type_difference() would be called for base types.

After that we can get rid of most of the odd logics in type_difference(),
so there's even a chance to get __builtin_same_type_p() working correctly...

Comments?
