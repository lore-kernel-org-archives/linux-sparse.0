From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 01/14] ARM: LPC32XX: Initial architecture header files
Date: Tue, 9 Feb 2010 17:52:23 +0100
Message-ID: <20100209165223.GA11113@pengutronix.de>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com> <1265674295-23996-2-git-send-email-wellsk40@gmail.com> <20100209093129.GA2284@pengutronix.de> <20100209095934.GA11534@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36863 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab0BIQwd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Feb 2010 11:52:33 -0500
Content-Disposition: inline
In-Reply-To: <20100209095934.GA11534@n2100.arm.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, wellsk40@gmail.com, linux-sparse@vger.kernel.org

[Added linux-sparse@vger.kernel.org to Cc:]

On Tue, Feb 09, 2010 at 09:59:34AM +0000, Russell King - ARM Linux wrot=
e:
> On Tue, Feb 09, 2010 at 10:31:29AM +0100, Uwe Kleine-K=F6nig wrote:
> > > +#define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS(x=
))
> > Is this cast to unsigned long needed?  AFAIK IO_ADDRESS(x) has
> > type unsigned for x in { 0x0 ... 0xffffffff } (provided that int us=
es a
> > 32 bit 2s-complement representation).  If unsigned long is really
> > needed, maybe put it into the IO_ADDRESS macro?
>=20
> int -> void __iomem * =3D sparse warning
> unsigned long -> void __iomem * =3D no sparse warning
Ah, OK, I see.  But IMHO it's a poor reason to add the cast.  Either
the cast is necessary/recommended or sparse is wrong.  In the first cas=
e
the reasoning shouldn't have to do with sparse, in the latter sparse
should be fixed.

I found the responsible code in sparse.  It reads:

	static struct symbol *evaluate_cast(struct expression *expr)
	{
		int as1 =3D 0, as2 =3D 0;
		...
		ctype =3D examine_symbol_type(expr->cast_type);
		...
		class1 =3D classify_type(ctype, &t1);
		...
		if (t1 =3D=3D &ulong_ctype)
			as1 =3D -1;
		else if (class1 =3D=3D TYPE_PTR) {
			examine_pointer_target(t1);
			as1 =3D t1->ctype.as;
		}
	=09
		if (t2 =3D=3D &ulong_ctype)
			as2 =3D -1;
		else if (class2 =3D=3D TYPE_PTR) {
			examine_pointer_target(t2);
			as2 =3D t2->ctype.as;
		}
		...
		if (as1 > 0 && !as2 &&
		    !is_null_pointer_constant(target) && Wcast_to_as)
			warning(expr->pos,
				"cast adds address space to expression (<asn:%d>)", as1);

so it seems to be explicitly allowed to make a pointer in any address
space from an unsigned long, but not from a (signed or unsigned) int.
Unfortunately there is no comment describing why unsigned long is
allowed.

Is this intended?  What is the preferred way to define iomem pointers?

I found the following variants in the kernel[1]

	#define ...	((void __iomem *)(unsigned long)0x12345678)
	#define ...	((void __iomem __force *)0x12345678)
	#define ...	((void __iomem *)0x12345678)

where __iomem is defined as __attribute__((noderef, address_space(2)))
for sparse.

The first variant with the extra cast to unsigned long seems unnecessar=
y
long, the third results in the "cast adds address space to expression"
warning.

So what do you recommend?

Best regards and thanks
Uwe

[1] I only checked a few files, so maybe there are more.
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
