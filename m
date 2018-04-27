From: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Bug#873508: sparse test failures & PATH_MAX
Date: Fri, 27 Apr 2018 09:33:55 +0200
Message-ID: <fffc3da7-186a-62d2-f1ef-1a6e95d4d613@kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org> <779a85fe-0691-0f8b-c70a-85df449003bc@kleine-koenig.org> <20180427073258.ga6i5maalktyukxu@ltop.local> <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iFXPb5G58oWyOAes6qlKRLCNj9C4b0c92"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.152481444214586@bugs.debian.org>
In-Reply-To: <20180427073258.ga6i5maalktyukxu@ltop.local>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>
List-Id: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iFXPb5G58oWyOAes6qlKRLCNj9C4b0c92
Content-Type: multipart/mixed; boundary="b7IgJjJnfKCRzRKSxzQwred12TnFd3R8A";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, 873508@bugs.debian.org,
 Antoine Beaupre <anarcat@debian.org>
Message-ID: <fffc3da7-186a-62d2-f1ef-1a6e95d4d613@kleine-koenig.org>
Subject: Re: sparse test failures & PATH_MAX
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <779a85fe-0691-0f8b-c70a-85df449003bc@kleine-koenig.org>
 <20180427073258.ga6i5maalktyukxu@ltop.local>
In-Reply-To: <20180427073258.ga6i5maalktyukxu@ltop.local>

--b7IgJjJnfKCRzRKSxzQwred12TnFd3R8A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 09:33 AM, Luc Van Oostenryck wrote:
> On Fri, Apr 27, 2018 at 07:56:38AM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>
>> On 08/30/2017 06:14 PM, Uwe Kleine-K=C3=B6nig wrote:
>>> Antoine Beaupre (on Cc:) noticed that sparse doesn't work on some not=
 so
>>> common architectures like ppc32le, s390x, ppc64 and sparc64[1]. This =
is
>>> nicely catched by the testsuite, e.g.:
>>>
>>> [..]
>>
>> Just a heads up: I uploaded 0.5.2 to Debian and there are problems lef=
t
>> on hurd-i386 (where PATH_MAX isn't defined[1])
>> ...
>> [1]
>> https://buildd.debian.org/status/fetch.php?pkg=3Dsparse&arch=3Dhurd-i3=
86&ver=3D0.5.2-1&stamp=3D1524168405&raw=3D0
>=20
> Thanks for the repport.
> I'll see what can be done.

I think the default idiom is:

#ifndef PATH_MAX
#define PATH_MAX 4096
#endif

Best regards
Uwe


--b7IgJjJnfKCRzRKSxzQwred12TnFd3R8A--

--iFXPb5G58oWyOAes6qlKRLCNj9C4b0c92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlri0mMACgkQwfwUeK3K
7AmRwggAl4t6sx4GgvFJn73IomrgL43X4M8OqiU0WWp8mJTURKsE0ciTD+RaI5Fk
aUHNfAUfNC8Y4+7ZaA4ppD7eMgWHcANr2+lQRnSMZO0q89gqZKWBr1YzVkOmjjam
MccGKsoY0jNqz/6/dQJSquQtEuzcsEZkdzMFYjZDYpbV68dQ/ABg2uVJKBfXRQiz
KhTIRue/MShBhwuKPHUVDs3NT1ov1Hff4qYZJh9mkxcMLqGc1PWIAUFKgLfpxk6m
UF+VrQs2yrhTKvYtLX3Y8ktEdwNnnDSumknMwOzej1orGx8avjv6mrrmdPdX1NbE
VQ68gOXJXP7vx6+xJt1ISQDkYscKTQ==
=7YBI
-----END PGP SIGNATURE-----

--iFXPb5G58oWyOAes6qlKRLCNj9C4b0c92--
