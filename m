From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] cse: update PHI users when throwing away an instruction
Date: Sun, 28 Aug 2011 01:39:58 +0200
Message-ID: <201108280139.59217.kdudka@redhat.com>
References: <4E588EB8.80808@garzik.org> <4E590F22.6030800@garzik.org> <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PBYWOYLugV/Wjhg"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab1H0Xnt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 19:43:49 -0400
In-Reply-To: <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

--Boundary-00=_PBYWOYLugV/Wjhg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 27 August 2011 17:53:23 Linus Torvalds wrote:
> phi2/phi3 are both dead, but theor 'phisrc' instructions haven't been
> killed. Ugly.

The attached patch solves the dangling PHI nodes and does not seem to break 
anything at first glance.  It is probably not the most efficient solution, 
but it might at least show where to look for the problem.

Kamil

--Boundary-00=_PBYWOYLugV/Wjhg
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-cse-update-PHI-users-when-throwing-away-an-instructi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-cse-update-PHI-users-when-throwing-away-an-instructi.patch"

=46rom 7024fcdfba9fce20569f86e2a279c76cb94cbfd8 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Sun, 28 Aug 2011 01:29:13 +0200
Subject: [PATCH] cse: update PHI users when throwing away an instruction


Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 cse.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/cse.c b/cse.c
index 2a15745..1b63c0e 100644
=2D-- a/cse.c
+++ b/cse.c
@@ -250,6 +250,19 @@ static void sort_instruction_list(struct instruction_l=
ist **list)
 static struct instruction * cse_one_instruction(struct instruction *insn, =
struct instruction *def)
 {
 	convert_instruction_target(insn, def->target);
+
+	if (insn->opcode =3D=3D OP_PHI) {
+		/* Remove the instruction from PHI users */
+		pseudo_t phi;
+		FOR_EACH_PTR(insn->phi_list, phi) {
+			struct pseudo_user *pu;
+			FOR_EACH_PTR(phi->users, pu) {
+				if (pu->insn =3D=3D insn)
+					DELETE_CURRENT_PTR(pu);
+			} END_FOR_EACH_PTR(pu);
+		} END_FOR_EACH_PTR(phi);
+	}
+
 	insn->opcode =3D OP_NOP;
 	insn->bb =3D NULL;
 	repeat_phase |=3D REPEAT_CSE;
=2D-=20
1.7.6


--Boundary-00=_PBYWOYLugV/Wjhg--
