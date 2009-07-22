From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 19:02:48 +0200
Message-ID: <200907221902.49184.kdudka@redhat.com>
References: <200907182334.10900.kdudka@redhat.com> <70318cbf0907220939s48bcfd3fi20ae9fda1edd290@mail.gmail.com> <4A674382.9090807@garzik.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5Y0ZKv2VUdbX7Fr"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:59084 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbZGVREI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 13:04:08 -0400
In-Reply-To: <4A674382.9090807@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

--Boundary-00=_5Y0ZKv2VUdbX7Fr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 22 of July 2009 18:51:14 Jeff Garzik wrote:
> Christopher Li wrote:
> > Oh one last thing. I need a signed-off line from you.
>
> I think sparse needs some text document, describing what Signed-off-by
> means.  I did this in one of my own projects by copying the relevant
> "DCO" from kernel tree's Documentation/SubmittingPatches.

Thanks! I was just looking for some info about "Signed-off-by"...

The signed-off patch is attached.

Kamil

--Boundary-00=_5Y0ZKv2VUdbX7Fr
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-compile-i386-do-not-generate-infinite-loop.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-compile-i386-do-not-generate-infinite-loop.patch"

=46rom 984e2612d2174390a54a36a805051c3f66cf6250 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Sat, 18 Jul 2009 23:16:53 +0200
Subject: [PATCH] compile-i386: do not generate infinite loop

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
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


--Boundary-00=_5Y0ZKv2VUdbX7Fr--
