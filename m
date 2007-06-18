From: Al Viro <viro@ftp.linux.org.uk>
Subject: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 11:19:29 +0100
Message-ID: <20070618101929.GE21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55762 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760127AbXFRKTb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 06:19:31 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>

	Current tree handling of initializers is rather incomplete
and in many cases broken.  Patchset rewrites that stuff pretty much
from scratch; AFAICS it works.

Fixed:
	* proper walking into subobjects, with warnings about missing
braces.  Current tree doesn't handle that and in the best case we
get a warning when initializer hits the wrong subobject and gets a type
mismatch; in the worst case we get nothing.
	* excess of initializer list elements is reported
	* unnamed bitfields are skipped as the should be; the current tree
doesn't do that
	* fixed handling of string literals; current tree is inconsistent
in that area, especially when they come from inlined functions
(evaluate_expression() changes expr->type, so it's not recognized as string
literal the next time aroung).
	* fixed handling of struct/union assignment-style initializers.
	* fixed handling of gccisms (unnamed union as a member, empty struct
as a member) to match gcc behaviour; gcc extension allowing ("a") to be
treated as "a" is handled, with a warning conditional on -Wparen-string
(default is off).  BTW, several places in the kernel have that sort of
idiocy.

Areas still missing:
	* wide string literals.  We don't support wide char anyway, so...
	* expand doesn't care for order of initializers.  For overlapping
ones that becomes a problem, especially when mixed with gcc range
designators (e.g. [20 ... 100] = {1, 2}, [0 ... 30].a = 15, [49] = {15, 20})
	* expand still leaves EXPR_POS -> EXPR_POS -> EXPR_VALUE for
[0 ... 1][0] = 1, which makes compile-i386.c rather unhappy (segfaults).
While we are at it, compile-i386.c apparently is unaware of range designators
at all - it ignores the count.  Probably best fixed in compile-i386.c...
	* calculation of array size by initializer is still broken; at least
now we get warnings about missing braces in the cases that trigger that
crap; struct {int a, b;} a[] = {1,2,3,4,5}; should give a 3-element array,
not 5-element one.  New code warns about missing braces and puts the values
in right places, but it still doesn't fix the array size calculation - it's
done too early.  Since evaluate_initializer() can work with array of
unknown size, perhaps the best solution would be to call it from the
count_array_initializer() and look for maximal index in the results if
we have EXPR_INITIALIZER / look for string size otherwise (no other
variants are possible for arrays).  Objections?

Have fun...  The tree is in branch 'initializers' of
git://git.kernel.org//pub/scm/linux/kernel/git/viro/sparse/

Al Viro (4):
      make copying of EXPR_INDEX non-lazy
      tie the fields of struct in simple list
      rewrite of initializer handling
      fix handling of typeof on structs

 evaluate.c   |  569 ++++++++++++++++++++++++++++++++++++++++------------------
 expression.h |    1 +
 inline.c     |    2 -
 lib.c        |    2 +
 lib.h        |    1 +
 parse.c      |   20 ++-
 symbol.c     |    7 +-
 symbol.h     |    6 +-
 8 files changed, 428 insertions(+), 180 deletions(-)
