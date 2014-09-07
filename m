From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2] sparse: treat function pointers as pointers to const data
Date: Sun,  7 Sep 2014 14:36:53 +0200
Message-ID: <1410093413-3075-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40429 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaIGMg6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Sep 2014 08:36:58 -0400
Received: by mail-wg0-f44.google.com with SMTP id k14so842552wgh.27
        for <linux-sparse@vger.kernel.org>; Sun, 07 Sep 2014 05:36:56 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org
Cc: will.deacon@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

This code snippet:

static void bar(void const *arg)
{
	int (*foo)(void) = arg;
}

produces the following warning:

test.c:4:28: warning: incorrect type in initializer (different modifiers)
test.c:4:28:    expected int ( *foo )( ... )
test.c:4:28:    got void const *arg

which is caused by the fact that the function pointer 'foo' is not annotated
as being a pointer to const data. However, dereferencing a function pointer
does not produce an lvalue, so a function pointer points to const data by
definition, and we should treat it accordingly.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

OK, so while my v1 did solve the example case, it turns out universally treating
function pointers as pointers to const data produces so much fallout that it
does more harm than good.

Instead, this v2 only addresses function pointer initializers and assignments.

-- 
Ard.


 evaluate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index 66556150ddac..a5a830978bda 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1359,6 +1359,15 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 				typediff = "different address spaces";
 				goto Err;
 			}
+			/*
+			 * If this is a function pointer assignment, it is
+			 * actually fine to assign a pointer to const data to
+			 * it, as a function pointer points to const data
+			 * implicitly, i.e., dereferencing it does not produce
+			 * an lvalue.
+			 */
+			if (b1->type == SYM_FN)
+				mod1 |= MOD_CONST;
 			if (mod2 & ~mod1) {
 				typediff = "different modifiers";
 				goto Err;
-- 
1.8.3.2

