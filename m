From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse ctags
Date: Mon, 06 Aug 2007 20:38:26 -0700
Message-ID: <46B7E932.2060804@freedesktop.org>
References: <cc723f590706260145q708c4390kf5b6ccbaf84000ef@mail.gmail.com> <1186426987.3089.27.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDFF1080993FF991D5ED9D29"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:43214 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933147AbXHGDjH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Aug 2007 23:39:07 -0400
In-Reply-To: <1186426987.3089.27.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>, dhaval@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDFF1080993FF991D5ED9D29
Content-Type: multipart/mixed;
 boundary="------------000502010600060800040505"

This is a multi-part message in MIME format.
--------------000502010600060800040505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> On Tue, 2007-06-26 at 14:15 +0530, Aneesh Kumar wrote:
>> Is there a document how to use this ? Does this work on multiple files=

>> ? Looking at the source i see it opening tags in truncate mode
>=20
> No documentation, unfortunately.  The Sparse ctags doesn't take any
> options.  It should work on multiple files by simply giving all the
> files on one ctags command line, with something like:
> ctags $(find -name '*.c')
>=20
> However, it seems to have some problems at the moment running on even
> *one* file:
>=20
> $ ./ctags ctags.c
> unknown symbol const namespace:2 type:17
>=20
> $ ./ctags validation/context.c
> unknown symbol const namespace:2 type:17
>=20
> type 17 refers to SYM_KEYWORD, which seems consistent with "unknown
> symbol const", though I don't know why ctags would look at const as a
> symbol.

Looks like some enums grew new values and ctags didn't stay up to date.  =
I
think this patch fixes that particular problem:

diff --git a/ctags.c b/ctags.c
index f5b8fc7..63f59a5 100644
--- a/ctags.c
+++ b/ctags.c
@@ -111,6 +111,8 @@ static void examine_symbol(struct symbol *sym)
 		return;
 	if (sym->ident && sym->ident->reserved)
 		return;
+	if (sym->type =3D=3D SYM_KEYWORD)
+		return;
=20
 	add_tag(sym);
 	base =3D sym->ctype.base_type;
@@ -158,6 +160,8 @@ static void examine_namespace(struct symbol *sym)
 		return;
=20
 	switch(sym->namespace) {
+	case NS_KEYWORD:
+		return;
 	case NS_LABEL:
 		sym->kind =3D 'l';
 		break;

With that patch, ctags successfully ran on individual files.  I then obse=
rved
some unusual symbols in the tags files:

add_dirafter    preprocessor    0;"     ^@      file:
add_include     preprocessor    0;"     ^@      file:
add_isystem     preprocessor    0;"     ^@      file:
define  preprocessor    0;"     ^@      file:
elif    preprocessor    0;"     ^@      file:
endif   preprocessor    0;"     ^@      file:
error   preprocessor    0;"     ^@      file:
ifdef   preprocessor    0;"     ^@      file:
ifndef  preprocessor    0;"     ^@      file:
include preprocessor    0;"     ^@      file:
include_next    preprocessor    0;"     ^@      file:
line    preprocessor    0;"     ^@      file:
nostdinc        preprocessor    0;"     ^@      file:
pragma  preprocessor    0;"     ^@      file:
split_include   preprocessor    0;"     ^@      file:
strong_define   preprocessor    0;"     ^@      file:
strong_undef    preprocessor    0;"     ^@      file:
undef   preprocessor    0;"     ^@      file:
warning preprocessor    0;"     ^@      file:
weak_define     preprocessor    0;"     ^@      file:

^@ here signifies a null.

After some further investigation, I think ctags really shouldn't look at
SYM_PREPROCESSOR or NS_PREPROCESSOR either.  I came up with the attached
patch, which I will apply soon unless someone shouts.  Chris?

This still doesn't fix running ctags on multiple files; ctags seems to ge=
t
confused in much the same way sparse does when run on multiple files: it =
spews
a pile of redefinition errors.

After we get ctags fixed up, clearly it needs some tests in the test suit=
e so
this doesn't happen again.

- Josh Triplett

--------------000502010600060800040505
Content-Type: text/x-patch;
 name="0001-ctags-Handle-some-new-namespaces-and-symbol-types.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-ctags-Handle-some-new-namespaces-and-symbol-types.patch"

=46rom 3624a543e3884e2faa9980a2ecb0c10cda646671 Mon Sep 17 00:00:00 2001
From: Josh Triplett <josh@freedesktop.org>
Date: Mon, 6 Aug 2007 20:37:25 -0700
Subject: [PATCH] ctags: Handle some new namespaces and symbol types.

ctags didn't handle SYM_KEYWORD, SYM_PROCESSOR, or NS_KEYWORD, and didn't=

handle NS_PREPROCESSOR correctly.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 ctags.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/ctags.c b/ctags.c
index f5b8fc7..7e129a6 100644
--- a/ctags.c
+++ b/ctags.c
@@ -111,6 +111,8 @@ static void examine_symbol(struct symbol *sym)
 		return;
 	if (sym->ident && sym->ident->reserved)
 		return;
+	if (sym->type =3D=3D SYM_KEYWORD || sym->type =3D=3D SYM_PREPROCESSOR)
+		return;
=20
 	add_tag(sym);
 	base =3D sym->ctype.base_type;
@@ -158,11 +160,12 @@ static void examine_namespace(struct symbol *sym)
 		return;
=20
 	switch(sym->namespace) {
+	case NS_KEYWORD:
+	case NS_PREPROCESSOR:
+		return;
 	case NS_LABEL:
 		sym->kind =3D 'l';
 		break;
-	case NS_PREPROCESSOR:
-		break;
 	case NS_MACRO:
 	case NS_UNDEF:
 		sym->kind =3D 'd';
--=20
1.5.2.4


--------------000502010600060800040505--

--------------enigFDFF1080993FF991D5ED9D29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGt+kyGJuZRtD+evsRAtdIAJ0QLgy1NekEpZcN1iq3ncQIouK8sACgiVME
yt+PtrQsDhkNZ0owf8jOGiE=
=dEJR
-----END PGP SIGNATURE-----

--------------enigFDFF1080993FF991D5ED9D29--
