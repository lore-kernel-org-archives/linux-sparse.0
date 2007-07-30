From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Warnings while compiling sparse
Date: Mon, 30 Jul 2007 22:30:27 +0200
Message-ID: <20070730203027.GA21099@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52800 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967725AbXG3Uab (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Jul 2007 16:30:31 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@freedesktop.org
Cc: linux-sparse@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hell Josh,

commit 06bcf19cb8eb3cc3154ba6131477d742a9f0b4b6
Author: Josh Triplett <josh@freedesktop.org>
Date:   Sun Jul 29 20:20:38 2007 -0700

    Makefile: Use -O2 -finline-functions, not just -O

    introduces warnings while compiling sparse on my machine (FC6, x86,
    gcc version 4.1.2 20070626 (Red Hat 4.1.2-13)):

     CC       parse.o
parse.c: In function =E2=80=98parse_enum_declaration=E2=80=99:
parse.c:676: warning: dereferencing type-punned pointer will break strict-a=
liasing rules
parse.c:753: warning: dereferencing type-punned pointer will break strict-a=
liasing rules
parse.c: In function =E2=80=98attribute_context=E2=80=99:
parse.c:890: warning: dereferencing type-punned pointer will break strict-a=
liasing rules
parse.c: In function =E2=80=98apply_ctype=E2=80=99:
parse.c:1027: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
parse.c: In function =E2=80=98pointer=E2=80=99:
parse.c:1234: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
parse.c:1241: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
     CC       symbol.o
symbol.c: In function =E2=80=98examine_base_type=E2=80=99:
symbol.c:203: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
symbol.c: In function =E2=80=98merge_type=E2=80=99:
symbol.c:259: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
     CC       linearize.o
linearize.c: In function =E2=80=98insert_branch=E2=80=99:
linearize.c:663: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules
linearize.c: In function =E2=80=98add_asm_input=E2=80=99:
linearize.c:1714: warning: dereferencing type-punned pointer will break str=
ict-aliasing rules
linearize.c: In function =E2=80=98add_asm_output=E2=80=99:
linearize.c:1732: warning: dereferencing type-punned pointer will break str=
ict-aliasing rules
linearize.c: In function =E2=80=98sort_switch_cases=E2=80=99:
linearize.c:1827: warning: dereferencing type-punned pointer will break str=
ict-aliasing rules
     CC       flow.o
flow.c: In function =E2=80=98kill_unreachable_bbs=E2=80=99:
flow.c:786: warning: dereferencing type-punned pointer will break strict-al=
iasing rules
     CC       simplify.o
simplify.c: In function =E2=80=98if_convert_phi=E2=80=99:
simplify.c:47: warning: dereferencing type-punned pointer will break strict=
-aliasing rules
simplify.c:49: warning: dereferencing type-punned pointer will break strict=
-aliasing rules
     CC       liveness.o
liveness.c: In function =E2=80=98clear_liveness=E2=80=99:
liveness.c:225: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
liveness.c:226: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
liveness.c: In function =E2=80=98track_pseudo_liveness=E2=80=99:
liveness.c:270: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
liveness.c: In function =E2=80=98track_phi_uses=E2=80=99:
liveness.c:291: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
liveness.c: In function =E2=80=98track_pseudo_death_bb=E2=80=99:
liveness.c:345: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
liveness.c:348: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
     CC       storage.o
In file included from storage.c:17:
storage.h: In function =E2=80=98alloc_storage_hash=E2=80=99:
storage.h:72: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
storage.c: In function =E2=80=98gather_storage=E2=80=99:
storage.c:55: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
storage.c:68: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
storage.c: In function =E2=80=98combine_storage=E2=80=99:
storage.c:206: warning: dereferencing type-punned pointer will break strict=
-aliasing rules
storage.c: In function =E2=80=98combine_phi_storage=E2=80=99:
storage.c:289: warning: dereferencing type-punned pointer will break strict=
-aliasing rules
     CC       compile-i386.o
compile-i386.c: In function =E2=80=98push_cstring=E2=80=99:
compile-i386.c:475: warning: dereferencing type-punned pointer will break s=
trict-aliasing rules
compile-i386.c: In function =E2=80=98push_atom=E2=80=99:
compile-i386.c:480: warning: dereferencing type-punned pointer will break s=
trict-aliasing rules
compile-i386.c: In function =E2=80=98stack_alloc=E2=80=99:
compile-i386.c:521: warning: dereferencing type-punned pointer will break s=
trict-aliasing rules
compile-i386.c: In function =E2=80=98func_cleanup=E2=80=99:
compile-i386.c:778: warning: dereferencing type-punned pointer will break s=
trict-aliasing rules
     CC       example.o
In file included from example.c:15:
storage.h: In function =E2=80=98alloc_storage_hash=E2=80=99:
storage.h:72: warning: dereferencing type-punned pointer will break strict-=
aliasing rules
example.c: In function =E2=80=98flush_reg=E2=80=99:
example.c:403: warning: dereferencing type-punned pointer will break strict=
-aliasing rules
example.c: In function =E2=80=98add_pseudo_reg=E2=80=99:
example.c:463: warning: dereferencing type-punned pointer will break strict=
-aliasing rules
example.c: In function =E2=80=98kill_dead_reg=E2=80=99:
example.c:880: warning: dereferencing type-punned pointer will break strict=
-aliasing rules
example.c: In function =E2=80=98kill_pseudo=E2=80=99:
example.c:1018: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
example.c: In function =E2=80=98generate_output_storage=E2=80=99:
example.c:1668: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
example.c: In function =E2=80=98generate=E2=80=99:
example.c:1686: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
example.c: In function =E2=80=98output_bb=E2=80=99:
example.c:1783: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
example.c:1784: warning: dereferencing type-punned pointer will break stric=
t-aliasing rules
     CC       ctags.o
ctags.c: In function =E2=80=98main=E2=80=99:
ctags.c:205: warning: dereferencing type-punned pointer will break strict-a=
liasing rules

bye
	michael
--=20
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGrkpj08alQ5mXm14RAkX0AJ0b2+kS5xsLrztkDSCI2lTCEnIgVgCglaYT
PqMF8IFgjLRiWSD1Pirzx8w=
=cq/y
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
