From: Josh Triplett <josh@freedesktop.org>
Subject: Re: constness bug in include/linux/compiler.h
Date: Fri, 16 Mar 2007 11:40:18 -0700
Message-ID: <45FAE492.2040504@freedesktop.org>
References: <ee9e417a0703131523x2cc701f7l7938624175bf1fe0@mail.gmail.com>	 <45F8206E.8030706@freedesktop.org> <ee9e417a0703141210n7d8e8834j56c17b69ce68ff2c@mail.gmail.com> <45FAE16A.3080601@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE27BBB342AD49D99E994411D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:45727 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965825AbXCPSkf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 16 Mar 2007 14:40:35 -0400
In-Reply-To: <45FAE16A.3080601@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Russ Cox <rsc@swtch.com>, linux-sparse@vger.kernel.org, Tom Bergan <tbergan@ucla.edu>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE27BBB342AD49D99E994411D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> Russ Cox wrote:
>>> Yes, that makes sense.  These functions just check for the annotation=
 on their
>>> pointer argument, and having the const annotation would allow them to=
 check
>>> const pointers without provoking a warning due to the lack of const.
>> They don't provoke a warning now.  Sparse is silent on this program:
>>
>> 	#define __user __attribute__((noderef, address_space(1)))
>>
>> 	extern void __chk_user_ptr(void __user *);
>>
>> 	void
>> 	f(const void __user *p)
>> 	{
>> 		__chk_user_ptr(p);
>> 	}
>=20
> Hmmm, odd.  After a few iterations, I managed to discover that Sparse w=
ill
> warn if you attempt to convert a const int * to an int *, but not if yo=
u
> attempt to convert a const void * to a void *.  This seems like a bug t=
o me.

This bug appears to come from the following code in compatible_assignment=
_types:

                /* "void *" matches anything as long as the address space=
 is OK */
                target_as =3D t->ctype.as | target->ctype.as;
                source_as =3D s->ctype.as | source->ctype.as;
                if (source_as =3D=3D target_as && (s->type =3D=3D SYM_PTR=
 || s->type =3D=3D SYM_ARRAY)) {
                        s =3D get_base_type(s);
                        t =3D get_base_type(t);
                        if (s =3D=3D &void_ctype || t =3D=3D &void_ctype)=

                                goto Cast;
                }

This should almost certainly check more than just address spaces.

- Josh Triplett


--------------enigE27BBB342AD49D99E994411D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF+uSSGJuZRtD+evsRAnqzAJwNSuBOBy4vAQLVk7zoQfYeAtY29gCgtbu4
CyQaRO765HXr6NCV/NrFSAg=
=1Brl
-----END PGP SIGNATURE-----

--------------enigE27BBB342AD49D99E994411D--
