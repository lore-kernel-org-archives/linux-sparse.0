From: Josh Triplett <josh@freedesktop.org>
Subject: Re: inline functions and context
Date: Fri, 04 May 2007 12:23:52 -0700
Message-ID: <463B8848.1040802@freedesktop.org>
References: <4638DDFD.9020609@freedesktop.org>	 <70318cbf0705031440t3f48d26fs4dab8ec71eb5574f@mail.gmail.com>	 <463AD737.8010600@freedesktop.org>	 <70318cbf0705041110m48391b26w5fc5b23c5f2bd74f@mail.gmail.com>	 <463B790E.10906@freedesktop.org> <70318cbf0705041152x130cce81i20e00f1d9a509575@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5FA1BC1A8FAEC760DE6474AD"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:46475 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422689AbXEDTYD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2007 15:24:03 -0400
In-Reply-To: <70318cbf0705041152x130cce81i20e00f1d9a509575@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5FA1BC1A8FAEC760DE6474AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On 5/4/07, Josh Triplett <josh@freedesktop.org> wrote:
>> Christopher Li wrote:
>>> On 5/3/07, Josh Triplett <josh@freedesktop.org> wrote:
>>>> Perhaps we should add inline functions to the symbols list.  I perso=
nally like
>>>> the idea of treating them as regular functions that just happen to h=
ave the
>>>> "inline" attribute, at least until Sparse has a real need to perform=
 inlining.
>>> No. That is a bad idea. Inline function get include many times when c=
hecking
>>> on different source file. You will get tons duplicate warnings becaus=
e different
>>> source file include the same header file. It also slow down the spars=
e checking.
>> The same thing happens for any other kind of warning that occurs on so=
mething
>> in a header file; I don't consider that a problem.
>=20
> If you do that, you will see tons of repeated warning on the spinlock h=
eader
> files. Sparse already has pretty high noise level, you really don't wan=
t more.

You will only get such warnings until you annotate the inline spinlock
functions.

>>>> Not what I mean.  I don't want to see multiple complaints about an u=
nepected
>>>> unlock in unlock_something, one per call to it; I want to see *one* =
complaint
>>>> about an unexpected unlock in unlock_something, emitted when analyzi=
ng
>>>> unlock_something.  I don't think f should generate any warnings, unl=
ess you
>>> That is pretty useless. Because we know that unlock_something is just=
 a wrapper
>>> of unlocking. Telling me that this function has lock unbalance is not=

>>> interesting.
>> How do you know?  Why do we not assume that any function which unlocks=
 without
>> locking, like f, "is just a wrapper of unlocking"?  I think we should =
stop at
>> the first function that doesn't explicitly say "I intended to change t=
he
>> context", and not propogate the warning outward.
>>
>>> I actually want to see the user of unlock_something() doing some thin=
g wrong.
>> How do you know they did something wrong?  Perhaps unlock_something di=
d
>> something wrong?  Not every inline function that uses locks serves as =
a
>> trivial lock wrapper.
>=20
> Sparse can tell who's fault it is by just looking at the inline
> function. It also can't
> tell if it is unlock_something() wrong or some thing wrong with f(). Th=
at is why
> it is better report on the f(). We can examine the f(), with ctags we
> can find out
> what it really does, so if it is fault in unlock_something(), we still =
can tell.

The moment you annotate unlock_something, the warning will show up in f
instead.

> The reverse it not true. If you only report error in
> unlock_something(). It is very
> hard to find out which caller trigger the unbalance.

Once you look at unlock_something and decide that it does the right thing=
, you
can add an annotation to it, and the warning will show up in f instead.

> If there is some thing wrong with the inline function, sparse will comp=
lain when
> some one actually use it. You will not  miss it.

But you first have to figure out that the warning comes from unlock_somet=
hing,
not from f.  For a function with "unlock" in the name, that seems easy.  =
For a
random "do_something" inline function with broken locking, that might tak=
e
some time.  Pointing at the root cause of the warning, and letting the us=
er
tell you "no, that one does the right thing" with an annotation, seems li=
ke a
better approach to me.

>>>> add context annotations to lock_something and unlock_something and t=
hey don't
>>>> match, or unless Sparse starts doing whole-program analysis and look=
s inside
>>>> both lock_something and unlock_something and finds that they don't m=
atch.
>>> In your case, you should just add context annotation to declaration o=
f
>>>  lock_something.
>>> Sparse will take into account that lock_something change context. It
>>> will also inline
>>> unlock_something, which has some instruction will change context as
>>> well. In the end
>>> sparse will find out context is balanced at exit. It is not as good a=
s
>>> whole-program
>>> analysis because you have to annotate lock_something manually. On the=

>>> other hand,
>>> annotation for lock_something is good for reading as well. There is
>>> very limited header
>>> file need this kind of annotation.
>>>
>>> The bottom line is, if you annotate the function correctly, sparse
>>> will do the right thing
>>> on counting the balance..
>> It seems wrong to me that annotating lock_something and not annotating=

>> unlock_something will satisfy sparse.
>=20
> That is because unlock_something has implementation detail get inlined =
while
> lock_something does not. The context annotation for lock_something is t=
o
> make up for that.

In the ideal future when Sparse has whole-program analysis, it could look=

inside both lock_something and unlock_something and find that the locking=

looks fine.  The annotations would then only serve to localize warnings a=
nd
simplify the analysis.  However, I don't want to half-do interprocedural
analysis, for inline functions only; that leads to the confusing scenario=
 of
having to annotate lock_something to prevent mismatch warnings.  I'd pref=
er
that if you haven't annotated either lock_something or unlock_something y=
ou
see warnings on those two functions only.

Furthermore, as long as sparse does not distinguish between contexts, hav=
ing
many inlines that can change the context to unlocked may obscure real loc=
k
warnings.

- Josh Triplett


--------------enig5FA1BC1A8FAEC760DE6474AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGO4hQGJuZRtD+evsRAi3xAJ4jKjBkSFkfBP7NFm1GRbhY48x24QCgiOhu
GzSI65B0Lkailmy6owF1f0k=
=DAk0
-----END PGP SIGNATURE-----

--------------enig5FA1BC1A8FAEC760DE6474AD--
