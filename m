From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 17:30:54 +0200
Message-ID: <1207841454.13354.7.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <20080410132617.720109000@sipsolutions.net>
	 <200804101724.27382.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3hoGFoNupxSlZvjvncG4"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:37921 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308AbYDJPbB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 11:31:01 -0400
In-Reply-To: <200804101724.27382.philipp.reisner@linbit.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org


--=-3hoGFoNupxSlZvjvncG4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFHi Philip,

> I just have implemented nearly the same here. Hopefully Josh will
> decide for one of these patches soon.


> +int ident_equal(struct ident *ident1, struct ident *ident2)

> +int expressions_equal(struct expression *expr1, struct expression *expr2=
)

That code looks pretty nice, I guess I should look at getting that into
my version instead of just printing the identifier to a string.

As far as I can see your version doesn't actually implement
__attribute__((context(x,1,1))) as the man-page envisioned it for
checking that a function is run under the lock context it wants, which
was one of the more important goals to me. Doing separate locks sort of
fell out.

johannes

--=-3hoGFoNupxSlZvjvncG4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/4yraVg1VMiehFYAQI+4Q/+IRMy7JCpFtyQODMKRwIQAObO4qaQ9UMA
yBSHASNcK4htlN6+qzV4M6tP2HEigdaIeK99U82M3CLb3n84yWfwxG9Y44mEj8YM
eOZirO+bPoo/+YrWw/3kttKiiTWQJ6KuOjpnQ0uzX149f/btKAc6c92F+S5Qvx1P
TIWpxPTQei/j0uKAG3e2/UOw5YB2o+tGH83lgZl86Z5EwD0l4PD9upmadLBKI/Fl
MBq0st+UO6VsJu/uEvb91sfZuc+Fdyh8kpdfUQkiCRlZT29AzL7G/hQqlbXq6WaR
v5woFwT72xkQvvbCnX3qsmSs5XVAMrxu6A79e/KWbnNbJC+zkdT08BmMR5r0Knad
TSrb4rdb/Ys3wEeHTpk9z7U7K6rjnt04q4Ruq9P+z/qpwdaRjzGJvQr9SxvnWpos
PlcPToUYhC4LAB2Q8I/goJP2NYK+Hjnt1NwHQ8T3QtCz083ZuLVsTusreSYih8+1
1k4pBJCCsFTLhV/tDgRILif4XJ0rufGc14Lp763xOdD8ovrwbAIW3Cy/WL0WJvGm
w5EKVwHmZ+7NIaDgoftZt/KpDqeC8OAwJXXuKMTdX+rUgHCgp+N+VltFKAA7hfEr
PaszuGlTi0+Qq02R4UfJNdT8h6e0QKMuGHlls7hfIegyDHle+foU8vgPvnN1d/2P
GBsjBOFjh+w=
=JQRb
-----END PGP SIGNATURE-----

--=-3hoGFoNupxSlZvjvncG4--

