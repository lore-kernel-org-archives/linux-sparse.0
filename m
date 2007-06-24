From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Sun, 24 Jun 2007 20:07:10 +0200
Message-ID: <200706242007.10585.arnd@arndb.de>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:55567 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbXFXSJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 14:09:44 -0400
In-Reply-To: <20070624174732.GZ21478@ftp.linux.org.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sunday 24 June 2007, Al Viro wrote:
> but the latter... =A0Probably ought to be
> #define _IOC_TYPECHECK(t) \
> =A0 =A0 =A0 =A0 (sizeof(t) + BUILD_BUG_ON_ZERO(sizeof(t) =3D=3D sizeo=
f(t[1]) && \
> =A0 =A0 =A0 =A0 =A0 sizeof(t) < (1 << _IOC_SIZEBITS)))
>=20
> Objections? =A0The only reason that doesn't break gcc to hell and bac=
k is
> that gcc has unfixed bugs in that area. =A0It certainly is not a vali=
d C
> or even a remotely sane one.

Yes, looks good. I originally came up with _IOC_TYPECHECK before we had
the generic BUILD_BUG_ON().=20

One minor issue though:
While BUILD_BUG_ON and a few other macros in linux/kernel.h are current=
ly
exported to user space, I would think that they should really be hidden
in #ifdef __KERNEL__, which means that we also need something like

#ifdef __KERNEL__
#define _IOC_TYPECHECK(t) \
        (sizeof(t) + BUILD_BUG_ON_ZERO(sizeof(t) =3D=3D sizeof(t[1]) &&=
 \
          sizeof(t) < (1 << _IOC_SIZEBITS)))
#else
#define _IOC_TYPECHECK(t) sizeof(t)
#endif

	Arnd <><
