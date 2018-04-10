From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3] sparse: add -Wpointer-arith flag to toggle
 sizeof(void) warnings
Date: Tue, 10 Apr 2018 12:09:44 -1000
Message-ID: <20180410220944.vnpzmugf5xbdsnpl@gmail.com>
References: <20180410010204.qeudkkru4jilun3v@gmail.com>
 <20180410194117.ei4eo3kaxvv2ezdx@ltop.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uuv24zrkmtttto3j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180410194117.ei4eo3kaxvv2ezdx@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org


--uuv24zrkmtttto3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 09:41:19PM +0200, Luc Van Oostenryck wrote:
> Thank you very much.
>=20
> There is just a problem with the test but it's my fault as I
> pointed to you to my tree but the master tree lack a lot of fixes
> and have problems when dereferencing function pointers.
> So, for the master tree, I propose to use a version with these
> tests removed:
> 	git://github.com/lucvoo/sparse-dev.git pointer-arith-v3

Not a problem; I will rebase it on the v0.5.2-rc1 tag and
take out the function pointer test-case.

--=20
Cheers,
Joey Pabalinas

--uuv24zrkmtttto3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrNNigACgkQruvLfWhy
VBkyDxAAh5rSE9rwBu5Qe35V2SM8oPxZ7lo50mLDX6wKNYD2lXg7WYgT1jhtk6J1
CjrxPnO5KtpFGDO0dr9g1gMf1NQ8CcgeLRcIL+FN4jM1vdDozcvOod0AgOg1wNQP
95oboPSHBPvWFcUPPP/Wjm8KJKez23dfJwGVoIDX9e3LvXtN3Pc3igr0fLkQC2uP
jDDQvRJ5kzdR+S2qDjmvEv2ueiaE3GWPsoDjVt4JCWVGrMsens6kh5VY9Rz+IuND
PeLUOGmFBXZDNrfwSRVIIXavpbs5YdSbYzBPsIEWjtto4I1YBkWCHBAUFlvAg5l5
FmE/ESxmKY4z/5JvGmP6soZU/mt19P6LQe8nr2l1MPaPbKIabsUUp48mGG2cF542
cJi9XpgJzMr6Ltq0d2ZKANCZJ3sUNSYUfUX7k2oS119b8kJa3wOIvJmL8JzmkOp0
EXKxnE3A10DGSv6bLIO1JfJmLzYlavEFS2MS8ww0pRR2SJ3cCAgEewJMhSo/jDWD
8paMMaA3SvnePUJpWv7RZa3vdFzjC2nPp49L6vsjlHbaVzMDjTMAbQe3Zne6tsKe
UXwt+mgIuGDzw5EZ0j0OuQSza30Je0Gkwu4JhLBd46/DO+bkn3cF5tXvXvXLAfm/
SlJGIti2WgQ308iCO755dsusUGWhnkVLAEs5mAsFncQ+ZhQ+ZVc=
=cweM
-----END PGP SIGNATURE-----

--uuv24zrkmtttto3j--
