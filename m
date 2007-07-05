From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Thu, 5 Jul 2007 14:03:16 +0200
Message-ID: <200707051403.16789.arnd@arndb.de>
References: <20070705093528.GK21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:49825 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbXGEMFD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Jul 2007 08:05:03 -0400
In-Reply-To: <20070705093528.GK21478@ftp.linux.org.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>

On Thursday 05 July 2007, Al Viro wrote:
> Frankly, I would rather add a new primitive (__qualifier__) mirroring=
 the
> __attribute__, but acting like real qualifiers do. =A0And switched th=
e
> noderef et.al. to it. =A0The only real alternative is to have __attri=
bute__
> behaviour dependent on its guts and that's not feasible - remember th=
at
> there can be more than one attribute in the list insider the damn thi=
ng.
> Besides, it's bloody disgusting.
>=20
> And yes, I realize that it's an incompatible change, i.e. not a step
> to be taken lightly. =A0Better ways out of that mess are more than
> welcome; I don't see any ;-/

Uli Weigand has put some work into making the 'Multiple Address
Spaces' feature of Embedded C work with gcc. We need that in order
to address the process address space from a program running on an SPU
on Cell, but it should syntactically be the same thing we need for
__user, __iomem, etc. I.e., iit follows the same rules as 'const'
and 'volatile' qualifiers.
AFAIK, the infrastructure for this is supposed to go into gcc-4.3,
but has not been posted publically yet. If you add something like
this to sparse, it would be good to keep it compatible with the
new gcc extension, so that gcc can do the right thing at some point
in the future for the kernel.

Uli, can you point us to any public code or specfication about the
multiple address spaces feature?

	Arnd <><
