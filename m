From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v2] add -Wpointer-arith sparse flag to toggle
 sizeof(void) warnings
Date: Mon, 9 Apr 2018 12:51:01 -1000
Message-ID: <20180409225101.uzztpdv6bbjmlwwr@gmail.com>
References: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
 <20180408074823.fgrmtrjzzjb7dlt2@ltop.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i66hledbarrby5xx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408074823.fgrmtrjzzjb7dlt2@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org


--i66hledbarrby5xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 09:48:24AM +0200, Luc Van Oostenryck wrote:
> With the warning disabled by default (for the moment), I had to adapt
> the testsuite with:

Ah, so should I include that change in the patch itself when I make a V3?

> > +Warn about anything that depends on the \fBsizeof\fR a function type o=
r of void.
>=20
> Maybe it would be useful to add something along the line of "like directl=
y using
> the sizeof operator on void or doing pointer arithmetic on a void pointer=
" ?

I actually just took the explanation straight from the GCC man page
since I figured the explanation should match (as the flag itself is
basicallt copied).

But I do sort of like your wording of it more, so if no one else sees
any reasons to _not_ to diverge from GCC's wording here I have no problem
changing that.

> > +Although non-standard (and somewhat illogical), constructs such as \fB=
sizeof(void)\fR
> > +are often useful when the intent is to operate on an expression withou=
t evaluating
> > +it, e.g. in the following integer constant expression predicate:
> > +.nf
> > +#define __is_constexpr(x) \\
> > +	(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)=
8)))
> > +.fi
>=20
> I think that pointer arithmetic is much more useful than taking the size =
of void
> (being able to take the size of *any* thing is somewhere in the middle, I=
MO).
> But in all case, I don't think this part should belong to the man page.

Also have no problem eliding this section if no one else has any
good arguments for keeping it.

--=20
Cheers,
Joey Pabalinas

--i66hledbarrby5xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrL7lUACgkQruvLfWhy
VBnHJBAA4WrMvWURAGnDzncmmRN07OZHpuNfKomQbaA5o0dTWHJH0rJIf5LI1X+d
hZEGRCMHQxADDjzX0auwV9yR8OrTLyD8zUIRQcTLCdNEhbWIdHqEoVGzokx49v7z
lm6Pe/ng0XODMcAwWI6jDIe0i66gngrfnfO6UN1YxxzNRYOvb30tmEizrEA6nFzT
y60HMnCR+mqeAYQ1AFVQjJeyXLHgEMekjrXGtXR1Q1rqCRzftp8S/VRQFN6zgDsL
paKuocXfJnvM+RCiMSsPS3I5dvhWMHldKCbaYIZL5XwtQyZKS1aU7RUbzkXpzrJf
dwa6l6dkcgFcji9wNJAtf9X4+8bH+/bb39OhdmhY9LtBAjR5M+7eRaTscppBctwW
ZmASbkStWqaUCInz9X1MFpLsGny0KeMYLONreFuXMniCFzevTk5L40QdmgTGGxTM
d/U2SiRWn6Bse3RwIG4gs5qemxQ8PMcSpy0algO742WTVukRZJi9lg290311XUqd
Z6KG2fMpIcZ3yt5xEYjq55QOdaBTeo1oAw/JpkHC6kRP3BWyECtjh/DsgNbTNA2m
nhXibBGbnGUGEfLgsPoCXsZzVfJJt1oUSyOcBCWdcDD4oeWyCKcrHPprHBZHwd4T
+hzGcnQ8O9mBqoey51t+t8MuiHVGh4MwOlYLopKuWEjdeGpzuT8=
=XiYb
-----END PGP SIGNATURE-----

--i66hledbarrby5xx--
