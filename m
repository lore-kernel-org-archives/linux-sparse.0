From: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Bug#906472: horst: FTBFS in buster/sid (unable to open 'stdarg.h')
Date: Tue, 25 Sep 2018 16:38:01 +0200
Message-ID: <8160e494-8548-761c-07c0-83aa0b97b075@kleine-koenig.org>
References: <E1fqkJB-0004Wc-55@paradis.debian.org> <E1fqkJB-0004Wc-55@paradis.debian.org> <1535227396@msgid.manchmal.in-ulm.de> <20180914140409.GA25593@localhost> <20180914194543.GA22476@taurus.defre.kleine-koenig.org> <20180924162339.wfs6pmy33ujvuyem@ltop.local> <E1fqkJB-0004Wc-55@paradis.debian.org>
Reply-To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 906472@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ePLg7kytdGuKgd4YlzLu4vpYFmgLL7Qvd"
Return-path: <bounce-debian-bugs-rc=glddbr-debian-bugs-rc2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.906472.B906472.153788671517107@bugs.debian.org>
In-Reply-To: <20180924162339.wfs6pmy33ujvuyem@ltop.local>
List-URL: <https://lists.debian.org/debian-bugs-rc/>
List-Post: <mailto:debian-bugs-rc@lists.debian.org>
List-Help: <mailto:debian-bugs-rc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=unsubscribe>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christoph Biedl <debian.axhn@manchmal.in-ulm.de>, Santiago Vila <sanvila@debian.org>, 906472@bugs.debian.org, linux-sparse@vger.kernel.org, Adrian Bunk <bunk@debian.org>
List-Id: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ePLg7kytdGuKgd4YlzLu4vpYFmgLL7Qvd
Content-Type: multipart/mixed; boundary="5V9MNujSbOcyrhDMIhNrnojzyfAe8KrQV";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christoph Biedl <debian.axhn@manchmal.in-ulm.de>,
 Santiago Vila <sanvila@debian.org>, 906472@bugs.debian.org,
 linux-sparse@vger.kernel.org, Adrian Bunk <bunk@debian.org>
Message-ID: <8160e494-8548-761c-07c0-83aa0b97b075@kleine-koenig.org>
Subject: Re: Bug#906472: horst: FTBFS in buster/sid (unable to open
 'stdarg.h')
References: <E1fqkJB-0004Wc-55@paradis.debian.org>
 <E1fqkJB-0004Wc-55@paradis.debian.org> <1535227396@msgid.manchmal.in-ulm.de>
 <20180914140409.GA25593@localhost>
 <20180914194543.GA22476@taurus.defre.kleine-koenig.org>
 <20180924162339.wfs6pmy33ujvuyem@ltop.local>
In-Reply-To: <20180924162339.wfs6pmy33ujvuyem@ltop.local>

--5V9MNujSbOcyrhDMIhNrnojzyfAe8KrQV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Luc,

On 09/24/2018 06:23 PM, Luc Van Oostenryck wrote:
> On Fri, Sep 14, 2018 at 09:45:44PM +0200, Uwe Kleine-K=C3=B6nig wrote:
>>>> Santiago Vila wrote...
>>>>
>>>>> 	make -j1 check
>>>>> make[1]: Entering directory '/<<PKGBUILDDIR>>'
>>>>> sparse -g -O2 -fdebug-prefix-map=3D/<<PKGBUILDDIR>>=3D. -fstack-pro=
tector-strong -Wformat -Werror=3Dformat-security -std=3Dgnu99 -Wall -Wext=
ra -g -I. -DDO_DEBUG -I/usr/include/libnl3 *.[ch]
>>>>> /usr/include/err.h:25:11: error: unable to open 'stdarg.h'
>>>>
>>>> To reproduce this it's important to remove gcc-7 from the build chro=
ot
>>>> (apt purge libgcc-7-dev ; apt --purge autoremove).
>>>>
>>>> Problem is, sparse appearently uses hardcoded paths and looks for
>>>> stdarg.h in (among other places)
>=20
> Well, sparse needs to know where it can find the system header files.
> There is an option for this: -gcc-base-dir (and -multiarch-dir).
> Usually you will want to use either some that are installed by your
> distro or the one that match the exact GCC version you're using.

I think I don't want to impose on sparse users to know the system header
location.

> By *default*, if no -gcc-base-dir is used, sparse use the same dir
> as the one used by the GCC used to compile sparse itself. It's only
> this default that is hardcoded.

I wasn't sure if this is expected to work. I had in mind, that the
version of gcc is used somewhere but couldn't find proof for that.

> In case the default can't be used, like here, I think the best is
> to add in your Makefile something like:
> 	GCC_BASE_DIR=3D$(shell $(CC) -print-file-name=3D)
> 	SPARSE_FLAGS=3D -gcc-base-dir $(GCC_BASE_DIR)
> 	...
> 		sparse $(SPARSE_FLAGS) ...

IMHO it is sensible to let sparse depend on (or at least recommend) gcc.
And then the default value should be right.

> This doesn't need to be done at each invocation of sparse (but will be =
done
> at each top-level make invocation).

I'd say you'd need :=3D for this effect instead of =3D. But as I intend t=
o
make sure that with sparse the default headers are also available, this
is a non-issue. (And this only happened because sparse was built with
gcc-7 while horst was built with gcc-8.)

Best regards and thanks for your valuable input,
Uwe


--5V9MNujSbOcyrhDMIhNrnojzyfAe8KrQV--

--ePLg7kytdGuKgd4YlzLu4vpYFmgLL7Qvd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAluqSEkACgkQwfwUeK3K
7AkoXwf/aJqeKvP8NoDFBwyUsSVzpwvwIFjH3n0APqofQX6VffNaikxM0Ug5NrN5
gMH5Dja8ZvgEKSortt0KNsXNAoiQl9oyjSGIrWTR5m4XblDJqakSwwr85uz4KZAQ
9MTlU63ISYHgNVtqtpIVK20XmRKz012jq5RGndzX16gxrIOUHr0yrOpHZVW71PbQ
4i7inVmemIptG2JxzO/Ptshn9Yh+69GLXJPHTdfyKJOWMiLOwkDzW0KfBnbYMlAH
BhEGXMk6ARhImS1i/ZJ63z1FsuJc6gE42iynEIm1I+dyh+GtxlyZNXY2P4sab4Kw
empIGeOXm179+e7+5NMG+jxiacIZPg==
=9ZRO
-----END PGP SIGNATURE-----

--ePLg7kytdGuKgd4YlzLu4vpYFmgLL7Qvd--
