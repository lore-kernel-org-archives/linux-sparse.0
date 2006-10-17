From: Josh Triplett <josh@freedesktop.org>
Subject: New sparse git tree; please pull
Date: Tue, 17 Oct 2006 01:04:07 -0700
Message-ID: <45348E77.6020600@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig571E77E05835E9DD808DC834"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:38892 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932226AbWJQIEN (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Oct 2006 04:04:13 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, linux-sparse@vger.kernel.org
Cc: Adam DiCarlo <adam.dicarlo@gmail.com>, Pavel Roskin <proski@gnu.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig571E77E05835E9DD808DC834
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've put my current sparse development work in a new tree on kernel.org,
available via:

git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git

or to master.kernel.org users via:

git+ssh://master.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git


I've also included a couple of patches from the linux-sparse list which
have slipped through the cracks.


Linus, please pull from

git+ssh://master.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git

to get the following changes:

Adam DiCarlo:
      Add type information to enum mismatch warning

Josh Triplett:
      "Initializer entry defined twice" should not trigger with
zero-size fields
      Fix incorrect symbol in comment on #endif for multiple-inclusion gu=
ard
      Add -Wno-uninitialized
      graph: Show position in basic block nodes
      bb_terminated: Use boundary values rather than specific opcodes
      Turn on -Wcontext by default
      Merge branch 'fix-defined-twice-error-on-empty-struct' into staging=

      Merge branch 'graph' into staging
      merge branch 'more-warning-flags' into staging and fix conflicts
      merge branch 'no-semantic-h' into staging and fix conflicts
      Merge branch 'Wcontext-default' into staging

Josh Triplett and Pavel Roskin:
      Recognize and ignore __alias__ and __visibility__

 check.c                                      |    2 -
 evaluate.c                                   |    5 ++-
 expand.c                                     |   10 ++----
 graph.c                                      |    3 +
 ident-list.h                                 |    4 +-
 lib.c                                        |    4 +-
 lib.h                                        |    1
 linearize.h                                  |    3 +
 parse.c                                      |    6 ++-
 symbol.h                                     |    2 -
 validation/initializer-entry-defined-twice.c |   43
+++++++++++++++++++++++++++
 11 files changed, 67 insertions(+), 16 deletions(-)

- Josh Triplett


--------------enig571E77E05835E9DD808DC834
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNI53GJuZRtD+evsRAq9jAJ4p6gozmEJK43YKd+Pdlb/r4RSQGwCeMbCN
G+yMYrmfj09KEQZ9gMdbtZ0=
=681A
-----END PGP SIGNATURE-----

--------------enig571E77E05835E9DD808DC834--
