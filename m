From: David Given <dg@cowlark.com>
Subject: Re: [PATCH 03/15] Add type information to struct instruction.
Date: Wed, 24 Dec 2008 23:01:37 +0000
Message-ID: <4952BF51.1040302@cowlark.com>
References: <20081215000849.16107.74332.stgit@zaytsev.su>	 <20081215002610.16107.25437.stgit@zaytsev.su>	 <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>	 <4950CA43.6090101@cowlark.com> <70318cbf0812231909i812a363s353d26572c8fddd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:33204 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYLXXBu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 18:01:50 -0500
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1LFcjc-0001WA-KU
	for linux-sparse@vger.kernel.org; Wed, 24 Dec 2008 23:01:48 +0000
Received: from [192.168.1.144] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id B26372011B
	for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 23:01:45 +0000 (GMT)
In-Reply-To: <70318cbf0812231909i812a363s353d26572c8fddd2@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher Li wrote:
[...]
> OK, if it is just for OP_LOAD. Will this attached patch solve your problem?
> 
> Instead of adding type to every instruction. It just add that for the OP_LOAD
> instruction in insn->orig_type. If that works for you. I am very glad to reclaim
> the space back on instruction structure.

Sorry, I'm not at home right now and can't test this (and probably won't
until New Year, though I'll have a go).

Also, I don't know if it *is* just of OP_LOAD. That's just the one I
remember from looking back at old email. I think the issue is that
OP_LOAD breaks the chain of pseudo->definer->pseudo->definer that I was
using to determine the intrinsic type of the pseudo, but there may be
other instructions that do this as well.

I'd imagine that nobody else has come across this yet because most
people are happy using the size to distinguish between different types;
but (assuming that I've remembered this correctly) this'll bite anyone
who needs to distinguish floats from int32s of doubles from int64s.

If space is really an issue, would it make sense therefore to replace
the insn->size (and symbol->size etc) field with a ->type field pointing
at the defining symbol for the type? Anyone who needs the type can get
it from the defining symbol, plus all the other information that people
like me need would be available, and may also simplify other code. (I
could throw away a complete source file!)

> I think sparse should do the proper cast for you when you call
> the function call. If it does not, that is a bug and we can fix it.

Okay, at some point I'll try to come up with a proper use case.

- --
David Given
dg@cowlark.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJUr9Mf9E0noFvlzgRAmWCAJ4+Q+XPPn9stf8TWHUiIrAk3kwcTACgtJbd
mVD5E9Cg6a2tOtiTI34Mcz8=
=FrsN
-----END PGP SIGNATURE-----
