From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: variable size array declarations
Date: Mon, 31 Oct 2011 17:08:29 +0300
Message-ID: <20111031140829.GD15494@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:27896 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab1JaOH7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Oct 2011 10:07:59 -0400
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by acsinet15.oracle.com (Switch-3.4.4/Switch-3.4.4) with ESMTP id p9VE7wnI009964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-sparse@vger.kernel.org>; Mon, 31 Oct 2011 14:07:58 GMT
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id p9VE7v0v019514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Mon, 31 Oct 2011 14:07:57 GMT
Received: from abhmt119.oracle.com (abhmt119.oracle.com [141.146.116.71])
	by acsmt356.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id p9VE7qJ2031378
	for <linux-sparse@vger.kernel.org>; Mon, 31 Oct 2011 09:07:52 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am trying to check something in Smatch with variable size arrays
and I'm running into problems.  Here is the function I'm trying to
parse.

void func(int x)
{
	char buf[x];
}

Array symbols have an ->array_size.  It gets set correctly in parse.c
to expression of type EXPR_SYMBOL.  But by the time I parse it in
Smatch the ->array_size is now an EXPR_PREOP (a dereference).  In
fact all the variables seem to get change to dereferences of the
variables.

So if I have:
	char buf[a + b + *c + 4];
Smatch gets:
	char buf[*a + *b + **c + 4];

I'm not sure where this is getting changed or why.

regards,
dan carpenter


--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOrqvdAAoJEOnZkXI/YHqRbTcQAIgZaTq15hQcjEhjDftczcac
06XuLNT3vanZU5+/QusE2pEBj4lCioDK7nLk1fYZCynhsJ/hcIHHqnQ20bwa9b/K
9YS5nolAzZtPiwGmKL6Dr9v9kowMW7S0htVHKUqrMVOo8pfQ2ykBRUdMddjAUm08
GzHtwqCwcX/p+qLZ9a1ZsvKrNPNTxrBj8jUaDDoURIQEQ3GGTGay77zui5pSOAKb
A1CgLzdMLjGC7tiAPK2ip/5je64We0+syJg9NfAzyf0CIkga/5T3dLPB8fiRi/AV
U/nbneXDasJN2VOxmWyLxy1gx9r7hBRV/RebRQyXQig+q7wBqVonzhNeeIIR/aPM
TSFg27xA5ay+21KVES+dsi6P8lTTw7HrqgPEb5ItyG9yHTK9eMV1PDvO/z+FwJc5
Dc+1BbSug2uBUM+Boy80cQe/LodTPtqdOym2jBdNPHQLnvX3yxrrRB6VgeZ7QJA0
E3KjrPQQ2041iYtZtNWTvOfwJu5vBuJu6AznajL0adoR7KhqjhWAbp1jhnSz9mzH
Pa+OOIPoeRx3NkQqHAtErnTCNtqIujf8Bf/4wHCPtFiC3/JI726NabZxH+Nm67qV
p47R7ZUdmxxWIDRLbAFQkIJo2Zi0r24orWSlTu1Burh4b47MWI55npf0SAvd5MwS
6YwLvlgt1gY88fHPZyMr
=qYhZ
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
