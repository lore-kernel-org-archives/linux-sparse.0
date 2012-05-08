From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: simplify: conservative handling of casts with pointers
Date: Tue, 08 May 2012 16:13:44 +0200
Message-ID: <4FA92A18.1090208@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep15.mx.upcmail.net ([62.179.121.35]:53050 "EHLO
	fep15.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab2EHON4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 May 2012 10:13:56 -0400
Received: from edge02.upcmail.net ([192.168.13.237])
          by viefep15-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20120508141354.UGJJ18555.viefep15-int.chello.at@edge02.upcmail.net>
          for <linux-sparse@vger.kernel.org>;
          Tue, 8 May 2012 16:13:54 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

When the cast is optimized out/target pointer type information lost,
it may be impossible to for backend to recover it (think of
"struct foo *my_new_foo =3D malloc(sizeof(*my_new_foo))").

Losing such pointer type information can be wider issue (structs and
unions maybe), but this is the most exposed one and the patch tries
to be minimal in this regard and the impact seems to be minimal
too as usually type-correctness is followed.

Annotated demonstration of the change (part of "test-linearize allocate=
=2Ec",
function allocate):

before:

=2EL0x7fd091ecb510:
        load.32     %r76 <- 20[%arg1]
        cast.64     %r78 <- (32) %r76
        call.64     %r79 <- blob_alloc, %r78
>>> no cast, %r79 is generic void *
        br          %r79, .L0x7fd091ecb650, .L0x7fd091ecb600

=2EL0x7fd091ecb600:
        call        die, "out of memory"
        br          .L0x7fd091ecb650

=2EL0x7fd091ecb650:
        load.32     %r85 <- 36[%arg1]
        add.32      %r87 <- %r85, %r76
        store.32    %r87 -> 36[%arg1]
>>> oops, cannot reconstruct what entity is being accessed from 0[%r79]
        store.64    %r30(blob) -> 0[%r79]
>>> in this case, it is unambiguous, but we could be lost easily
        store.64    %r79 -> 8[%arg1]
        add.64      %r98 <- %r28, $15
        [...]

after:

=2EL0x7fab5bc11510:
        load.32     %r76 <- 20[%arg1]
        cast.64     %r78 <- (32) %r76
        call.64     %r79 <- blob_alloc, %r78
>>> this cast from void * is kept, target pointer type preserved
        cast.64     %r80 <- (64) %r79
        br          %r80, .L0x7fab5bc11650, .L0x7fab5bc11600

=2EL0x7fab5bc11600:
        call        die, "out of memory"
        br          .L0x7fab5bc11650

=2EL0x7fab5bc11650:
        load.32     %r85 <- 36[%arg1]
        add.32      %r87 <- %r85, %r76
        store.32    %r87 -> 36[%arg1]
>>> when we know the type of destination, we can reconstruct it
>>> (newblob->next =3D blob)
        store.64    %r30(blob) -> 0[%r80]
>>> and also, based on types + offset, we can infer correct
>>> destination within %arg1 (desc->blobs =3D newblob)
        store.64    %r80 -> 8[%arg1]
        add.64      %r98 <- %r28, $15
        [...]

Signed-off-by: Jan Pokorn=FD <pokorny_jan@seznam.cz>
---
 simplify.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/simplify.c b/simplify.c
index 8200584..3b2b03c 100644
--- a/simplify.c
+++ b/simplify.c
@@ -10,6 +10,7 @@
 #include "expression.h"
 #include "linearize.h"
 #include "flow.h"
+#include "symbol.h"
=20
 /* Find the trivial parent for a phi-source */
 static struct basic_block *phi_parent(struct basic_block *source, pseu=
do_t pseudo)
@@ -667,6 +668,13 @@ static int simplify_cast(struct instruction *insn)
 	orig_type =3D insn->orig_type;
 	if (!orig_type)
 		return 0;
+
+	/* Avoid possible loss of pointer type info (OP_PTRCAST skipped below=
) */
+	if (is_ptr_type(orig_type) !=3D is_ptr_type(insn->type))
+		return 0;  /* non-pointer vs. pointer or viceversa */
+	else if (orig_type->type =3D=3D SYM_PTR && insn->opcode !=3D OP_PTRCA=
ST)
+		return 0;  /* any type from "void *" (see alloc_cast_instruction) */
+
 	orig_size =3D orig_type->bit_size;
 	size =3D insn->size;
 	src =3D insn->src;
--=20
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
