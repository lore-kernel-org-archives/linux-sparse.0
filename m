From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 19:27:46 +0200
Message-ID: <200908061927.47201.kdudka@redhat.com>
References: <200908061102.14935.kdudka@redhat.com> <154e089b0908060409v4dff4785x456b5aad2460ed84@mail.gmail.com> <70318cbf0908061010w737ac3d7j1feb1f9744217df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TKxeKQDGjWT5c1A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:45989 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755959AbZHFR2l (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 13:28:41 -0400
In-Reply-To: <70318cbf0908061010w737ac3d7j1feb1f9744217df7@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Hannes Eder <hannes@hanneseder.net>, sparse <linux-sparse@vger.kernel.org>

--Boundary-00=_TKxeKQDGjWT5c1A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 06 of August 2009 19:10:30 Christopher Li wrote:
> I would just apply the change to the header file and related variables.
> The linearize.h is consider an API header file for other sparse application
> to use. So we'd better not assume too much on the sparse caller side.
>
> I agree with Kamil that rename variable in linearize.c offer no real
> benefits. I consider it more of a personal preference thing. And it is
> internal to linearize.c. At this point renaming variable will mess up with
> annotations. It is not good enough reason to do it just to make
> the editor happy.

Well, let's make a tradeoff - we can only change the identifiers
in linearize.h and the corresponding identifiers in linearize.c. I admit it 
could be confusing when we have different identifiers in the prototype and 
different identifiers in the function body. New version of the patch is 
attached.

Kamil

--Boundary-00=_TKxeKQDGjWT5c1A
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-linearize.h-sanitize-header.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-linearize.h-sanitize-header.patch"

=46rom 4d4c71eb876351d53e0f8edf0f121950ec2a9a84 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Thu, 6 Aug 2009 19:20:51 +0200
Subject: [PATCH] linearize.h: sanitize header

It's unfortunate to use 'true' and 'false' as identifiers in a system
header. It clashes with corresponding macros from <stdbool.h> when
included before <sparse/linearize.h>.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 linearize.c |    6 +++---
 linearize.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1a19214..238ee5d 100644
=2D-- a/linearize.c
+++ b/linearize.c
@@ -666,7 +666,7 @@ void insert_branch(struct basic_block *bb, struct instr=
uction *jmp, struct basic
 }
 =09
=20
=2Dvoid insert_select(struct basic_block *bb, struct instruction *br, struc=
t instruction *phi_node, pseudo_t true, pseudo_t false)
+void insert_select(struct basic_block *bb, struct instruction *br, struct =
instruction *phi_node, pseudo_t if_true, pseudo_t if_false)
 {
 	pseudo_t target;
 	struct instruction *select;
@@ -685,8 +685,8 @@ void insert_select(struct basic_block *bb, struct instr=
uction *br, struct instru
 	select->target =3D target;
 	target->def =3D select;
=20
=2D	use_pseudo(select, true, &select->src2);
=2D	use_pseudo(select, false, &select->src3);
+	use_pseudo(select, if_true, &select->src2);
+	use_pseudo(select, if_false, &select->src3);
=20
 	add_instruction(&bb->insns, select);
 	add_instruction(&bb->insns, br);
diff --git a/linearize.h b/linearize.h
index 2205082..50b3601 100644
=2D-- a/linearize.h
+++ b/linearize.h
@@ -328,7 +328,7 @@ struct entrypoint {
 	struct instruction *entry;
 };
=20
=2Dextern void insert_select(struct basic_block *bb, struct instruction *br=
, struct instruction *phi, pseudo_t true, pseudo_t false);
+extern void insert_select(struct basic_block *bb, struct instruction *br, =
struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, =
struct basic_block *target);
=20
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size);
=2D-=20
1.6.3.3


--Boundary-00=_TKxeKQDGjWT5c1A--
