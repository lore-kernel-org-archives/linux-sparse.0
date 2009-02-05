From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Thu, 5 Feb 2009 21:19:21 +0000
Message-ID: <20090205211921.GP28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com> <20090203041317.GH28946@ZenIV.linux.org.uk> <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com> <498B3435.8010506@knosof.co.uk> <20090205202811.GO28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42569 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbZBEVTX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 16:19:23 -0500
Content-Disposition: inline
In-Reply-To: <20090205202811.GO28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Thu, Feb 05, 2009 at 08:28:11PM +0000, Al Viro wrote:
> typedef int T;
> extern void f(int);
> void g(int x)
> {
>         int (T);
>         T = x;
>         f(T);
> }
> 
> which is a valid C (we have T redeclared in the function scope as int,
> with declarator -> direct-declarator -> ( declarator ) -> ( identifier )
> as derivation).  sparse mistakes int (T) for typename, does *NOT* notice
> that typename has no business whatsoever being there and silently proceeds
> to T = ..., without having redeclared T as object of type int.  It sees
> typedef-name <something>, decides that it's a beginning of external-definition
> and vomits on the following =.
> 
> IOW, the rule in direct_declarator() for distinguishing between function
> and non-function is broken...

PS: note that C grammar has an ambiguity, resolved in constraints (6.7.5.3p11).
We have 3 different cases:
	* typename
	* normal declaration
	* parameter declaration
In the first case, int (T) is "function that takes T and returns int"; we can
have no identifiers in nested abstract-declarator, so there's no problem.
In the second case, int (T) is "declare X as object of type int"; we can't
have parameter-type-list or identifier-list without having seen an identifier.
Again, no problem.  In the third case, though, we can have both
	parameter-declaration -> declaration-specifiers declarator
and
	parameter-declaration -> declaration-specifiers abstract-declarator
with the former going through
	direct-declarator -> ( declarator ) -> ( identifier )
and the latter -
	direct-abstract-declarator ->
	direct-abstract-declarator? ( parameter-type-list) ->
	( parameter-type-list ) -> ( identifier )

It is resolved by "an identifier that can be interpreted either as a typedef
name or as a parameter name shall be taken as a typedef name".

IOW, direct_declarator() (which doubles for direct-abstract-declarator) should
have more than one-bit indication of which case we've got.  Right now it's
done by "have we passed a non-NULL ident ** to store the identifier being
declared"; that's not enough.  What we need is explicit 'is that a part of
parameter declaration' flag; then the rule turns into
	if (p && *p)
		fn = 1; /* we'd seen identifier already, can't be nested */
	else if match_op(next, ')')
		fn = 1; /* empty list can't be direct-declarator or
			 * direct-abstract-declarator */
	else
		fn = (in_parameter && lookup_type(next));

We also need to barf on lack of identifier in definition, unless it
has no storage class specifiers and the type has been struct/union/enum,
straight from the input - not a typedef or typeof resolving to such, but
that's a separate story.
