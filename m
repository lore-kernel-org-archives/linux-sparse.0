From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] handle label attributes
Date: Fri, 20 Apr 2007 03:17:07 -0700
Message-ID: <46289323.9000804@freedesktop.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322171118.GL15364@redhat.com> <20070322221050.GC22151@chrisli.org> <20070323150459.52b02342.rdunlap@xenotime.net> <20070323231008.GD27992@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4BA246429C418ED25AB50655"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:39636 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992795AbXDTKRP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Apr 2007 06:17:15 -0400
In-Reply-To: <20070323231008.GD27992@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BA246429C418ED25AB50655
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Fri, Mar 23, 2007 at 03:04:59PM -0700, Randy Dunlap wrote:
>> 1.  net/sched/cls_api.c, lines 593-611:
>>
>> 	return 0;
>> rtattr_failure: __attribute__ ((unused))
>> 	return -1;
>> }

Applied, with the minor change of making the function in the new test cas=
e
static to avoid an unrelated warning with -Wdecl.

> Singed-Off-By: Christopher Li<sparse@chrisli.org>

And just what sound *does* a patch make when you sing it off? :)

- Josh Triplett


--------------enig4BA246429C418ED25AB50655
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGKJMjGJuZRtD+evsRAhSMAJ9Be2EwYzdXeq57UdrA/ZCzJVub9QCePm8X
ZIE7twXiR9V9qAvKPJ4HTdI=
=5zMb
-----END PGP SIGNATURE-----

--------------enig4BA246429C418ED25AB50655--
