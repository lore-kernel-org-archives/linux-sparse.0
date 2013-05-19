From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH 3/4] sparse, llvm: base load/store address type on
 insn_symbol_type()
Date: Sun, 19 May 2013 02:17:43 +0200
Message-ID: <20130519001743.GF3154@debian.debian>
References: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net>
 <1368899527-2350-3-git-send-email-j.neuschaefer@gmx.net>
 <5198047E.5000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:56457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab3ESARr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 20:17:47 -0400
Received: from mailout-de.gmx.net ([10.1.76.2]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MRQbm-1V29UQ0M8W-00SihR for
 <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 02:17:46 +0200
Content-Disposition: inline
In-Reply-To: <5198047E.5000806@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, May 18, 2013 at 06:45:18PM -0400, Xi Wang wrote:
> On 05/18/2013 01:52 PM, Jonathan Neusch=C3=A4fer wrote:
> >   	/* convert address back to pointer */
> > -	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
> > -				 LLVMTypeOf(src_p), "addr");
> > +	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i, addr_type, "addr"=
);
>=20
> Actually, we shouldn't convert pointers to integers in the first plac=
e.
> This effectively disables pointer analysis and future optimizations.
>=20
> A better way is to use LLVM's GEP for pointer arithmetic, by converti=
ng
> pointers to `char *', rather than integers.
>=20
> See more examples here:
> http://www.spinics.net/lists/linux-sparse/msg02768.html
>=20
> Jonathan, how about this version using `char *' based on your patchse=
t?

It looks good. ACK.

> +	LLVMTypeRef type =3D LLVMTypeOf(base);
> +	unsigned int as =3D LLVMGetPointerAddressSpace(type);

Right, I was sloppy about address spaces. :-)


Thanks,
Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
