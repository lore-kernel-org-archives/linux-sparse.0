From: josh@joshtriplett.org
Subject: Re: linux-4.1-rc7 and dev versions of gcc
Date: Tue, 9 Jun 2015 08:33:42 -0700
Message-ID: <20150609153341.GA2595@cloud>
References: <DUB128-W148850BD36B441B5C030639CBE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50865 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933128AbbFIPdr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Jun 2015 11:33:47 -0400
Content-Disposition: inline
In-Reply-To: <DUB128-W148850BD36B441B5C030639CBE0@phx.gbl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>
Cc: "sparse@chrisli.org" <sparse@chrisli.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Tue, Jun 09, 2015 at 07:35:58AM +0000, David Binderman wrote:
> Hello there,
>=20
> Recent development versions of gcc have started using the 6.0.0 versi=
on number.
>=20
> gcc version 6.0.0 20150607 (experimental) (GCC)=20
>=20
> Linux kernel doesn't understand any gcc version numbers beyond 5.
>=20
> include/linux/compiler-gcc3.h=A0=20
> include/linux/compiler-gcc4.h=20
> include/linux/compiler-gcc5.h
>=20
> Kernel build fails because no compiler-gcc6.h file.
>=20
> I have a temporary bodge to copy compiler-gcc5.h file into compiler-g=
cc6.h

This shouldn't be a Sparse issue.  As discussed previously on this list
and LKML, Sparse should probably declare a specific GCC version number,
*not* the latest.  Apart from that, handling GCC 6 has been discussed o=
n
LKML previously, and I think there were some patches circulating
already.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
