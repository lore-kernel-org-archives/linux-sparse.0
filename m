From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v2] add -Wpointer-arith sparse flag to toggle
 sizeof(void) warnings
Date: Mon, 9 Apr 2018 14:59:03 -1000
Message-ID: <20180410005903.i5daqksatgdjvndz@gmail.com>
References: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
 <20180408074823.fgrmtrjzzjb7dlt2@ltop.local>
 <20180409225101.uzztpdv6bbjmlwwr@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bsg5mfzz7mx7lthw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409225101.uzztpdv6bbjmlwwr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org


--bsg5mfzz7mx7lthw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:51:01PM -1000, Joey Pabalinas wrote:
> Ah, so should I include that change in the patch itself when I make a V3?

Sending a v3 now incorporating the suggestions.

--=20
Cheers,
Joey Pabalinas

--bsg5mfzz7mx7lthw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrMDFcACgkQruvLfWhy
VBnpOw//akqShmY9OFwstYUhMYeYNGXBJtypTqFD6rQ3TZoMCmMEz5jV1SB70xfz
qyzMYgShKokTiJoDgS+Z3lwqJEN3FHNt6b3pWu49QOwuHF44ZfOfkjRrJ2BXizGk
F1gUlMLY2BV3a138w+GVNNKfvK/qQyqLe50V0JN2PwuEiLeS1BNGTeawBHIegsz8
PjD3BxqNzGRZhaENVl++BqxGoUcwgOtONqgmQrxlwuR22/TtKt9Kh03Hf8AYRtx4
HgkbScqlnBHHcVgcAlkpTAQE5wA3d+w9LKpUNvYwUP+xuuEkV3SceAmwf0JMhaTB
+Jw7XcuJC+3xatJUMJ5RGKs2W1AcridWJupuaEFRtrOId1bEOtxBwl7vhAMAHUiw
JVFUcnn45cvX6dial+vWQrnnc1UzSxSdDyWzS9EAGbkQ1GmQV3CH/EdwCZCiLYHm
n0faUz46rJ7OHyPv2zNwlaucqpyT6GtAu1agnY/xLGZYt0HzxZBKyN0obKJM9Aj/
yT1x67/9xBA4z+1lhxWTNocHF5TTcSOq5QARt/7+JaWlRMJOh2xi5DLYCYoejDzP
dGHPF9BqCHtZHPjhpbtmKg/4BXpsWmKngSS4ONS7WMbj81K64yyNyth3IWzzdI8e
GDSt6mk0wFvf8etBSSe2w0r3wqkkqDWArLguLrzc2R+NeqEAnLk=
=IRo1
-----END PGP SIGNATURE-----

--bsg5mfzz7mx7lthw--
