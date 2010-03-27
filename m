From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] eliminate insane conversions from int to enum
Date: Sat, 27 Mar 2010 10:53:46 +0100
Message-ID: <201003271053.47206.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003271016.39291.kdudka@redhat.com> <20100327092949.GB9548@feather>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rWdrLJTd/Cu0I5l"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24105 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab0C0J4C (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Mar 2010 05:56:02 -0400
In-Reply-To: <20100327092949.GB9548@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

--Boundary-00=_rWdrLJTd/Cu0I5l
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 27 of March 2010 10:29:50 Josh Triplett wrote:
> > Here is what sparse gives:
> > $ ./sparse enum.c
> > enum.c:1:10: warning: non-ANSI function declaration of function 'main'
> > enum.c:6:15: warning: conversion of
> > enum.c:6:15:     int to
> > enum.c:6:15:     int enum <noident>
> >
> >
> > Here is what g++ gives:
> > $ g++ enum.c
> > enum.c: In function =E2=80=98int main()=E2=80=99:
> > enum.c:6: error: invalid conversion from =E2=80=98int=E2=80=99 to =E2=
=80=98main()::<anonymous
> > enum>=E2=80=99
>
> Yup, both of these warnings seem correct.  Don't fix them by casting,
> fix them by declaring "val" with an appropriate integral type.

patch attached

Kamil

--Boundary-00=_rWdrLJTd/Cu0I5l
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-eliminate-insane-conversions-from-int-to-enum.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-eliminate-insane-conversions-from-int-to-enum.patch"

=46rom 44d964b9479affff31ad5690bedfe580ee3b50fa Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Sat, 27 Mar 2010 10:48:34 +0100
Subject: [PATCH] eliminate insane conversions from int to enum


Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 expression.h |    1 -
 parse.c      |    2 +-
 parse.h      |    2 ++
 symbol.c     |    4 ++--
 symbol.h     |    8 ++++----
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/expression.h b/expression.h
index 81f70ad..fe08a5f 100644
=2D-- a/expression.h
+++ b/expression.h
@@ -206,7 +206,6 @@ static inline int lookup_type(struct token *token)
 }
=20
 /* Statement parsing */
=2Dstruct statement *alloc_statement(struct position pos, int type);
 struct token *initializer(struct expression **tree, struct token *token);
 struct token *compound_statement(struct token *, struct statement *);
=20
diff --git a/parse.c b/parse.c
index 7c6dce7..adaa132 100644
=2D-- a/parse.c
+++ b/parse.c
@@ -613,7 +613,7 @@ static int SENTINEL_ATTR match_idents(struct token *tok=
en, ...)
 }
=20
=20
=2Dstruct statement *alloc_statement(struct position pos, int type)
+struct statement *alloc_statement(struct position pos, enum statement_type=
 type)
 {
 	struct statement *stmt =3D __alloc_statement(0);
 	stmt->type =3D type;
diff --git a/parse.h b/parse.h
index 02b8585..6d51726 100644
=2D-- a/parse.h
+++ b/parse.h
@@ -115,6 +115,8 @@ struct statement {
 	};
 };
=20
+struct statement *alloc_statement(struct position pos, enum statement_type=
 type);
+
 extern struct symbol_list *function_computed_target_list;
 extern struct statement_list *function_computed_goto_list;
=20
diff --git a/symbol.c b/symbol.c
index 96dfbfa..8c46e20 100644
=2D-- a/symbol.c
+++ b/symbol.c
@@ -39,12 +39,12 @@ void access_symbol(struct symbol *sym)
 	}
 }
=20
=2Dstruct symbol *lookup_symbol(struct ident *ident, enum namespace ns)
+struct symbol *lookup_symbol(struct ident *ident, int ns_mask)
 {
 	struct symbol *sym;
=20
 	for (sym =3D ident->symbols; sym; sym =3D sym->next_id) {
=2D		if (sym->namespace & ns) {
+		if (sym->namespace & ns_mask) {
 			sym->used =3D 1;
 			return sym;
 		}
diff --git a/symbol.h b/symbol.h
index e567305..7921aa1 100644
=2D-- a/symbol.h
+++ b/symbol.h
@@ -97,7 +97,7 @@ struct decl_state {
 };
=20
 struct symbol_op {
=2D	enum keyword type;
+	int type;
 	int (*evaluate)(struct expression *);
 	int (*expand)(struct expression *, int);
 	int (*args)(struct expression *);
@@ -267,7 +267,7 @@ extern void access_symbol(struct symbol *);
 extern const char * type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long mod1, unsigned long mod2);
=20
=2Dextern struct symbol *lookup_symbol(struct ident *, enum namespace);
+extern struct symbol *lookup_symbol(struct ident *, int ns_mask);
 extern struct symbol *create_symbol(int stream, const char *name, int type=
, int namespace);
 extern void init_symbols(void);
 extern void init_ctype(void);
@@ -367,11 +367,11 @@ static inline int get_sym_type(struct symbol *type)
 	return type->type;
 }
=20
=2Dstatic inline struct symbol *lookup_keyword(struct ident *ident, enum na=
mespace ns)
+static inline struct symbol *lookup_keyword(struct ident *ident, int ns_ma=
sk)
 {
 	if (!ident->keyword)
 		return NULL;
=2D	return lookup_symbol(ident, ns);
+	return lookup_symbol(ident, ns_mask);
 }
=20
 #define is_restricted_type(type) (get_sym_type(type) =3D=3D SYM_RESTRICT)
=2D-=20
1.7.0.2


--Boundary-00=_rWdrLJTd/Cu0I5l--
