From: Martin Nagy <mnagy@redhat.com>
Subject: Re: [PATCH] Print an error if typeof() lacks an argument
Date: Mon, 27 Apr 2009 11:15:37 +0200
Message-ID: <20090427111537.17956e38@notas>
References: <20090425130343.3df87cbb@notas>
	<70318cbf0904262338g698eb2g7265b472fb0efd46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/DjJAOzmV8uyxb1jDOCEXGoF"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:60899 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbZD0JPn (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 05:15:43 -0400
In-Reply-To: <70318cbf0904262338g698eb2g7265b472fb0efd46@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

--MP_/DjJAOzmV8uyxb1jDOCEXGoF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Christopher Li wrote:
> On Sat, Apr 25, 2009 at 4:03 AM, Martin Nagy <mnagy@redhat.com> wrote:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct expression *expr;
>=20
> I think you want expr =3D NULL here. Otherwise if(expr) will pick up crap.

Right. I somehow assumed that parse_expression() will set it to NULL in
case there is not any expression. I attached a new patch which fixes
this.

> I would just add two lines after "token =3D
> parse_expression(token->next, &typeof_sym->initializer);"
>=20
> if (!type->initializer)
>         sparse_error(token->pos, "expected expression after the '(' token=
");
>=20
> If there is compile error, the sparse should not continue the later
> stage any way.

That won't work. sparse_error() will not exit, and sparse will still
segfault later, so we have to return from the function. You could
instead do something like this:

if (!typeof_sym->initializer) {
	sparse_error(token->pos, "expected ...");
	return expect(token, ')', "after typeof");
}

Or use a goto to jump to the return statement. In any case, I didn't
want to repeat the code and cause a memory leak. And I didn't want to
use a goto. I guess that it's ultimately a matter of style. If you
think the memory leak would be acceptable I can rework the patch again.
The leak would only occur in this specific case, so I guess maybe it
would be acceptable, but I wasn't sure so I rather went with this
approach.

> BTW, can you add a validation test case which will trigger the bug?

Yup, it's in the new patch.

Martin

--MP_/DjJAOzmV8uyxb1jDOCEXGoF
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-Print-an-error-if-typeof-lacks-an-argument.patch

From bbd2e88cdd9d36d47ce50204d18547e08f2e2bea Mon Sep 17 00:00:00 2001
From: Martin Nagy <nagy.martin@gmail.com>
Date: Mon, 27 Apr 2009 10:48:50 +0200
Subject: [PATCH] Print an error if typeof() lacks an argument

We weren't checking if the initializer isn't NULL, which caused sparse
to segfault later on when performing lazy evaluation in classify_type().

Signed-off-by: Martin Nagy <nagy.martin@gmail.com>
---
 parse.c                 |   17 +++++++++++------
 validation/bad-typeof.c |   15 +++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 validation/bad-typeof.c

diff --git a/parse.c b/parse.c
index 9662122..604e528 100644
--- a/parse.c
+++ b/parse.c
@@ -924,12 +924,17 @@ static struct token *typeof_specifier(struct token *token, struct decl_state *ct
 		ctx->ctype.base_type = sym->ctype.base_type;
 		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
 	} else {
-		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
-		token = parse_expression(token->next, &typeof_sym->initializer);
-
-		typeof_sym->endpos = token->pos;
-		ctx->ctype.base_type = typeof_sym;
-	}		
+		struct expression *expr = NULL;
+		token = parse_expression(token->next, &expr);
+		if (expr) {
+			struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
+			typeof_sym->endpos = token->pos;
+			typeof_sym->initializer = expr;
+			ctx->ctype.base_type = typeof_sym;
+		} else {
+			sparse_error(token->pos, "expected expression after the '(' token");
+		}
+	}
 	return expect(token, ')', "after typeof");
 }
 
diff --git a/validation/bad-typeof.c b/validation/bad-typeof.c
new file mode 100644
index 0000000..5c27de4
--- /dev/null
+++ b/validation/bad-typeof.c
@@ -0,0 +1,15 @@
+static int fun(void)
+{
+	typeof() a;
+	int b;
+
+	a = b;
+}
+/*
+ * check-name: Bad typeof syntax segfault
+ *
+ * check-error-start
+bad-typeof.c:3:16: error: expected expression after the '(' token
+bad-typeof.c:6:9: error: identifier 'a' has no type
+ * check-error-end
+ */
-- 
1.6.0.6


--MP_/DjJAOzmV8uyxb1jDOCEXGoF--
