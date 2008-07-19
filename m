From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: some newbie questions about __attribute__((context,...))
Date: Sat, 19 Jul 2008 14:42:20 +0200
Message-ID: <1216471340.29432.3.camel@johannes.berg>
References: <alpine.LFD.1.10.0807190737340.24056@localhost.localdomain>
	 (sfid-20080719_135053_191810_F7BD1A44)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IevsOXMNs1ddq+XTc9MB"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:53778 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbYGSMmb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 19 Jul 2008 08:42:31 -0400
In-Reply-To: <alpine.LFD.1.10.0807190737340.24056@localhost.localdomain> (sfid-20080719_135053_191810_F7BD1A44)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Sparse mailing list <linux-sparse@vger.kernel.org>


--=-IevsOXMNs1ddq+XTc9MB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> "Functions with the extended attribute
> __attribute__((context(expression,in_context,out_context)) require the
> context expression (for instance, a lock) to have the value in_context
> (a constant nonnegative integer) when called, and return with the
> value out_context (a constant nonnegative integer)."
>=20
>   fair enough, but what are the possibilities for that "expression"

None. It's currently mostly ignored. I posted patches to fix this, which
had problems, and the fixes to those patches haven't been merged yet.

With my patches, the possibilities are either an expression that sparse
can resolve, e.g.

void do_lock(void *lock) __attribute__((context(lock,0,1))) {...}

or for compatibility anything else that is then treated as a constant:

void do_lock(void) __attribute__((context(GLOBAL_LOCK,0,1))) {...}

> and what exactly is being compared to the values of 0 or 1?  sure, a
> lock is an obvious candidate, but you can't really simply be comparing
> the value of a lock to 0 or 1 -- a lock is a *structure* which doesn't
> have a simple value of 0 or 1.

Sparse internally tracks the "value" of such a context. My examples
above would increase the context in the function, and every time that
function is called the context is increased, and if such a context is
"leaked" then sparse will complain it isn't 0.

> static void *aarp_seq_start(struct seq_file *seq, loff_t *pos)
>         __acquires(aarp_lock)
> {
>         struct aarp_iter_state *iter =3D seq->private;
>=20
>         read_lock_bh(&aarp_lock);
>         iter->table     =3D resolved;
>         iter->bucket    =3D 0;
>=20
>         return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN;
> }
> =3D=3D=3D=3D=3D
>=20
>   and how is that call to read_lock_bh() changing the "context" value
> of the object aarp_lock?  thanks for any enlightenment.

Well, read_lock_bh() acquires the context named "aarp_lock", and
aarp_seq_start is annotated to also do that. If you write

void foo()
{
	read_lock_bh(&aarp_lock);
}

then sparse will complain that the context is leaked in foo.

If you really want to do any serious work with sparse's context tracking
I can only suggest to apply my patches.

johannes

--=-IevsOXMNs1ddq+XTc9MB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIgeEpAAoJEKVg1VMiehFYpy0QAKARhoF6CTc0v/CvpqLiYBN4
dg74cs8ZOdd0IYNeKzEz3YmqgRNRPG7zgxlX7VIqAXNn0Nx7Hz2vG1/0V59t1d9n
tduU/cHLCExZrXF3TB/jwuANIYjnwoXlzjw8RdwBYlkHwXJ1vnMGLArEsiYXSQq3
4rfinP68sYHWmud+jaKCWpsruf9HYLcpGSoQUdLzwx2sZvHRs3zvQRDx4r/cEbJo
IfLptwUfb3TTuJosgoNV7PdIuWU/RUrR+/0OiZwQ7EmkmNYfC4+hl5lQZHShVRGt
6I95jSmZG7rjyaU06RZGk/6XCVZKz0jMKxJfytE3MhHyMQVPN5UmvkakbyUp16sM
MwVIx29Sa2FjC0rYsQvkVI4GSiuUqYx+DIIUIz3xO/IkuikAysMGBpUv4v1iQEmK
+KP3G3yb+KYIIZRvAPMUn9wy6q1uuorKTZ9Ut91+w+rONRmAChMOGlZt9pVmkpdS
458M5qzPLkT1QPOaAxRDhf6nLot0eyFHBGBFVptmnfiyMNKj+xHW3f3baIIbd8ta
BV8Aw6Z0gvaRwitQUo/7Js/VJEqgRhNHbJ4WLeii6/ij53cTNNZL9/Z95azPAQFt
wUBOXQoDq9uB5lVwUxwvmPGzxjMzh17FmV8w1tdEMIGlM3JC4ZHaYbXHA428MN2u
LNsWEeWIEsRPVpc/OD83
=c1fS
-----END PGP SIGNATURE-----

--=-IevsOXMNs1ddq+XTc9MB--

