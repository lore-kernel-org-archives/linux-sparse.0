From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Sun, 22 Oct 2017 15:09:18 +0200
Message-ID: <39fa7788-cfba-eee5-9085-41f08b42f0a8@kleine-koenig.org>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org>
 <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5t2e6AjjmN2AX2JfSUUi6sIBhWaOPweeG"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:44242 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbdJVNTP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Oct 2017 09:19:15 -0400
In-Reply-To: <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5t2e6AjjmN2AX2JfSUUi6sIBhWaOPweeG
Content-Type: multipart/mixed; boundary="en5AAjxAIfCukmOLRdILL64lb3LjdElwL";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>,
 Jeff Layton <jlayton@redhat.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <39fa7788-cfba-eee5-9085-41f08b42f0a8@kleine-koenig.org>
Subject: Re: [GIT PULL] debug build of sparse v4
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org>
 <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>
In-Reply-To: <CANeU7Qk8-YwH77roYfHf2++wbRY72AY5nqL8P+C7VF2JJ30J1g@mail.gmail.com>

--en5AAjxAIfCukmOLRdILL64lb3LjdElwL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 06:50 PM, Christopher Li wrote:
> On Thu, Oct 19, 2017 at 5:42 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koen=
ig.org> wrote:
>>
>> I wonder about the name. From a debug build (in contrast to a release
>> build) I would expect that it allows to debug sparse itself (Think: ad=
d
>> -g to gcc, or (not) -DNODEBUG for assert(3)), but I understand you use=

>> that term differently here.
>=20
> The name if mechanical. You can suggest better names. I am
> more focus on allowing two version of sparse can be compile
> at the same time.
>=20
>>
>> Why not do the the extra tests when called as (say)
>>
>>         sparse --aggressive
>>
>=20
> Yes, actually that is what I have in mind. When "--aggressive"
> is turn on, sparse will execute "dbg-sparse" to enable those aggressive=

> code path. The optional name is subject to change.
>=20
>> . Then there is no need for an extra binary at all keeping the build
>> system simple and that also makes it it easier to understand for users=

>> (but I might judge others by my own standards here?) For gcc this flag=

>> is -Wall, there isn't an extra binary either.
>=20
> There is still need for extra binary because some verification can be
> slow sparse and hard to turn off without impact the sparse performance.=

> For example the ptr list ref count patch. It is execute at every ptrlis=
t
> bucket iteration.
>=20
> If there is no performance impact on when those verification
> is turn off. Then yes, there is no need for a separate binary.
> I haven't done concrete measurement of the slow down.
> I just assume that there will be some.

I would first implement doing everything in a single binary and only
think about the complicated split in a "normal" and an "aggressive"
sparse binary if the overhead is too high and people start wailing.

(And even then I'd first check if using the equivalent of unlikely() in
the kernel would help by assuming that passing --aggressive is "unlikely"=
=2E)

IMHO the cost of a complicated build system is to high to not first try
the alternatives.

Best regards
Uwe


--en5AAjxAIfCukmOLRdILL64lb3LjdElwL--

--5t2e6AjjmN2AX2JfSUUi6sIBhWaOPweeG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnsmH4ACgkQwfwUeK3K
7AkCjAf7Be7PPIKCq2tnG+V0M9XUIugZ5TNyjfh6L5CNRkUy1gdh92rBNwjWLkja
KJjrnqWew5vLExBV2ZUjhMhQ2GMuAN+Uc7Q/ForzWyaOrIzcwi8LG6l53cI5gPS4
NJhuvq/Cr/Q+SwClIa3voUlXH40LCAhDXn4cVtuxS85dMXfRqyJpqIWCex9Mp59x
QfbvI0Wx44rFZEhp9ihg8bOfnAb+rRWf5xS003gip+wdnH/VViWJBJElC40gVANy
wtYVHO6VShesIFP7vH4sCf9tDE7rBxXdMTDiOzUmElAu6QeVXxEqWyC6Q8aXEsnu
DcxZCW7UKsaaVVf0BxMjTt7t6BIh8Q==
=2Em4
-----END PGP SIGNATURE-----

--5t2e6AjjmN2AX2JfSUUi6sIBhWaOPweeG--
