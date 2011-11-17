From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: variable size array declarations
Date: Thu, 17 Nov 2011 11:13:52 +0300
Message-ID: <20111117081352.GF29436@mwanda>
References: <20111031140829.GD15494@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:63100 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1KQIMg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Nov 2011 03:12:36 -0500
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by rcsinet15.oracle.com (Switch-3.4.4/Switch-3.4.4) with ESMTP id pAH8CZau005185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2011 08:12:36 GMT
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id pAH8CYrV011413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2011 08:12:35 GMT
Received: from abhmt106.oracle.com (abhmt106.oracle.com [141.146.116.58])
	by acsmt356.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id pAH8CTfZ005924
	for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2011 02:12:29 -0600
Content-Disposition: inline
In-Reply-To: <20111031140829.GD15494@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2011 at 05:08:29PM +0300, Dan Carpenter wrote:
> I am trying to check something in Smatch with variable size arrays
> and I'm running into problems.  Here is the function I'm trying to
> parse.
>=20
> void func(int x)
> {
> 	char buf[x];
> }
>=20
> Array symbols have an ->array_size.  It gets set correctly in parse.c
> to expression of type EXPR_SYMBOL.  But by the time I parse it in
> Smatch the ->array_size is now an EXPR_PREOP (a dereference).  In
> fact all the variables seem to get change to dereferences of the
> variables.
>

I tracked this down.  In smatch, how I use sparse is that I call
sparse_keep_tokens() and then I parse the resulting symbol list
myself.

In examine_array_type() we call get_expression_value() which changes
the symbols from normal symbols to dereferences.  The call tree is:
examine_array_type()
-> get_expression_value()
   -> __get_expression_value()
      -> evaluate_expression()
         -> evaluate_symbol_expression() <- change happens here.

The problem for me is that not all expressions have been evualated
like this so it's not consistent.

regards,
dan carpenter


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOxMI/AAoJEOnZkXI/YHqR5B4QAIdpUf0BvapTqRWzCU1yHaHS
zDNuAgWVsZcVChMhfiEV9ZOS1tW4eXBUHi3QsgSr/QYxd+WCmBZxqaAV4xMvngJP
uQUXdLY0SFNiu815Zj/Rx1x16ILg7YX1ZZqAt5KnNQuB51/i0Uewr76og//bq1sw
nMJc6OkCEYaCluVWTAanxXJIwyv3PrNJW4q5VFWV6RlopL9BMqxDUUCTwRzzAwGP
Fj44oy5I41FyR0V717Ky/BtiuXOyF7boS4CJTOW+7xbu76pXnQPa+Ied+TZPVjoG
B9+gKzuTdDY2udcEHH2U7vQe+HD/WZKhZe9luuDdJ8Iq3bWfxS+r1+4lC+s98zgQ
ATQGQAFR6lpJr2K29NJsJMVUxEJCblR2NapE7NUuT75uVuLoeFsVZZSEE2r4uFoQ
UkvCtkksEZDUOm2jvBSwyEYtwyXpzjohYKGbcFL9FrSJvyNzpVOfn5Yzt4+AILhM
vFgYHYKyrLb8NgkRF3+XbrjIUX+s6F2hbun/iKjcZm8yfHZ2gh5r9SYghLdvIu0Z
HjULTihYYdjcFn4WEfKjvZiAlPsppfJVsQ3qmKt6x/Cm0KvKOzfluZ5tYIozPsG7
e1MiHi8vGj0bCW9Yd/RTxFzRFcCuabNUOuditBAvnLXWLPE/3o++/qQTjy5K/Dqv
siBOfPZ+xXiI9pgYlIE8
=PLzy
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
