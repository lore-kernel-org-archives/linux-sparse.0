From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] fix: do not ignore struct/union/enum type attributes
Date: Mon, 22 Jan 2018 07:36:05 +0100
Message-ID: <20180122063605.97737-4-luc.vanoostenryck@gmail.com>
References: <20180122063605.97737-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:43623 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeAVGgT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 01:36:19 -0500
Received: by mail-wm0-f67.google.com with SMTP id g1so14090888wmg.2
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jan 2018 22:36:19 -0800 (PST)
In-Reply-To: <20180122063605.97737-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

GCC's syntax for type attributes is specified as:
    An attribute specifier list may appear as part of a struct,
    union or enum specifier. It may go either immediately after
    the struct, union or enum keyword, or after the closing brace.
    The former syntax is preferred. Where attribute specifiers
    follow the closing brace, they are considered to relate to
    the structure, union or enumerated type defined, not to any
    enclosing declaration the type specifier appears in, and the type
    defined is not complete until after the attribute specifiers.
In the section about type attributes, it's also said:
    You may specify type attributes in an enum, struct or union type
    declaration or definition by placing them immediately after the
    struct, union or enum keyword. A less preferred syntax is to
    place them just past the closing curly brace of the definition.

So, while placing the attribute after the closing curly is not
preferred, it is cleary legal (and it seems to be much more popular
than placing them just after the struct, union or enum keyword).

However, currently sparse doesn't handle this correctly:
- these attributes are parsed in declaration_specifiers() and
  added to the current decl_state
- when the ';' ending the type declaration is reached, the plain
  struct/union/enum is used and the content of the decl_state is
  simply ignored.
- if the declaration is for a variable, then those attributes
  are assigned to the variable (but not to the type).

Fix this by calling handle_attribute() once we have reached the
closing '}' of a struct/union/enum definition and applying these
attributes, if any, directly to the current base type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                           | 5 +++++
 validation/type-attribute-align.c | 1 -
 validation/type-attribute-as.c    | 1 -
 validation/type-attribute-mod.c   | 1 -
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index a60fcff45..9df4ad359 100644
--- a/parse.c
+++ b/parse.c
@@ -695,6 +695,8 @@ static struct token *struct_union_enum_specifier(enum type type,
 		repos = &token->pos;
 		token = token->next;
 		if (match_op(token, '{')) {
+			struct decl_state attr = { .ctype.base_type = sym, };
+
 			// The following test is actually wrong for empty
 			// structs, but (1) they are not C99, (2) gcc does
 			// the same thing, and (3) it's easier.
@@ -704,6 +706,9 @@ static struct token *struct_union_enum_specifier(enum type type,
 			token = parse(token->next, sym);
 			token = expect(token, '}', "at end of struct-union-enum-specifier");
 
+			token = handle_attributes(token, &attr, KW_ATTRIBUTE);
+			apply_ctype(token->pos, &attr.ctype, &sym->ctype);
+
 			// Mark the structure as needing re-examination
 			sym->examined = 0;
 			sym->endpos = token->pos;
diff --git a/validation/type-attribute-align.c b/validation/type-attribute-align.c
index d56769c44..473177c56 100644
--- a/validation/type-attribute-align.c
+++ b/validation/type-attribute-align.c
@@ -16,5 +16,4 @@ void main(void)
 
 /*
  * check-name: type-attribute-align
- * check-known-to-fail
  */
diff --git a/validation/type-attribute-as.c b/validation/type-attribute-as.c
index 375ad4c76..43021e49c 100644
--- a/validation/type-attribute-as.c
+++ b/validation/type-attribute-as.c
@@ -21,7 +21,6 @@ void main(void)
 
 /*
  * check-name: type-attribute-as
- * check-known-to-fail
  *
  * check-error-start
 type-attribute-as.c:16:15: warning: incorrect type in argument 1 (different address spaces)
diff --git a/validation/type-attribute-mod.c b/validation/type-attribute-mod.c
index 0e7b166a4..d55011dfa 100644
--- a/validation/type-attribute-mod.c
+++ b/validation/type-attribute-mod.c
@@ -14,7 +14,6 @@ void main(void)
 
 /*
  * check-name: type-attribute-mod
- * check-known-to-fail
  *
  * check-error-start
 type-attribute-mod.c:12:9: warning: dereference of noderef expression
-- 
2.16.0

