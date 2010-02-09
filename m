From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/14] ARM: LPC32XX: Initial architecture header files
Date: Tue, 9 Feb 2010 17:58:57 +0000
Message-ID: <20100209175857.GA20924@n2100.arm.linux.org.uk>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com> <1265674295-23996-2-git-send-email-wellsk40@gmail.com> <20100209093129.GA2284@pengutronix.de> <20100209095934.GA11534@n2100.arm.linux.org.uk> <20100209165223.GA11113@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54925 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab0BIR7O (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Feb 2010 12:59:14 -0500
Content-Disposition: inline
In-Reply-To: <20100209165223.GA11113@pengutronix.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, wellsk40@gmail.com, linux-sparse@vger.kernel.org

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

The point is that on 64-bit architectures, a pointer may be representab=
le
by an unsigned long, but not an int.

> Is this intended?  What is the preferred way to define iomem pointers=
?

Define a numerical address with a UL suffix is the simplest way.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
