From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Mon, 29 Aug 2011 03:25:01 -0700
Message-ID: <20110829102501.GA22825@leaf>
References: <1314501260-27254-1-git-send-email-chrisf@ijw.co.nz>
 <20110829100106.GE15022@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48362 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab1H2KZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 06:25:10 -0400
Content-Disposition: inline
In-Reply-To: <20110829100106.GE15022@debian.debian>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: Chris Forbes <chrisf@ijw.co.nz>, linux-sparse@vger.kernel.org

On Mon, Aug 29, 2011 at 12:01:06PM +0200, Jonathan Neusch=E4fer wrote:
> On Sun, Aug 28, 2011 at 03:14:18PM +1200, Chris Forbes wrote:
> > +	case EXPR_BINOP:
> > +	case EXPR_COMMA:
> > +	case EXPR_COMPARE:
> > +	case EXPR_LOGICAL:
> > +	case EXPR_ASSIGNMENT:
> > +		return expr_equiv(lhs->left, rhs->left) &&
> > +			expr_equiv(lhs->right, rhs->right);
> [...]
> > +	if ((a =3D=3D b) && (a =3D=3D b))	/* should warn */
> > +		bar();
> > +
> > +	if ((a =3D=3D b) && (b =3D=3D c))	/* should not warn */
> > +		bar();
>=20
> Should it maybe also handle cases like this?
>=20
> if ((a =3D=3D b) && (b =3D=3D a))
> 	bar();

That seems both significantly harder to handle and significantly less
likely (since it won't occur due to simple copy/paste).  Probably worth
doing at some point, but I don't think a first pass needs to consider
it.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
