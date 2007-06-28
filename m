From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] c2xml
Date: Wed, 27 Jun 2007 22:45:05 -0700
Message-ID: <46834AE1.8010107@freedesktop.org>
References: <46826B68.5040302@codethink.co.uk> <1182970187.8970.145.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1C4C2135744ADF4BD19F45DA"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:46527 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbXF1FqX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:46:23 -0400
In-Reply-To: <1182970187.8970.145.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Rob Taylor <rob.taylor@codethink.co.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C4C2135744ADF4BD19F45DA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> On Wed, 2007-06-27 at 14:51 +0100, Rob Taylor wrote:
>> Here's something I've hacked up for my work on gobject-introspection
>> [1]. It basically dumps the parse tree for a given file as simplistic
>> xml, suitable for further transformation by something else (in my case=
,
>> some python).
>>
>> I'd expect this to also be useful for code navigation in editors and c=

>> refactoring tools, but I've really only focused on my needs for c api
>> description.
>>
>> There are 3 patches here. The first introduces a field in the symbol
>> struct for the end position of the symbol. I've added this in my case
>> for documentation generation, but again I think it'd be useful in othe=
r
>> cases. The next introduces a sparse_keep_tokens, which parses a file,
>> but doesn't free the tokens after parsing. The final one adds c2xml an=
d
>> the DTD for the xml format. It builds conditionally on whether libxml2=

>> is available.
>>
>> All feedback appreciated!
>=20
> Wow.  Very nice.  I can already think of several other uses for this.
[...]
>       * Please consider including information from the context and
>         address space attributes.

Actually, don't worry about that one; we can always add it later, and I'd=
 love
to see this get merged as soon as possible.

>       * Rather than the current base-type and base-type-builtin
>         mechanism, you might consider having designated IDs for the bas=
e
>         types and using those in base-type.  You could even output the
>         builtin types if you want.  I don't know if this makes things
>         easier or harder for consumers of the output; what do you think=
?

On second thought, ignore this.  We can always change it later, but havin=
g a
special syntax for the base types makes sense to me.  Anything that cares=

about types will need to understand the base types.

>       * I don't know if sparse_keep_symbols seems like the right API.
>         Sparse's approach to memory management (or lack thereof) bugs m=
e
>         a bit.  More importantly, though, it makes the hierarchy of
>         functions sparse(), then __sparse(), then sparse_keep_symbols()=
,
>         which seems strange.  I don't know a better solution offhand,
>         though; don't worry too much about addressing this.

Ignore this too.  The API you propose will work fine for now, and I don't=
 want
to hold up merging the patch on trying to think of the perfect API for
something not directly related to the point of your patch.

> Thanks again for this work; it looks great, and highly useful.

- Josh Triplett


--------------enig1C4C2135744ADF4BD19F45DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg0rhGJuZRtD+evsRAv8tAJ9/LSI2cPlaqq0Ae+Y0Yxg5tcW/VACfXyT4
nkXDNcnD1DhKy9zs3Q5u49E=
=wa0P
-----END PGP SIGNATURE-----

--------------enig1C4C2135744ADF4BD19F45DA--
