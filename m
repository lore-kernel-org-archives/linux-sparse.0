From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] tell gcc optimizer to never introduce new data races
Date: Mon, 16 Jun 2014 15:37:03 +0100
Message-ID: <20140616143703.GF5099@sirena.org.uk>
References: <alpine.LNX.2.00.1406101517300.9378@pobox.suse.cz>
 <20140616102927.GA2994@mwanda>
 <mvmsin51605.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j5J5lYLHcSGsXTNV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mvmsin51605.fsf@hawking.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Jambor <mjambor@suse.cz>, Petr Mladek <pmladek@suse.cz>, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org


--j5J5lYLHcSGsXTNV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 12:52:10PM +0200, Andreas Schwab wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:

> > Adding "--param allow-store-data-races=0" to the GCC options for the
> > kernel breaks C=1 because Sparse isn't expecting a GCC option with that
> > format.

> Please try --param=allow-store-data-races=0 instead.

That appears to work for me.

--j5J5lYLHcSGsXTNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTnwEMAAoJELSic+t+oim9V18P/jBvkywh+YQMj8yAbpOmvBiv
nzkFZxdSSKgqrjSz8kxt2D19jx8HzNVXIPY3Kb8jqwcOT/YWRYkey+AkMFyhDOpt
fT7i1zv5TOV2wDgspXRJwLLYCfMc/y0BpEGm8J7Td8NbxSpn8UNdqK2nCdE7j+fI
Hx4t3Pdfthb0od6Os9gVZLyIbJfcU+3BugTxkQ3lxXoJQDKbc5jT1dLw02GORJ0y
Y7mQNZZyHYvQmucBm4k54mqc3X/rJSyf73EV5jgpQx0DZu0OI4XMC5eIODbmhFl9
Xo0N5E3s+xbjv4mUAvWYcjZGDap7/Gugz5TMSeDQjRLLBUvMwmerj8wNx4zLwnay
jqF63GXYhLi7mFrk5sI5KdKlxAKj3l9MhPZBnbo8EjcZrTkmI7aBcFbd9VUZBJo3
Gucx6LSBKAnfm/IZdsVyOZ90ngUSowoBq4mqodDC01oLdd45Ek1uaYqNeh77JUPJ
oiOUGgG3bpIz86v18/CpcliZ9fS94aFv0YdIkA3MpqqN41pwBdBKCV/AnKYuDSIq
qzqDmiCc/DtlWZzORcr9OLfSvqMpijDcPRecH1f1mwl+upMgILvjTLsbfOkKAKPH
tJCcU2fzTRLZAkq01HmdU9pa1nYC4kera5NvUOloGIi03TC7uVqZmieRF91+kyns
MTjYAnN+WCq+AIk3ctpU
=FSo7
-----END PGP SIGNATURE-----

--j5J5lYLHcSGsXTNV--
