From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Sun, 3 Jun 2007 02:05:34 +0100
Message-ID: <20070603010534.GV4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <465392E3.3000300@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60298 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbXFCBFg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Jun 2007 21:05:36 -0400
Content-Disposition: inline
In-Reply-To: <465392E3.3000300@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, May 22, 2007 at 06:03:31PM -0700, Josh Triplett wrote:
> > Usual sparse constant folding is _almost_ OK, provided that we play a bit
> > with evaluate_expression() and let it decide if subexpression is an integer
> > constant expression.  No prototype changes, we just get a global flag
> > and save/restore it around sizeof argument handling and several other
> > places.  It's actually pretty easy.  And if we get "it is an integer
> > constant expression", well, then caller can call expand stuff.
> 
> Sounds reasonable to me.  Possibly better written as some kind of generic
> parse-tree-walking operation, but this approach should work fine.

Hrm...  Actually, "global flag" approach doesn't work at all, since we
mishandle already-evaluated subtrees (happens with inlined functions).

AFAICS, here's what we can do with relatively little PITA:

	Split some of the EXPR_... cases in two; additional variant
would differ by | EXPR_INT_CONST, which would be 1U<<31 (let's call it
i-bit).  EXPR_CAST gets split in three - normal, EXPR_CAST with i-bit
and EXPR_CAST with f-bit (1U<<30).

At parse time, do the following:
	* EXPR_VALUE, EXPR_TYPE, EXPR_SIZEOF, EXPR_PTRSIZEOF and EXPR_ALIGNOF
get i-bit.
	* EXPR_COMPARE, EXPR_BINOP, EXPR_LOGICAL, EXPR_CONDITIONAL,
EXPR_PREOP with !, + , -, ~ or ( and EXPR_CAST get i-bit if all their
arguments have it.
	* EXPR_CAST also gets both i- and f-bit if its argument is EXPR_FVALUE,
possibly wrapped into some EXPR_PREOP[(].

That won't really complicate the parser.  Now, at that point i-bit
is weaker than "subexpression is an integer constant expression", but not
by much - the only things we are missing are "it typechecks OK" and "all
casts are to integer types" (note that sizeof(VLA) would have to be caught
when we start handling those; as it is, it fails typechecking, plain and
simple).

So what we do at evaluate_expression() is simple - we remove some i-bits.
Rules:
	* EXPR_COMPARE, EXPR_BINOP, EXPR_LOGICAL, EXPR_CONDITIONAL, EXPR_PREOP:
lose i-bit if some argument doesn't have it after evaluation.
	* EXPR_IMPLIED_CAST to an integer type inherits i-bit from argument.
	* EXPR_CAST loses i-bit if the type we are casting to is not an
integer one; it also loses i-bit if evaluated argument doesn't have i-bit
*and* EXPR_CAST itself doesn't have f-bit.
	* in cannibalizing EXPR_PREOP in &*p and *&p simplifications,
keep the (lack of) i-bit and f-bit on the overwritten node.

In expand_expression() we keep i-bit through the replacement.

That's it.  Now, "has i-bit after evaluate_expression()" == "expression
is an integer constant one".

Now, we do the following:
	* static struct symbol null_ctype, initialized to SYM_PTR over
void.
	* evaluation of EXPR_CAST with target type being a pointer to void
and argument bearing an i-bit should check if argument is in fact 0; if
it is, replace the node with EXPR_VALUE[0] and &null_ctype as type.
	* int is_null_pointer_constant(expr) - return 1 if type is &null_ctype,
2 if argument bears i-bit and is in fact 0, return 0 otherwise.
	* have degenerate() turn &null_ctype into a normal pointer to void
	* callers of degenerate() in contexts where we care about null
pointer constants (?:, assignment, argument of function call, pointer
comparison, cast) should do is_null_pointer_constant() first.  Act accordingly,
warn if it had returned 2.  Note that we can't blindly generate a warning
in is_null_pointer_constant() - sometimes 0 is simply 0 and we don't want it
to become a pointer at all, let alone generate any warnings.

AFAICS, that will do the right thing with little pain.  I'm not all that
happy about splitting EXPR_... (in effect, stealing bit from expr->type);
perhaps reducing the size of expr->type and adding expr->flags would be
better.  Hell knows...

Comments?
