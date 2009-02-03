From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: fun with declarations and definitions
Date: Tue, 3 Feb 2009 04:13:17 +0000
Message-ID: <20090203041317.GH28946@ZenIV.linux.org.uk>
References: <20090202073018.GB28946@ZenIV.linux.org.uk> <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37285 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbZBCENS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 23:13:18 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 02, 2009 at 07:07:24PM -0800, Christopher Li wrote:
> On Sun, Feb 1, 2009 at 11:30 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Anyway, proposed patch for (1) follows:
> 
> I read the patch, seems reasonable. It is only solve the inline case though.
> The more generic problem still exist, symbol look up between partial
> prototype declare and the real declare will get symbol with partial
> information.

... and unfortunately, that's what we _have_ to do.  Reason: behaviour
of typeof().  Example:

extern int a[];
int a[__builtin_types_compatible_p(typeof(a),int [3]) + 3];	/* 4 */
int b[__builtin_types_compatible_p(typeof(a),int [3]) + 3];	/* 3 */

Similar for
extern int a[];		/* a is int [] */
typedef typeof(a) A;	/* A is int []  _AND_ _WILL_ _REMAIN_ _SO_ */
int a[10];		/* a is int [10] now */
A b;			/* int [] */
int b[1];		/* no problem */

Similar applies for functions getting pointers to functions, etc. - having
the type refined by subsequent declaration is not retroactive.

Mind you, we are not doing composite types in any useful way and _that_ is
where we ought to change things.  Subsequent declarations should pick
the additional type information; we do propagate the inline definition
back to the call sites, provided that we had the function declared inline
before those.  However, the type information should _not_ be spread back.

And it's not just due to typeof (I suspect that honest attempt to define
its semantics in presense of back-propagation like that will end up to
be Turing-complete, but even if it is decidable it's prohibitively hard).
Note that we do have similar effects in standard C - e.g.

extern int a[];
void f(void)
{
	extern int a[24];
	memset(a, 0, sizeof(a)); /* OK */
}
void g(void)
{
	memset(a, 0, sizeof(a)); /* error - sizeof(a) is hidden from us here */
}

doesn't involve any extensions and having it barf on the second memset call
there is certainly intended behaviour.
