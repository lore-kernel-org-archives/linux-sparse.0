From: David Given <dg@cowlark.com>
Subject: Re: [PATCH 03/15] Add type information to struct instruction.
Date: Tue, 23 Dec 2008 11:23:47 +0000
Message-ID: <4950CA43.6090101@cowlark.com>
References: <20081215000849.16107.74332.stgit@zaytsev.su>	 <20081215002610.16107.25437.stgit@zaytsev.su> <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:59021 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYLWLXz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 06:23:55 -0500
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1LF5Mf-0004ai-4C
	for linux-sparse@vger.kernel.org; Tue, 23 Dec 2008 11:23:53 +0000
Received: from [10.0.1.71] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 64709205C1
	for <linux-sparse@vger.kernel.org>; Tue, 23 Dec 2008 11:23:50 +0000 (GMT)
In-Reply-To: <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher Li wrote:
[...]
> I think what David need is just distinction of int vs pointer.

Actually, I need to distinguish between ints, doubles, object pointers,
function pointers, structures/arrays and void; the code for doing this
is currently a pretty nasty set of heuristics, which is here if you're
interested:

http://cluecc.svn.sourceforge.net/viewvc/cluecc/clue/src/clue/typestore.c?revision=45&view=markup

I'm sure there's a better way of doing it, but I just couldn't find one!
So if you can think of any way to clean all this up I'd be delighted.
The underlying issue, BTW, is that OP_LOAD doesn't carry enough
information in its arguments to determine the type of the instruction.

Incidentally, speaking of distinguishing arguments, one of the issues I
have with Clue is that sparse can't distinguish between parameters of
the different types but the same size in some situations --- e.g.:

extern void foo(float i);
...
foo(5);

...will call foo() with an *integer* parameter rather than a float one.
This is preventing me doing certain optimisations (like being able to
store ints in ints rather than doubles!). Is this related?

(I vaguely recall mentioning this before, but can't find my message...
is there a bug tracker for sparse?)

- --
David Given
dg@cowlark.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJUMo+f9E0noFvlzgRAqy/AJ40DRC4Cgzjml50KMw+Bk9i/hRcXwCdH0sK
2SSrZI19MCnrOhjcy9kYUbI=
=NywA
-----END PGP SIGNATURE-----
