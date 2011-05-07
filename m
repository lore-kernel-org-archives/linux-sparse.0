From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] evaluate: Allow sizeof(_Bool) to succeed.
Date: Sat, 7 May 2011 13:37:04 -0700
Message-ID: <BANLkTikHwADf5Kv5=rQosKcNjsMYM-28wQ@mail.gmail.com>
References: <1304552394-16280-1-git-send-email-blp@nicira.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48129 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1EGUhG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 7 May 2011 16:37:06 -0400
Received: by wwa36 with SMTP id 36so4560606wwa.1
        for <linux-sparse@vger.kernel.org>; Sat, 07 May 2011 13:37:04 -0700 (PDT)
In-Reply-To: <1304552394-16280-1-git-send-email-blp@nicira.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ben Pfaff <blp@nicira.com>
Cc: linux-sparse@vger.kernel.org

On Wed, May 4, 2011 at 4:39 PM, Ben Pfaff <blp@nicira.com> wrote:
> Without this commit, sizeof(_Bool) provokes an error with "cannot siz=
e
> expression" because _Bool is a 1-bit type and thus not a multiple of =
a full
> byte in size. =A0But sizeof(_Bool) is valid C that should evaluate to=
 1, so
> this commit fixes the problem and adds a regression test.

Thanks for the patch.

The sizeof _Bool is implementation define. Gcc make sizeof(_Bool) as 1.
I modify your patch to issue an warning. Applied and pushed.

The incremental change follows. Please check that works for you or not.

Chris

diff --git a/evaluate.c b/evaluate.c
index f196dbc..1309001 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2028,14 +2028,18 @@ static struct symbol *evaluate_sizeof(struct
expression *expr)
 		size =3D bits_in_char;
 	}

+	if (size =3D=3D 1 && is_bool_type(type)) {
+		warning(expr->pos, "expression using sizeof bool");
+		size =3D bits_in_char;
+	}
+
 	if (is_function(type->ctype.base_type)) {
 		warning(expr->pos, "expression using sizeof on a function");
 		size =3D bits_in_char;
 	}

-	if (is_bool_type(type))
-		size =3D bits_in_char;
-	else if ((size < 0) || (size & (bits_in_char - 1)))
+
+	if ((size < 0) || (size & (bits_in_char - 1)))
 		expression_error(expr, "cannot size expression");

 	expr->type =3D EXPR_VALUE;
diff --git a/validation/sizeof-bool.c b/validation/sizeof-bool.c
index dfcb12a..6c68748 100644
--- a/validation/sizeof-bool.c
+++ b/validation/sizeof-bool.c
@@ -6,4 +6,7 @@ static int a(void)
  * check-name: sizeof(_Bool) is valid
  * check-description: sizeof(_Bool) was rejected because _Bool is not =
an even
  * number of bytes
+ * check-error-start
+sizeof-bool.c:3:16: warning: expression using sizeof bool
+ * check-error-end
  */
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
