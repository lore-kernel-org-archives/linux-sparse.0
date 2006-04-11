From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] sparse: gcc 4.1 warnings
Date: Tue, 11 Apr 2006 10:56:02 +0200
Message-ID: <20060411085602.GA11643@wohnheim.fh-wedel.de>
References: <20060408041419.GA8943@havoc.gtf.org> <20060410132157.4AF15C000E2@dunnock.rentec.com> <443AF8A4.2090007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:5550 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932364AbWDKI4T (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Apr 2006 04:56:19 -0400
Content-Disposition: inline
In-Reply-To: <443AF8A4.2090007@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Morten Welinder <terra@gnome.org>, linux-sparse@vger.kernel.org

On Mon, 10 April 2006 20:30:28 -0400, Jeff Garzik wrote:
> Morten Welinder wrote:
> >This doesn't look quite right.
> >
> >So it looks like gcc 4.1 complains over non-used values that are the
> >result of a cast.  That feels obnoxious, but in this case maybe you
>=20
> Yes, it is :)  See below for vanilla sparse build under gcc 4.1...
>=20
>=20
> >could try just casting to void in add_ptr_list -- is the value ever
> >used?
>=20
> All uses except for add_pseudo() ignore the return value.

How about making this two functions instead?  Something like

void add_ptr_list(...)
{
	(void) __add_ptr_list(...);
}

And use the __add_ptr_list version in add_pseudo().

Hmm.  Except that this is userspace and double underscores are not
allowed.  Maybe do_add_ptr_list(...) then?

And yes, this is really obnoxious.  I have read code before that
constantly does
	(void) this(...);
	(void) that(...);
and didn't like it much.  Ignoring the issue and fixing the code
checker instead might be a better idea.

J=F6rn

--=20
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf=20
