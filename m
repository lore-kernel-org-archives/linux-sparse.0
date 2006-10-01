From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCHSET] fouled-bitwise handling
Date: Sun, 01 Oct 2006 14:57:11 +0100
Message-ID: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:32684 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932191AbWJAN5J
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1od-0006tu-Oo
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:57:11 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


This stuff comes from handling smaller-than-int bitwise types (e.g. __le16).
The problem is in handling things like
	__be16 x, y;
	...
	if (x == (x & ~y))
The code is bitwise-clean, but current sparse can't deduce that.  Operations
allowed on bitwise types have the following property: (type)(x <op> y) can
be substituted for x <op> y in any expression other than sizeof.  That allows
us to ignore usual arithmetical conversions for those types and treat e.g.
| as __be16 x __be16 -> __be16, despite the promotion rules; resulting
semantics will be the same.  However, ~ on smaller-than-int does not have
such property; indeed, ~y is guaranteed to _not_ fit into range of __be16
in the example above.

That causes a lot of unpleasant problems when dealing with e.g. networking
code - IP checksums are 16bit and ~ is often used in their (re)calculations.
The way to deal with that is based on the observation that even though we do
get junk in upper bits, it normally ends up being discarded and sparse can
be taught to prove that.  To do that we need "fouled" conterparts for short
bitwise types.  They will be assigned to (sub)expressions that might carry
junk in upper bits, but trimming those bits would result in the value we'd
get if all operations had been done within the bitwise type.  E.g. in the
example above y would be __be16, ~y - fouled __be16, x & ~y - __be16 again
and x == (x & ~y) - boolean.

Basically, we delay reporting an error on ~<short bitwise> for as long as
possible in hope that taint will be cleansed later.

This patchset can be pulled from
git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git for-linus

shortlog:
Al Viro:
      casting null pointer constant to non-zero address space is always OK
      introduce classify_type(), use it in obvious places
      evaluate_compare() can just use evaluate_arith() for non-pointer cases
      beginning of SYM_RESTRICT rewrite: restricted_binop_type()
      merged compatible_..._binop() into single function
      saner recovery from endianness errors, part 1.
      handle fouled-bitwise

diffstat:
 evaluate.c                |  442 ++++++++++++++++++++++++++-------------------
 parse.c                   |    1 
 show-parse.c              |    8 +
 symbol.c                  |   38 ++++
 symbol.h                  |    5 +
 validation/foul-bitwise.c |   20 ++
 6 files changed, 324 insertions(+), 190 deletions(-)
 create mode 100644 validation/foul-bitwise.c
