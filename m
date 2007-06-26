From: Al Viro <viro@ftp.linux.org.uk>
Subject: problems with qualifiers on arrays
Date: Tue, 26 Jun 2007 03:19:37 +0100
Message-ID: <20070626021937.GH21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:50525 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbXFZCTi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jun 2007 22:19:38 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>

Consider the following example:

typedef int B[2][2];	// array of array of int
const B z;		// const array of array of int
int const (*r)[2] = z;	// pointer to array of const int

What we get in sparse is nasty:

B: SYM_NODE -> SYM_ARRAY -> SYM_ARRAY -> int_ctype
z: SYM_NODE[const] -> SYM_ARRAY -> SYM_ARRAY -> int_ctype
r: SYM_NODE -> SYM_PTR -> SYM_ARRAY[const] -> int_ctype

The trouble is, usual logics for finding qualifiers will happily stop
on SYM_PTR.  And so we get
a.c:3:21: warning: incorrect type in initializer (different modifiers)
a.c:3:21:    expected int const *[addressable] [toplevel] r[2]
a.c:3:21:    got int const [toplevel] *<noident>[2]

Of course, the code is 100% correct - qualified array of T is the same
type as array of qualified T, so the type of z is the same as array of
array of const int, which gets converted into pointer to array of const
int and initializer is fine.

The question is what to do with that mess.  We could switch all places that
look for qualifiers (and address_space) to proper loop (pick them from
node we are looking at, keep adding from deeper nodes as long as those
are SYM_ARRAY ones).  However, the PITA doesn't stop there.

The mess is created by typeof().  First of all, I'd fucked up back in '04
and switched to the wrong semantics in there; I _might_ have copied some
ancient version of gcc, or I might have fucked up, plain and simple.

Here's current (at least) gcc behaviour: typeof() keeps qualifiers.  I.e.
if we have const int *p, typeof(*p) will be const int.  We can (and probably
ought to) switch the handling of standard qualifiers to that behaviour.

However, it makes no sense whatsoever for noderef and address_space.
Think of it - we _can_ say
	typeof(*p) x = v;
	....
	use x
	....
even if *p is const; it's all right, since initializer is not an assignment.
We won't be able to modify x later on, but that's not fatal.  OTOH, if *p
is noderef (as it is e.g. for userland pointers), we won't be able to do
anything at all if x is noderef as well.  Worse, if we have address_space on
*p, we get absolutely bogus declaration - x is on stack, damnit, not in
user memory or iomem.   We _can't_ pass &x to something that expects such
pointers.

sparse strips *all* qualifiers - from the top level.  Which, again, is
implemented inconsistently wrt arrays.

So the question is, what do we do about that?  AFAICS, gcc semantics of
typeof is driven by two uses - one is about declaring variables in
polymorphic macros (and there stripping top-level qualifiers makes
perfect sense, even for traditional ones) and another is an atrocity
they've got for typeof(type) - things like #define pointer(T) typeof(T) *.
That, of course, wants to keep the damn things intact.

The thing is, we have places like put_user() where stripping address_space and
noderef is pretty much a must-have.  The typical use is
	typeof(*user_ptr) tmp = (v);			// conversions
	typeof(*user_ptr) __user *p = (user_ptr);	// local copy and
							//   decay
	assembler for copying tmp to userspace at address p

Note that we really, _really_ want the first assignment, regardless of
caring about multiple uses of argument in a macro.  We want proper
conversions.  We want v sign-expanded if *user_ptr is wider, etc.
And we sure as hell don't want a cascade of __builtin_choose_expr() by
something like __builtin_same_type_p().

I.e. I still think that we need stripping address_space and noderef.
If anybody has a saner approach, given the example above, I'd be
very greatful.  We _can_ rewrite such places in the kernel, there
are not too many of those.  I just don't see how to rewrite them
if we don't have a way to strip address_space and noderef...

Below is in assumption that we restore the C semantics wrt const et.al.
on typeof() and keep stripping address_space and noderef.  However,
if we e.g. introduce a new primitive specifically for stipping those
(and ifdef it away for !__CHECKER__), the text below still applies with
trivial modifications.

AFAICS, we need the following:
	* examine_base_type() should add the qualifiers from base type
if it's an array; that way we can avoid following the chains later on.
Question: what to do about context lists?
	* check the places where we look at qualifiers and address_space;
many are odd (in particular, type_difference() is doing very strange things)
	* examining SYM_TYPEOF should
		* convert SYM_TYPEOF to SYM_NODE
		* transfer ->ctype.modifiers of initializer (sans MOD_NODEREF)
		  into it (again, what about context list?)
		* discard SYM_NODE from initializer if present
		* if the top of initializer not SYM_ARRAY *or* if it has
		  neither noderef nor address_space - just make it the
		  base type of our node and be done with it.  That's
		  the normal case.
		* if we have a non-empty chain of SYM_ARRAY, follow it
		  down while we have qualifiers that need to be stripped,
		  creating a parallel chain of nodes without those qualifiers.
		  Attach it as base type of our node, attach the rest of
		  original to its bottom and be done with that.
	* AFAICS, our check for const target of assignment is broken; we
	  do not check for const subobjects.  New (internal) qualifier,
	  perhaps?  We could calculate it at type examination time easily
	  enough, but that would further complicate the rules for data
	  structures.  As it is, we have all qualifiers sitting in SYM_PTR,
	  (for pointer target), SYM_NODE and SYM_ARRAY (for type itself).
	  Here we would get new bit sitting on SYM_STRUCT and SYM_UNION
	  in addition to those (refering to type itself).  Any more elegant
	  suggestions?  We are bloody short on mod bits as it is...
	* in evaluate_cast() we need to be more accurate about finding address
	  space.  Not too hard...

Comments?  Linus, I'm afraid that you might be the only one who has a chance
to remember the entire area well enough ;-/  I'm trying to put together a
sane documentation of symbol.c and stuff around it, but...
