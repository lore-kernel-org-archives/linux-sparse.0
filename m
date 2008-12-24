From: David Given <dg@cowlark.com>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Wed, 24 Dec 2008 21:59:09 +0000
Message-ID: <4952B0AD.7040007@cowlark.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>	 <20081218223216.23692.711.stgit@zaytsev.su>	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>	 <4950A8A2.5090702@knosof.co.uk>	 <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>	 <495181C0.7070803@knosof.co.uk> <f19298770812231839n1aaaf84fla96dda04b11e0944@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:45710 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbYLXV73 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 16:59:29 -0500
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1LFblH-0006kh-7q
	for linux-sparse@vger.kernel.org; Wed, 24 Dec 2008 21:59:27 +0000
Received: from [192.168.1.144] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id A45B12011B
	for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 21:59:24 +0000 (GMT)
In-Reply-To: <f19298770812231839n1aaaf84fla96dda04b11e0944@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alexey Zaytsev wrote:
[...]
> So far the only concern with void* is that not everyone knows
> the it is sizeof 1. So if you propose repulsing void* with char*
> when we don't really need a void*, that's probably fine. But don't
> you think there are more useful ways to spend your time?
> With open issues like the Global Warming, World Hunger and
> standing 2.6.28 regressions, I don't see anyone bothered with
> repacing unnecessary void* casts.

The thing is, sizeof(void) is *not* 1. sizeof(void) is *illegal*. It
just happens that gcc, as a platform-specific extension, treats
sizeof(void) as 1 by default.

As a linter, sparse really ought not to be encouraging non-portable
behaviour. Admittedly, there's so much stuff in the kernel source that's
gcc-specific that it's probably not going to be possible to make it
build on anything else, but it should still warn people about it unless
specifically told otherwise --- it's bad practice, and may be indicative
of further problems elsewhere, and as such is worth a diagnostic.

- --
David Given
dg@cowlark.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJUrCmf9E0noFvlzgRAkRCAJwPffkuAuAMxfJJSkh+H7AlIPHQkQCgtGRQ
0t71dcB7ZaIKud6Qi5XXrx8=
=83ss
-----END PGP SIGNATURE-----
