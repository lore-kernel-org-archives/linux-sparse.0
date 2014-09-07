From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] sparse: treat function pointers as pointers to const data
Date: Sun,  7 Sep 2014 13:37:39 +0200
Message-ID: <1410089859-22957-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:44611 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaIGLhp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Sep 2014 07:37:45 -0400
Received: by mail-wg0-f51.google.com with SMTP id l18so13685434wgh.22
        for <linux-sparse@vger.kernel.org>; Sun, 07 Sep 2014 04:37:43 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
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
 evaluate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index 66556150ddac..6428312f3e61 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -794,6 +794,14 @@ static unsigned long target_qualifiers(struct symbol *type)
 	unsigned long mod = type->ctype.modifiers & MOD_IGN;
 	if (type->ctype.base_type && type->ctype.base_type->type == SYM_ARRAY)
 		mod = 0;
+
+	/*
+	 * Dereferencing a function pointer does not produce an lvalue,
+	 * which means its target is implicitly 'const', and assigning
+	 * a pointer-to-const value to it is ok.
+	 */
+	if (type->ctype.base_type && type->ctype.base_type->type == SYM_FN)
+		mod |= MOD_CONST;
 	return mod;
 }
 
-- 
1.8.3.2

