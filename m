From: Al Viro <viro@ftp.linux.org.uk>
Subject: fun with ?:
Date: Sat, 19 May 2007 03:52:49 +0100
Message-ID: <20070519025249.GZ4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54019 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbXESCwv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 May 2007 22:52:51 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>

	There's an unpleasant case in conditional operator we are getting
wrong.
	int *p;
	const void *v;
	int n;

	n ? p : (const void *)0

According to C standard, the type of that expression is const void *.  Note
that
	n ? p : (void *)0
is an entirely different story - it's int *.

What's going on here is pretty simple: there are two degenerate cases of
conditional operator: pointer vs. null pointer constant and pointer vs.
possibly qualified pointer to void.  Look at these cases:
	n ? p : NULL => should be the same type as p
	n ? p : v => clearly const void * - pointer to void with union of
qualifiers; in this case we obviously lose any information about the type
of object being pointed to.

The tricky part comes from definition of what null pointer constant _is_.
C allows two variants - integer constant expression with value 0 (we accept
it, but warn about bad taste) and the same cast to void * (we also accept
that, of course).

Note that this is specific type - pointer to void.  Without any qualifiers.
We are guaranteed that we can convert it to any pointer type and get
a pointer distinct from address of any object.  So (const void *)0 is the same
thing as (const void *)(void *)0 and it is the null pointer to const void.
*HOWEVER*, it is not a null pointer constant.  The standard is clear here and
frankly, it's reasonable.  If you cast to anything other than void *, then
you presumably mean it and want the conversion rules as for any pointer
of that type.  Think of something like
#ifdef FOO
const void *f(int n);
#else
#define f(n) ((const void *)NULL)
#endif
You don't want to have types suddenly change under you depending on FOO.

sparse is more liberal than standard C in what it accepts as null pointer
constant.  It almost never matters; however, in case of conditional operator
we end up with a different type for an expression both sparse and any
C compiler will accept as valid.

I'm fixing other fun stuff in that area (e.g. we ought to take a union of
qualifiers, ought _not_ to mix different structs or unions, etc.), so
unless there are serious objections I'd rather go with standard behaviour
in that case.  What will change:

int n;
int *p;

n ? p : (const void *)NULL	int *	=>	const void *
n ? p : (const void *)0		ditto
n ? p : (char *)0		int *	=>	a warning on mixing int * with							char *
n ? p : (char *)NULL		ditto
n ? p : (void *)NULL		int *	=>	void *
n ? p : (void *)0		unchanged
n ? p : NULL			unchanged

Objections?
