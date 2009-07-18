From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] compile-i386: do not generate an infinite loop
Date: Sat, 18 Jul 2009 23:34:10 +0200
Message-ID: <200907182334.10900.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_S/jYKycSIZ/aNhV"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47714 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615AbZGRVeY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:34:24 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6ILYNjU012208
	for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2009 17:34:23 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6ILYNgi030711
	for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2009 17:34:23 -0400
Received: from vpn-10-12.str.redhat.com (vpn-10-12.str.redhat.com [10.32.10.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6ILYLOB024411
	for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2009 17:34:22 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>

--Boundary-00=_S/jYKycSIZ/aNhV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I've probably encountered a bug within compile-i386.c. It generates
an infinite loop for 'while' statement. My testing example and proposed
patch are enclosed.

Kamil

--Boundary-00=_S/jYKycSIZ/aNhV
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="list.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="list.c"

#include <stdlib.h>

typedef void *TItem;

void dispose_list(TItem *list) {
    while (list) {
        TItem *item = list;
        list = (TItem *) *list;
        free(item);
    }
}

--Boundary-00=_S/jYKycSIZ/aNhV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-compile-i386-do-not-generate-an-infinite-loop.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-compile-i386-do-not-generate-an-infinite-loop.patch"

=46rom 60c47d120b577092f0d8fe9001ca6753706dcdbc Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Sat, 18 Jul 2009 23:24:38 +0200
Subject: [PATCH] compile-i386: do not generate an infinite loop

=2D--
 compile-i386.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 37ea52e..abe9313 100644
=2D-- a/compile-i386.c
+++ b/compile-i386.c
@@ -1913,6 +1913,10 @@ static void emit_loop(struct statement *stmt)
=20
 	x86_symbol_decl(stmt->iterator_syms);
 	x86_statement(pre_statement);
+	if (!post_condition || post_condition->type !=3D EXPR_VALUE || post_condi=
tion->value) {
+		loop_top =3D new_label();
+		emit_label(loop_top, "loop top");
+	}
 	if (pre_condition) {
 		if (pre_condition->type =3D=3D EXPR_VALUE) {
 			if (!pre_condition->value) {
@@ -1936,10 +1940,6 @@ static void emit_loop(struct statement *stmt)
 			insn("jz", lbv, NULL, NULL);
 		}
 	}
=2D	if (!post_condition || post_condition->type !=3D EXPR_VALUE || post_con=
dition->value) {
=2D		loop_top =3D new_label();
=2D		emit_label(loop_top, "loop top");
=2D	}
 	x86_statement(statement);
 	if (stmt->iterator_continue->used)
 		emit_label(loop_continue, "'continue' iterator");
=2D-=20
1.6.3.3


--Boundary-00=_S/jYKycSIZ/aNhV--
