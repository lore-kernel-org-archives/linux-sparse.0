From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Fri, 6 Jul 2007 08:48:03 +0100
Message-ID: <20070706074803.GV21478@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55301 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbXGFHsH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 03:48:07 -0400
Content-Disposition: inline
In-Reply-To: <1183661456.2604.43.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 05, 2007 at 11:50:56AM -0700, Josh Triplett wrote:
 
> No, I mean __attribute__((context(...))), which means something
> different.  __context__() works as a statement statement changing the
> context.  __attribute__((context(...))) works as an attribute modifying
> a type to say that it requires a given context, and that
> accessing/calling it changes the context.  Somewhat of an odd
> distinction, but sparse currently works that way.
 
That's actually not a qualifier from the syntax point of view...
It makes sense *only* on function types - we simply ignore it
on anything else.  And C syntax doesn't allow qualifiers on functions -
not without creative use of typedef (which gets you in nasal demon
country - undefined behaviour).

What syntax do we want?  Note that the *only* possible way to get
it kinda-sorta like qualifiers is by
typedef int F(void);
F __attribute__((context(x,0,1))) f;
with no way to actually define the sucker, since for function
definition you can't use such tricks.  IOW, no matter what we do,
it won't look like standard C.

If anything, it ought to be an analog of noreturn/pure/fastcall/etc. - same
kind of property should use the same syntax; no need to add confusion.
Unfortunately, gcc does _not_ give a sane way to declare pointers to
such beasts.  To quote gcc info:

|                        ...  At present, such attribute specifiers apply
|to the declared object or function, but in future they may attach to the
|outermost adjacent declarator.  In simple cases there is no difference,
|but, for example, in
|
|     void (****f)(void) __attribute__((noreturn));
|
|at present the `noreturn' attribute applies to `f', which causes a
|warning since `f' is not a function, but in future it may apply to the
|function `****f'.  The precise semantics of what attributes in such
|cases will apply to are not yet specified.

	Frankly, my preference would be to have that kind of attributes
follow ( parameter-type-list ), ( identifier-list ) or ( ) in productions
for direct-declarator.  That would allow uses like

int foo(void) ATTR;             // function with attribute
int foo(void) ATTR {....}       // function with attribute
int (*foo)(void) ATTR;          // pointer to function with attribute
int (*bar(int) ATTR)(void) {...}// function with attribute returning pointer to
                                // normal function
int (*bar(int))(void) ATTR {...}// normal function returning a pointer to
                                // function with attribute
AFAICS, that doesn't lead to any problems with parser - no deep lookahead,
etc.  Allowing them in declaration-specifiers, OTOH...

	Do we want to allow
__attribute__((context(x,0,1))) int foo(void) {....}
int (__attribute__((context(x,0,1))) *foo)(void);
and similar uses?  I'd rather prohibit that...

	Another fun question: how do we compare these suckers?  Suppose
you have foo() and bar() having some kind of contexts.  What contexts
do we put into n ? foo : bar and when do we allow that?  Similar question
for p = foo; where p is a pointer to function, etc.  I realize that the
first argument of __attribute__((context(...,...,...))) is currently ignored
and pretty much hopeless as defined, but...
