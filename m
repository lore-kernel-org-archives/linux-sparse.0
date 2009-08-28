From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] do not ignore attribute 'noreturn'...
Date: Fri, 28 Aug 2009 23:30:08 +0200
Message-ID: <200908282330.08332.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gxEmKKPvnGlLNOK"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbZH1VbA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 28 Aug 2009 17:31:00 -0400
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7SLV2iE020875
	for <linux-sparse@vger.kernel.org>; Fri, 28 Aug 2009 17:31:02 -0400
Received: from vpn2-8-236.ams2.redhat.com (vpn2-8-236.ams2.redhat.com [10.36.8.236])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7SLV1va001956
	for <linux-sparse@vger.kernel.org>; Fri, 28 Aug 2009 17:31:02 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--Boundary-00=_gxEmKKPvnGlLNOK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

enclosed is a simple patch adding support for attribute 'noreturn' to the 
parser. The enhancement makes it possible to optimize walk through CFG and 
thus help us to fight with the state explosion. The benefit is demonstrated 
on a simple real-world example.

Generated CFG before patch:
http://dudka.cz/devel/html/slsparse-before/slplug.c-handle_stmt_assign.svg

Generated CFG after patch:
http://dudka.cz/devel/html/slsparse-after/slplug.c-handle_stmt_assign.svg

It's one of the key features I am currently missing in SPARSE in contrast
to gcc used as parser. Thanks in advance for considering it!

Kamil

--Boundary-00=_gxEmKKPvnGlLNOK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-do-not-ignore-attribute-noreturn.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-do-not-ignore-attribute-noreturn.patch"

=46rom 892f19915cbcbe26b3a7ad2c3baf1a1420f3c954 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Fri, 28 Aug 2009 21:49:16 +0200
Subject: [PATCH] do not ignore attribute 'noreturn'...

=2E.. and thus make it possible to optimize walk through CFG.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 parse.c  |    4 ++--
 symbol.h |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index e5ad867..215c4da 100644
=2D-- a/parse.c
+++ b/parse.c
@@ -480,8 +480,8 @@ static struct init_keyword {
 	{ "const",	NS_KEYWORD,	.op =3D &ignore_attr_op },
 	{ "__const",	NS_KEYWORD,	.op =3D &ignore_attr_op },
 	{ "__const__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
=2D	{ "noreturn",	NS_KEYWORD,	.op =3D &ignore_attr_op },
=2D	{ "__noreturn__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
+	{ "noreturn",	NS_KEYWORD,	MOD_NORETURN,	.op =3D &attr_mod_op },
+	{ "__noreturn__",	NS_KEYWORD,	MOD_NORETURN,	.op =3D &attr_mod_op },
 	{ "no_instrument_function",	NS_KEYWORD,	.op =3D &ignore_attr_op },
 	{ "__no_instrument_function__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
 	{ "sentinel",	NS_KEYWORD,	.op =3D &ignore_attr_op },
diff --git a/symbol.h b/symbol.h
index 42d69d6..d8d1793 100644
=2D-- a/symbol.h
+++ b/symbol.h
@@ -216,6 +216,8 @@ struct symbol {
 #define MOD_EXPLICITLY_SIGNED	0x40000000
 #define MOD_BITWISE	0x80000000
=20
+#define MOD_NORETURN	0x100000000
+
 #define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
 #define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | M=
OD_INLINE | MOD_TOPLEVEL)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
@@ -223,7 +225,7 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
=2D#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STO=
RAGE)
+#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORA=
GE | MOD_NORETURN)
=20
=20
 /* Current parsing/evaluation function */
=2D-=20
1.6.4.1


--Boundary-00=_gxEmKKPvnGlLNOK--
