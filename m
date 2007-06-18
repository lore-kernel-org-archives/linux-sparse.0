From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 20:16:54 +0100
Message-ID: <20070618191653.GG21478@ftp.linux.org.uk>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54779 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762714AbXFRTQz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 15:16:55 -0400
Content-Disposition: inline
In-Reply-To: <4676CC9C.3050903@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jun 18, 2007 at 11:19:08AM -0700, Josh Triplett wrote:
> How much spew does -Wparen-string cause?  If you feel that it always
> represents an error, or at least sloppy code, and that it won't drown people
> in warnings, I have no problem with turning it on by default.  Your call.

Depends on a project.  In case of kernel it's mostly a spew in s2io.c
around
static char ethtool_driver_stats_keys[][ETH_GSTRING_LEN] = {
        {"\n DRIVER STATISTICS"},
        {"single_bit_ecc_errs"},
        {"double_bit_ecc_errs"},
        {"parity_err_cnt"},
        {"serious_err_cnt"},
        {"soft_reset_cnt"},
        {"fifo_full_cnt"},
        {"ring_full_cnt"},
        ("alarm_transceiver_temp_high"),
        ("alarm_transceiver_temp_low"),
        ("alarm_laser_bias_current_high"),
        ("alarm_laser_bias_current_low"),
        ("alarm_laser_output_power_high"),
....

Mind you, both braces and parentheses are redundant here, but the latter
happen to be invalid C as well (and we want at least consistency anyway).

Other projects may differ.  IOW, I'd probably keep it optional.
 
> > Areas still missing:
> [...]
> > 	* calculation of array size by initializer is still broken; at least
> > now we get warnings about missing braces in the cases that trigger that
> > crap; struct {int a, b;} a[] = {1,2,3,4,5}; should give a 3-element array,
> > not 5-element one.  New code warns about missing braces and puts the values
> > in right places, but it still doesn't fix the array size calculation - it's
> > done too early.  Since evaluate_initializer() can work with array of
> > unknown size, perhaps the best solution would be to call it from the
> > count_array_initializer() and look for maximal index in the results if
> > we have EXPR_INITIALIZER / look for string size otherwise (no other
> > variants are possible for arrays).  Objections?
> 
> That seems like a great approach to me; logically, an initializer should
> expand an array of unspecified size to hold elements up to its maximum index.

That's what count_array_initializer() is trying to do, but the trouble is
that it doesn't notice that some list elements may end up initializing
parts of the same array member.  IOW, it tries to do the right thing,
but to do it correctly you need to look at more than just "this has
explicit designator, this doesn't".

I'm not sure that I understand the details of type examination in symbol.c
enough to say whether we'd break anything by doing it that way, though.
The question is how much of the laziness would be destroyed by that.
Linus?

> Hopefully this would also fix the problem reported by Michael Stefaniuc in
> <466489FD.7010405@redhat.com>:
> > Running sparse on
> >         int i = sizeof((const char []) {'a','a','a',0});
> > gives
> >         zzz.c:1:9: error: cannot size expression

Umm...  I don't think that it's related.  count_array_initializer() would
work just fine for that one, since the straightforward list element counting
would work as-is.

Aha... I see what's going on - in evaluate_cast() we examine the type before
associating it with initializer, so when we get around to evaluate_symbol()
a bit later in the same function, it's too late - ->examined is already
set.  I wonder if moving that examine_symbol_type() downstream (and killing
it in EXPR_INITIALIZER branch) would be enough...  Looks like it should
work, but I might be missing something here.

How does something like diff below look to you, folks?  It gets the
testcase to produce expected result (and puts the right value into
i); I'm running it on the kernel cross-builds right now, but that
doesn't guarantee correctness, of course.

diff --git a/evaluate.c b/evaluate.c
index c564ad9..6da8f3e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2416,7 +2416,7 @@ out:
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *target = expr->cast_expression;
-	struct symbol *ctype = examine_symbol_type(expr->cast_type);
+	struct symbol *ctype;
 	struct symbol *t1, *t2;
 	int class1, class2;
 	int as1, as2;
@@ -2424,9 +2424,6 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	if (!target)
 		return NULL;
 
-	expr->ctype = ctype;
-	expr->cast_type = ctype;
-
 	/*
 	 * Special case: a cast can be followed by an
 	 * initializer, in which case we need to pass
@@ -2441,7 +2438,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		struct symbol *sym = expr->cast_type;
 		struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
 
-		sym->initializer = expr->cast_expression;
+		sym->initializer = target;
 		evaluate_symbol(sym);
 
 		addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
@@ -2455,6 +2452,10 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		return sym;
 	}
 
+	ctype = examine_symbol_type(expr->cast_type);
+	expr->ctype = ctype;
+	expr->cast_type = ctype;
+
 	evaluate_expression(target);
 	degenerate(target);
 
