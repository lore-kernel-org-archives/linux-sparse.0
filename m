From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/14] ARM: LPC32XX: Initial architecture header files
Date: Tue, 9 Feb 2010 10:22:12 -0800
Message-ID: <20100209182210.GB23822@feather>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
 <1265674295-23996-2-git-send-email-wellsk40@gmail.com>
 <20100209093129.GA2284@pengutronix.de>
 <20100209095934.GA11534@n2100.arm.linux.org.uk>
 <20100209165223.GA11113@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:44592 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0BISrm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Feb 2010 13:47:42 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 64E7E50C7B
	for <linux-sparse@vger.kernel.org>; Tue,  9 Feb 2010 19:22:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100209165223.GA11113@pengutronix.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, wellsk40@gmail.com, linux-sparse@vger.kernel.org

On Tue, Feb 09, 2010 at 05:52:23PM +0100, Uwe Kleine-K=F6nig wrote:
> [Added linux-sparse@vger.kernel.org to Cc:]
>=20
> On Tue, Feb 09, 2010 at 09:59:34AM +0000, Russell King - ARM Linux wr=
ote:
> > On Tue, Feb 09, 2010 at 10:31:29AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > +#define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS=
(x))
> > > Is this cast to unsigned long needed?  AFAIK IO_ADDRESS(x) has
> > > type unsigned for x in { 0x0 ... 0xffffffff } (provided that int =
uses a
> > > 32 bit 2s-complement representation).  If unsigned long is really
> > > needed, maybe put it into the IO_ADDRESS macro?
> >=20
> > int -> void __iomem * =3D sparse warning
> > unsigned long -> void __iomem * =3D no sparse warning
> Ah, OK, I see.  But IMHO it's a poor reason to add the cast.  Either
> the cast is necessary/recommended or sparse is wrong.  In the first c=
ase
> the reasoning shouldn't have to do with sparse, in the latter sparse
> should be fixed.
>
> I found the responsible code in sparse.  It reads:
>=20
> 	static struct symbol *evaluate_cast(struct expression *expr)
> 	{
> 		int as1 =3D 0, as2 =3D 0;
> 		...
> 		ctype =3D examine_symbol_type(expr->cast_type);
> 		...
> 		class1 =3D classify_type(ctype, &t1);
> 		...
> 		if (t1 =3D=3D &ulong_ctype)
> 			as1 =3D -1;
> 		else if (class1 =3D=3D TYPE_PTR) {
> 			examine_pointer_target(t1);
> 			as1 =3D t1->ctype.as;
> 		}
> 	=09
> 		if (t2 =3D=3D &ulong_ctype)
> 			as2 =3D -1;
> 		else if (class2 =3D=3D TYPE_PTR) {
> 			examine_pointer_target(t2);
> 			as2 =3D t2->ctype.as;
> 		}
> 		...
> 		if (as1 > 0 && !as2 &&
> 		    !is_null_pointer_constant(target) && Wcast_to_as)
> 			warning(expr->pos,
> 				"cast adds address space to expression (<asn:%d>)", as1);
>=20
> so it seems to be explicitly allowed to make a pointer in any address
> space from an unsigned long, but not from a (signed or unsigned) int.
> Unfortunately there is no comment describing why unsigned long is
> allowed.
>=20
> Is this intended?  What is the preferred way to define iomem pointers=
?
>=20
> I found the following variants in the kernel[1]
>=20
> 	#define ...	((void __iomem *)(unsigned long)0x12345678)
> 	#define ...	((void __iomem __force *)0x12345678)
> 	#define ...	((void __iomem *)0x12345678)
>=20
> where __iomem is defined as __attribute__((noderef, address_space(2))=
)
> for sparse.
>=20
> The first variant with the extra cast to unsigned long seems unnecess=
ary
> long, the third results in the "cast adds address space to expression=
"
> warning.
>=20
> So what do you recommend?

I don't know the reasoning behind allowing casts from unsigned long,
except perhaps to allow creating pointer literals, but explicitly
casting by way of unsigned long seems wrong.  In general, the couple of
places that legitimately convert addresses between address spaces shoul=
d
use __force.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
