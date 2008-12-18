From: David Given <dg@cowlark.com>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Thu, 18 Dec 2008 17:12:34 +0000
Message-ID: <494A8482.7030801@cowlark.com>
References: <20081217190534.24084.94887.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from b.painless.aaisp.net.uk ([81.187.30.52]:55793 "EHLO
	b.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbYLRRMo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 12:12:44 -0500
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by b.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1LDMQU-0003O6-5j
	for linux-sparse@vger.kernel.org; Thu, 18 Dec 2008 17:12:42 +0000
Received: from [10.0.1.71] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 6535913B3C
	for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 17:12:39 +0000 (GMT)
In-Reply-To: <20081217190534.24084.94887.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alexey Zaytsev wrote:
> From: David Given <dg@cowlark.com>
[...]
> Anyway, here is the updated byte size patch.
> David, we still need your sign-off here.
[...]
> diff --git a/compile-i386.c b/compile-i386.c
[...snipped for brevity, you already have the patch...]

Okay:

Signed-off-by: David Given <dg@cowlark.com>

FWIW, I also hereby declare my work in this patch to be in the public
domain, which means you can do what you like with it, including
relicensing it at a future date. Just in case anyone decides to try and
persue a sparse license change.

- --
David Given
dg@cowlark.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklKhIEACgkQf9E0noFvlzjSxwCgzwIVOjhr7Nu+eccIwR1susN8
+TMAoJujE7dAZgAoPSmtlcfYMeq7QE9T
=iKFi
-----END PGP SIGNATURE-----
