From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 13:53:17 +0200
Message-ID: <200909021353.17091.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200909012359.09678.kdudka@redhat.com> <20090901232433.GC3947@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tylnKa6rSwfzfrh"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbZIBLxr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 07:53:47 -0400
In-Reply-To: <20090901232433.GC3947@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Stephen Hemminger <shemminger@vyatta.com>
Cc: linux-sparse@vger.kernel.org

--Boundary-00=_tylnKa6rSwfzfrh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Well, let's go for the second iteration...

On Wed September 2 2009 01:24:33 Josh Triplett wrote:
> warnings:
> > static void foo(void) {
> >     enum ENUM_TYPE_A { VALUE_A } var_a;
> >     enum ENUM_TYPE_B { VALUE_B } var_b;
> >     enum /* anon. */ { VALUE_C } anon_enum_var;
> >     int i;
> >
> >     // always OK
> >     var_a = VALUE_A;
> >     var_a = (enum ENUM_TYPE_A) VALUE_B;
> >     var_b = (enum ENUM_TYPE_B) i;
> >     i = (int) VALUE_A;
>
> Fair enough; a cast should indeed make the warning go away.  Good catch
> to include the case of casting an enum value to a different enum type.
> I'd also suggest including some casts of values like 0 in the "always
> OK" section:
>
>     var_a = (enum ENUM_TYPE_B) 0;

This is IMO not "always OK":
warning: mixing different enum types
    int enum ENUM_TYPE_B  versus
    int enum ENUM_TYPE_A

Why should we have an exception for zero? Then we would not distinguish 
between VALUE_A and VALUE_B? This needs some justification. Have you 
considered the case that zero is even not valid at all for an enum?

> >     i = VALUE_B;
>
> Why does this not generate a warning with Wenum-to-int?  You should have
> to cast VALUE_B to int.

I was not sure if this is actually useful ... now it does.

> >     // caught by -Wint-to-enum (default)
> >     var_a = VALUE_B;
> >     var_b = VALUE_C;
> >     anon_enum_var = VALUE_A;
>
> Why does Wenum-mismatch not catch these?  Because it treats those
> constants as ints?  Regardless of the cause, this seems wrong.  If you
> explicitly declare a variable with enum type, assigning the wrong enum
> constant to it should generate a enum-mismatch warning, not an

Well, now caught by -Wenum-mismatch instead.

> int-to-enum warning.  However, I understand if this proves hard to fix,
> and generating *some* warning seems like an improvement over the current
> behavior of generating *no* warning.

Nope, it's easy to fix if you don't care about the change in behavior
of -Wenum-mismatch.

> >     var_a = 0;
> >     var_b = i;
> >     anon_enum_var = 0;
> >     anon_enum_var = i;
>
> I'd also suggest including tests with enum constants casted to integers:
>
>     var_a = (int) VALUE_A;
>     var_a = (int) VALUE_B;

Added.

> > --- a/sparse.1
> > +++ b/sparse.1
> > @@ -149,6 +149,18 @@ Sparse issues these warnings by default.  To turn
> > them off, use \fB\-Wno\-enum\-mismatch\fR.
> >  .
> >  .TP
> > +.B \-Wenum\-to\-int
> > +Warn about casting of an \fBenum\fR type to int and thus possible lost
> > of +information about the type.
>
> This should not say "warn about casting", because it specifically
> *doesn't* warn about casting.  s/casting of/converting/.
>
> I don't think "possible loss of information" seems like the reason to
> care about this warning.  These warnings just represent ways of getting
> sparse to make you treat enums as distinct types from int.  I'd suggest
> dropping the second half of the sentence.
>
> I'd also suggest adding something like "An explicit cast to int will
> suppress this warning.".

Fixed.

> > +.TP
> > +.B \-Wint\-to\-enum
> > +Warn about casting of int (or incompatible enumeration constant) to
> > \fBenum\fR.
>
> OK, so the test represents *documented* behavior, but it still doesn't
> seem right. :)  The "(or incompatible enumeration constant)" bit seems
> like it should become part of Wenum-mismatch.
>
> Or if necessary, perhaps part of some new flag, like
> Wenum-constant-mismatch, but that seems like overkill.
>
> s/casting of/converting/, as above.
>
> I'd also suggest adding "An explicit cast to the enum type will suppress
> this warning.".

Fixed.

I would really appreciate some native (or native like) speaker willing to 
reword my man page attempts completely. Any volunteer around? :-)

On Wed September 2 2009 02:27:08 Stephen Hemminger wrote:
> there is lots of code that does:
>
> enum {
>    my_register_1   = 0x001,
>    my_register_2   = 0x002,
> };
>
>
> foo(void) {
>    write_register(my_register_1, SETUP_VAL_X);
> ...
>
> So going from enum to int must be optional, but int to enum should
> trigger a warning.

This should be already working. If this is not the case, please write me
an minimal example along with the expected result. I'll take care of it...

> I'll give it a pass on the kernel for giggles.

Great!

Kamil

--Boundary-00=_tylnKa6rSwfzfrh
Content-Type: text/x-patch;
  charset="utf-8";
  name="0001-add-warnings-enum-to-int-and-int-to-enum.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-add-warnings-enum-to-int-and-int-to-enum.patch"

=46rom 381f635e581c3d346ae47672dc7be1423b681924 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Wed, 2 Sep 2009 13:17:57 +0200
Subject: [PATCH] add warnings enum-to-int and int-to-enum...

=2E.. and improve detection of the enum-mismatch warning

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 evaluate.c   |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++----=
=2D---
 expression.h |    1 +
 lib.c        |    4 ++
 lib.h        |    2 +
 parse.c      |    1 +
 sparse.1     |   13 ++++++++
 6 files changed, 106 insertions(+), 13 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 805ae90..dfb7a0d 100644
=2D-- a/evaluate.c
+++ b/evaluate.c
@@ -235,27 +235,94 @@ static int is_same_type(struct expression *expr, stru=
ct symbol *new)
 }
=20
 static void
=2Dwarn_for_different_enum_types (struct position pos,
=2D			       struct symbol *typea,
=2D			       struct symbol *typeb)
+resolve_sym_node (struct symbol **psym)
 {
+	struct symbol *sym =3D *psym;
+	if (sym->type =3D=3D SYM_NODE)
+		*psym =3D sym->ctype.base_type;
+}
+
+static void
+warn_for_different_enum_types (struct position pos, struct symbol *typea,
+			       struct symbol *typeb, struct symbol *enum_type)
+{
+	enum type ttypea;
 	if (!Wenum_mismatch)
 		return;
=2D	if (typea->type =3D=3D SYM_NODE)
=2D		typea =3D typea->ctype.base_type;
=2D	if (typeb->type =3D=3D SYM_NODE)
=2D		typeb =3D typeb->ctype.base_type;
+
+	resolve_sym_node(&typea);
+	resolve_sym_node(&typeb);
=20
 	if (typea =3D=3D typeb)
 		return;
+	if (typeb->type !=3D SYM_ENUM)
+		return;
=20
=2D	if (typea->type =3D=3D SYM_ENUM && typeb->type =3D=3D SYM_ENUM) {
+	ttypea =3D typea->type;
+	if (ttypea =3D=3D SYM_ENUM || (ttypea =3D=3D SYM_BASETYPE
+					&& enum_type && enum_type !=3D typeb))
+	{
 		warning(pos, "mixing different enum types");
=2D		info(pos, "    %s versus", show_typename(typea));
+		info(pos, "    %s versus", show_typename((ttypea =3D=3D SYM_ENUM)
+					? typea
+					: enum_type));
 		info(pos, "    %s", show_typename(typeb));
 	}
 }
=20
+static void
+issue_conversion_warning(struct position pos,
+			 struct symbol *typea,
+			 struct symbol *typeb)
+{
+	warning(pos, "conversion of");
+	info(pos, "    %s to", show_typename(typea));
+	info(pos, "    %s", show_typename(typeb));
+}
+
+static void
+warn_for_enum_to_int_cast (struct expression *expr, struct symbol *typeb)
+{
+	struct position pos =3D expr->pos;
+	struct symbol *typea =3D expr->ctype;
+	struct symbol *enum_type =3D expr->enum_type;
+
+	if (!Wenum_to_int)
+		return;
+
+	resolve_sym_node(&typea);
+	resolve_sym_node(&typeb);
+
+	if (typeb->type !=3D SYM_BASETYPE)
+		return;
+
+	if (typea->type =3D=3D SYM_ENUM && typea->ident)
+		issue_conversion_warning(pos, typea, typeb);
+
+	if (typea->type =3D=3D SYM_BASETYPE && enum_type && enum_type->ident)
+		issue_conversion_warning(pos, enum_type, typeb);
+}
+
+static void
+warn_for_int_to_enum_cast (struct expression *expr, struct symbol *typeb)
+{
+	struct position pos =3D expr->pos;
+	struct symbol *typea =3D expr->ctype;
+	struct symbol *enum_type =3D expr->enum_type;
+
+	if (!Wint_to_enum)
+		return;
+
+	resolve_sym_node(&typea);
+	resolve_sym_node(&typeb);
+
+	if (typea->type !=3D SYM_BASETYPE || typeb->type !=3D SYM_ENUM)
+		return;
+
+	if (!enum_type)
+		issue_conversion_warning(pos, typea, typeb);
+}
+
 /*
  * This gets called for implicit casts in assignments and
  * integer promotion. We often want to try to move the
@@ -267,7 +334,10 @@ static struct expression * cast_to(struct expression *=
old, struct symbol *type)
 {
 	struct expression *expr;
=20
=2D	warn_for_different_enum_types (old->pos, old->ctype, type);
+	warn_for_different_enum_types (old->pos, old->ctype, type,
+				       old->enum_type);
+	warn_for_enum_to_int_cast (old, type);
+	warn_for_int_to_enum_cast (old, type);
=20
 	if (old->ctype !=3D &null_ctype && is_same_type(old, type))
 		return old;
@@ -287,7 +357,7 @@ static struct expression * cast_to(struct expression *o=
ld, struct symbol *type)
 		break;
=20
 	case EXPR_IMPLIED_CAST:
=2D		warn_for_different_enum_types(old->pos, old->ctype, type);
+		warn_for_different_enum_types(old->pos, old->ctype, type, NULL);
=20
 		if (old->ctype->bit_size >=3D type->bit_size) {
 			struct expression *orig =3D old->cast_expression;
@@ -498,7 +568,8 @@ static struct symbol *usual_conversions(int op,
 {
 	struct symbol *ctype;
=20
=2D	warn_for_different_enum_types(right->pos, left->ctype, right->ctype);
+	warn_for_different_enum_types(right->pos, left->ctype, right->ctype,
+				      NULL);
=20
 	if ((lclass | rclass) & TYPE_RESTRICT)
 		goto Restr;
@@ -3241,7 +3312,8 @@ static void check_case_type(struct expression *switch=
_expr,
 		goto Bad;
 	if (enumcase) {
 		if (*enumcase)
=2D			warn_for_different_enum_types(case_expr->pos, case_type, (*enumcase)-=
>ctype);
+			warn_for_different_enum_types(case_expr->pos, case_type,
+						      (*enumcase)->ctype, NULL);
 		else if (is_enum_type(case_type))
 			*enumcase =3D case_expr;
 	}
diff --git a/expression.h b/expression.h
index 631224f..81f70ad 100644
=2D-- a/expression.h
+++ b/expression.h
@@ -70,6 +70,7 @@ struct expression {
 		struct {
 			unsigned long long value;
 			unsigned taint;
+			struct symbol *enum_type;
 		};
=20
 		// EXPR_FVALUE
diff --git a/lib.c b/lib.c
index 600939b..2f78bd5 100644
=2D-- a/lib.c
+++ b/lib.c
@@ -199,6 +199,8 @@ int Wdecl =3D 1;
 int Wdefault_bitfield_sign =3D 0;
 int Wdo_while =3D 0;
 int Wenum_mismatch =3D 1;
+int Wenum_to_int =3D 0;
+int Wint_to_enum =3D 1;
 int Wnon_pointer_null =3D 1;
 int Wold_initializer =3D 1;
 int Wone_bit_signed_bitfield =3D 1;
@@ -380,6 +382,8 @@ static const struct warning {
 	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
+	{ "enum-to-int", &Wenum_to_int },
+	{ "int-to-enum", &Wint_to_enum },
 	{ "non-pointer-null", &Wnon_pointer_null },
 	{ "old-initializer", &Wold_initializer },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
diff --git a/lib.h b/lib.h
index b22fa93..962d49d 100644
=2D-- a/lib.h
+++ b/lib.h
@@ -96,6 +96,8 @@ extern int Wdecl;
 extern int Wdefault_bitfield_sign;
 extern int Wdo_while;
 extern int Wenum_mismatch;
+extern int Wenum_to_int;
+extern int Wint_to_enum;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
 extern int Wone_bit_signed_bitfield;
diff --git a/parse.c b/parse.c
index 5e75242..76d4c58 100644
=2D-- a/parse.c
+++ b/parse.c
@@ -791,6 +791,7 @@ static void cast_enum_list(struct symbol_list *list, st=
ruct symbol *base_type)
 		if (expr->type !=3D EXPR_VALUE)
 			continue;
 		ctype =3D expr->ctype;
+		expr->enum_type =3D sym->ctype.base_type;
 		if (ctype->bit_size =3D=3D base_type->bit_size)
 			continue;
 		cast_value(expr, base_type, expr, ctype);
diff --git a/sparse.1 b/sparse.1
index d7fe444..288b3a8 100644
=2D-- a/sparse.1
+++ b/sparse.1
@@ -149,6 +149,19 @@ Sparse issues these warnings by default.  To turn them=
 off, use
 \fB\-Wno\-enum\-mismatch\fR.
 .
 .TP
+.B \-Wenum\-to\-int
+Warn about converting an \fBenum\fR type to int. An explicit cast to int w=
ill
+suppress this warning.
+.
+.TP
+.B \-Wint\-to\-enum
+Warn about converting int to \fBenum\fR type. An explicit cast to the right
+\fBenum\fR type will suppress this warning.
+
+Sparse issues these warnings by default.  To turn them off, use
+\fB\-Wno\-int\-to\-enum\fR.
+.
+.TP
 .B \-Wnon\-pointer\-null
 Warn about the use of 0 as a NULL pointer.
=20
=2D-=20
1.6.2.5


--Boundary-00=_tylnKa6rSwfzfrh
Content-Type: text/x-csrc;
  charset="utf-8";
  name="test-enum.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test-enum.c"

static void foo(void) {
    enum ENUM_TYPE_A { VALUE_A } var_a;
    enum ENUM_TYPE_B { VALUE_B } var_b;
    enum /* anon. */ { VALUE_C } anon_enum_var;
    int i;

    // always OK
    var_a = VALUE_A;
    var_a = (enum ENUM_TYPE_A) VALUE_B;
    var_b = (enum ENUM_TYPE_B) i;
    i = (int) VALUE_A;
    anon_enum_var = VALUE_C;
    i = VALUE_C;
    i = anon_enum_var;
    i = 7;

    // caught by -Wenum-mismatch (default) even without the patch
    var_a = var_b;
    var_b = anon_enum_var;
    anon_enum_var = var_a;
    var_a = (enum ENUM_TYPE_B) 0;

    // caught by -Wenum-mismatch (default) only with the patch applied
    var_a = VALUE_B;
    var_b = VALUE_C;
    anon_enum_var = VALUE_A;

    // caught by -Wint-to-enum (default)
    var_a = 0;
    var_b = i;
    anon_enum_var = 0;
    anon_enum_var = i;
    var_a = (int) VALUE_A;
    var_a = (int) VALUE_B;

    // caught only with -Wenum-to-int
    i = var_a;
    i = VALUE_B;
}

--Boundary-00=_tylnKa6rSwfzfrh--
