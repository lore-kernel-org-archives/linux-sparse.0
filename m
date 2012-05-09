From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH] simplify: conservative handling of casts with pointers
Date: Wed, 09 May 2012 13:00:26 +0200
Message-ID: <4FAA4E4A.8000409@seznam.cz>
References: <4FA92A18.1090208@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep19.mx.upcmail.net ([62.179.121.39]:47584 "EHLO
	fep19.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2EILAh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 May 2012 07:00:37 -0400
Received: from edge04.upcmail.net ([192.168.13.239])
          by viefep19-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20120509110035.KXTM22594.viefep19-int.chello.at@edge04.upcmail.net>
          for <linux-sparse@vger.kernel.org>;
          Wed, 9 May 2012 13:00:35 +0200
In-Reply-To: <4FA92A18.1090208@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 05/08/2012 04:13 PM, Jan Pokorn=FD wrote:
> When the cast is optimized out/target pointer type information lost,
> it may be impossible for backend to recover it (think of
> "struct foo *my_new_foo =3D malloc(sizeof(*my_new_foo))").
>
> Losing such pointer type information can be wider issue (structs and
> unions maybe), but this is the most exposed one and the patch tries
> to be minimal in this regard and the impact seems to be minimal
> too as usually type-correctness is followed.

I expected that if both operands of the cast appear to be pointers, it =
is
always OP_PTRCAST case, which is not true.

So this version exchanges inequality test for "or".  Beside being
shorter, it covers such previously missed cases.

Based on asserts I experimented with, OP_PTRCASTs are always captured
by the condition implicitly (beside OP_CASTs with pointer-like operands=
).

Signed-off-by: Jan Pokorn=FD <pokorny_jan@seznam.cz>
---
 simplify.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/simplify.c b/simplify.c
index 8200584..bda4a5b 100644
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
@@ -667,6 +668,11 @@ static int simplify_cast(struct instruction *insn)
 	orig_type =3D insn->orig_type;
 	if (!orig_type)
 		return 0;
+
+	/* Keep casts with pointer on either side (not only case of OP_PTRCAS=
T) */
+	if (is_ptr_type(orig_type) || is_ptr_type(insn->type))
+		return 0;
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
