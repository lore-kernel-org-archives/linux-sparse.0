From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Thu, 5 Feb 2009 20:28:11 +0000
Message-ID: <20090205202811.GO28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com> <20090203041317.GH28946@ZenIV.linux.org.uk> <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com> <498B3435.8010506@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51922 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZBEU2N (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 15:28:13 -0500
Content-Disposition: inline
In-Reply-To: <498B3435.8010506@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Thu, Feb 05, 2009 at 06:47:17PM +0000, Derek M Jones wrote:
> Christopher,
>
>> Right. I think currently sparse treat the subsequent declaration like a new
>> one. It check the type is compatible with previous declaration. But it does
>> not merge the previous declaration information.
>
> Sparse needs to generate composite types:
> http://c0x.coding-guidelines.com/6.2.7.html

Of course it does need that (and it's not C0X news, obviously).  We still
have the type handling messed up in a lot of areas, so the plan is to
sort out the declaration parsing, then get rid of the warts in type
representation and handling, then deal with composites.

IMO the right way to look at that crap is:
	* any declaration gives a new struct symbol, with type being the
composite of that given by declaration and that of previously seen one
(which, in turn, has gathered all earlier stuff)
	* type nodes should be treated as expressions, with on-demand
evaluation and referential transparency (i.e. any rewrite replaces with
equal).  We are not that far from such state.
	* composite type is built by unifying two trees, with evaluation
driven by comparisons.
	* we should _NOT_ do update-in-place from e.g. int[] to int[3] -
it's guaranteed to mess e.g. typedef handling, not to mention making the
VLA implementation hard as hell.  We are not referentially transparent
for e.g. struct expression and we'd paid a _lot_ for that.

Note that even check for type compatibility is fscked up for function
types - as it is, we treat void() and void(int) as incompatible types.
So yes, the composite type handling is certainly needed.  We also have
deeply fscked treatment of declarations, mostly thanks to fallout from
trying to be compatible with gcc in attribute handling ;-/

BTW, typedef treatment in declarators is also b0rken: witness sparse barfing on

typedef int T;
extern void f(int);
void g(int x)
{
        int (T);
        T = x;
        f(T);
}

which is a valid C (we have T redeclared in the function scope as int,
with declarator -> direct-declarator -> ( declarator ) -> ( identifier )
as derivation).  sparse mistakes int (T) for typename, does *NOT* notice
that typename has no business whatsoever being there and silently proceeds
to T = ..., without having redeclared T as object of type int.  It sees
typedef-name <something>, decides that it's a beginning of external-definition
and vomits on the following =.

IOW, the rule in direct_declarator() for distinguishing between function
and non-function is broken...
