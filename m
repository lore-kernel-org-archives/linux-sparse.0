From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Running sparse on the Wine code (Was: Re: Ignore the cdecl and
 stdcall attributes for now.)
Date: Tue, 22 May 2007 19:01:48 -0700
Message-ID: <4653A08C.40700@freedesktop.org>
References: <20070515220536.GA23923@redhat.com> <464AA57B.3010205@freedesktop.org> <46520647.9090802@redhat.com> <4652819D.4040101@freedesktop.org> <46530112.2030105@redhat.com> <46535373.3020109@freedesktop.org> <4653804D.3040306@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB74E50F6B9A13F6732E9E66B"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:44210 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291AbXEWCCd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 22:02:33 -0400
In-Reply-To: <4653804D.3040306@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB74E50F6B9A13F6732E9E66B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Stefaniuc wrote:
> Josh Triplett wrote:
>> Michael Stefaniuc wrote:
>>> Josh Triplett wrote:
>>>> Don't pass -Wall to sparse unless you really mean it.  cgcc filters =
it out for
>>>> a reason; just because you have -Wall in CFLAGS for GCC doesn't mean=
 you want
>>>> -Wall for sparse.  Sparse -Wall includes some warnings with high fal=
se
>>>> positive rates that you probably don't want.
>>> Ok good to know. I went the easy way just duplicating the gcc command=
=20
>>> line and replacing gcc with sparse and adding -D__i386___ as Wine won=
't=20
>>> build without a processor type defined.
>> cgcc will define the processor type too.
>>
>> I highly recommend trying a build with CC=3Dcgcc.  You can then pass s=
parse
>> flags in CFLAGS, and cgcc will filter them out before calling CC; you =
can
>> also specify CHECK=3D"sparse -Wfoo -Wno-bar" if you prefer not to chan=
ge
>> CFLAGS.
> Hmm ... somehow i have confused cgcc with the code generating backend
> that Jeff Garzik planned to write for sparse. With cgcc i won't need my=

> Wine build hack anymore and makes things even easier for me.

Glad to hear it.

>>> I'm still trying to figure out=20
>>> if sparse is useful (signal to noise ratio) for Wine.
>> It will likely take some time and Sparse modifications in order to par=
se
>> Wine; however, I want Sparse to handle as much code as it can, not jus=
t
> With cgcc Wine builds just fine (I didn't try yet the configure and mak=
e
> depend stage of the build process). The only nitpick is that the ccache=

> cache from a normal build isn't valid anymore for the CC=3Dcgcc run. I'=
ll
> have a look into it the next time i'll have to wait for the build to fi=
nish.

This might happen due to differing compilation flags.  ccache records the=

compiler command line.

>> Linux.  I appreciate you trying it on Wine; I think working on this wi=
ll
>> help both Wine and Sparse.
>>
>>> Wine has some=20
>>> constraints (having to follow an existing old grown API; compatibilit=
y=20
>>> with other C processors on non Linux OSes) that aren't a burden for t=
he=20
>>> Linux Kernel. E.g. a patch to move to C99 struct initializer was=20
>>> recently rejected due to compatibility concerns with other C compiler=
s.
>> I just committed support for a -Wno-old-initializer flag to turn off t=
he
>> sparse warning on non-C99 initializers.
> That was fast and I didn't even request it :)

:)

>>>> The undefined preprocessor identifiers from limits.h come from not u=
sing cgcc,
>>>> which defines them.  Sparse should ideally define those itself.  You=
 can work
>>>> around the problem by using cgcc or by defining the symbols on the s=
parse
>>>> command line as cgcc does.
>>> I'll do a run with cgcc tonight instead of sparse and check the diffe=
rence.
> Updated
> http://people.redhat.com/mstefani/wine/download/wine+sparse-make.output=
=2Ebz2
> That is the result of:
> make clean; CHECK=3D'sparse -Wno-transparent-union -Wno-old-initializer=
'
> make CC=3Dcgcc > make.out 2>&1
> The output is with latest git sparse including the fix for the typedefs=

> to functions with a stdcall attribute.
> I didn't look at the output yet as it is past bed time around here.

Looks much better.

I've added a new -Wno-non-pointer-null flag which will turn off the "Usin=
g
plain integer as NULL pointer" warning, though unless you have a good rea=
son I
suggest fixing those warnings by using a pointer type like NULL rather th=
an 0.

"Bad character constant" seems to come from lines like this:
#define PROFILE_LINKED   'LINK'
The C standard says:
> The value of an integer character constant containing more than one
> character (e.g., 'ab'), or containing a character or escape sequence th=
at
> does not map to a single-byte execution character, is
> implementation-defined.
(http://c0x.coding-guidelines.com/6.4.4.4.html#879)
GCC seems to treat it as an integer, but GCC warns about it too.  If you =
want
to supply a patch to parse it the same way GCC does and generate an optio=
nal
warning, that seems reasonable.

The yacc-generated source seems to have some non-ANSI function declaratio=
ns.
I don't know if you can make it generate properly prototyped declarations=
=2E

I added __builtin_strcat and __builtin_strncat.  Wine seems to want the
latter, so this should fix several errors.

I added the constructor and destructor attributes, which Wine seems to wa=
nt.
That should fix a few errors.

You can turn off "do-while statement is not a compound statement" with
-Wno-do-while, but I'd recommend just fixing such loops to use compound
statements.  That said, I don't know why that warning occurs by default;
possibly it shouldn't.

You can fix the "preprocessor token SYMBOL redefined" warnings by using:
#ifndef SYMBOL
#define SYMBOL ...
#endif
You might manage to talk me into a -Wno-redefined-preprocessor, though.

Unknown escape warnings for \? and \E seem odd.  What does Wine expect
those to do?

"warning: crazy programmer" needs a better description, as soon as I
figure out what it means. :)

- Josh Triplett


--------------enigB74E50F6B9A13F6732E9E66B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU6CMGJuZRtD+evsRAr2OAKCgQnZZnOdvvE2sqvxlJp67yoTSugCgq110
xwA6EL4eYH348Z2DzY0pnHw=
=QQWy
-----END PGP SIGNATURE-----

--------------enigB74E50F6B9A13F6732E9E66B--
