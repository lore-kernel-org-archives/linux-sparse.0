From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [mm 4.15-rc8] Random oopses under memory pressure.
Date: Sat, 20 Jan 2018 15:45:22 +0100
Message-ID: <20180120144521.xdmrnvmijeszimt2@ltop.local>
References: <20180118165629.kpdkezarsf4qymnw@node.shutemov.name>
 <CA+55aFy43ypm0QvA5SqNR4O0ZJETbkR3NDR=dnSdvejc_nmSJQ@mail.gmail.com>
 <20180118234955.nlo55rw2qsfnavfm@node.shutemov.name>
 <20180119125503.GA2897@bombadil.infradead.org>
 <CA+55aFwWCeFrhN+WJDD8u9nqBzmvknXk428Q0dVwwXAvwhg_-w@mail.gmail.com>
 <20180119221243.GL13338@ZenIV.linux.org.uk>
 <CA+55aFw4mw32Mu0_+cgKAzxCNvDW1VPcESv7CyajexfDfMju1A@mail.gmail.com>
 <20180120020237.GM13338@ZenIV.linux.org.uk>
 <20180120052432.GN13338@ZenIV.linux.org.uk>
 <20180120093808.7mol6d7jkngy22ky@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41717 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753487AbeATOp1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 09:45:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id f71so8470392wmf.0
        for <linux-sparse@vger.kernel.org>; Sat, 20 Jan 2018 06:45:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180120093808.7mol6d7jkngy22ky@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sparse mailing list <linux-sparse@vger.kernel.org>

From 1f66592dd83d30ef745b1ff2b620c7935d9bc25a Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sat, 20 Jan 2018 12:11:14 +0100
Subject: [RFC PATCH] fix: do not ignore struct/union/enum type attributes

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

Fix this by calling handle_attribute() once we have reached the
closing '}' of a struct/union/enum definition and applying these
attributes, if any, directly to the current base type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

With this patch, a few more warnings are reported when used on thes
kernel:
- a few more abuse of __user & friends (for example how
  struct __user_cap_data_struct is used in kernel:capability.c:197)
- more annoyingly, a bunch of "invalid access past the end of ..."
  due to __packed not being ignored anymore and linearization not
  being smart enough to handle bitfields in a packed struct.

This patch is also available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git fix-ignored-attributes-v0

 parse.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index e255345fd..9df4ad359 100644
--- a/parse.c
+++ b/parse.c
@@ -627,6 +627,8 @@ struct statement *alloc_statement(struct position pos, int type)
 
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list);
 
+static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);
+
 static void apply_modifiers(struct position pos, struct decl_state *ctx)
 {
 	struct symbol *ctype;
@@ -693,6 +695,8 @@ static struct token *struct_union_enum_specifier(enum type type,
 		repos = &token->pos;
 		token = token->next;
 		if (match_op(token, '{')) {
+			struct decl_state attr = { .ctype.base_type = sym, };
+
 			// The following test is actually wrong for empty
 			// structs, but (1) they are not C99, (2) gcc does
 			// the same thing, and (3) it's easier.
@@ -702,6 +706,9 @@ static struct token *struct_union_enum_specifier(enum type type,
 			token = parse(token->next, sym);
 			token = expect(token, '}', "at end of struct-union-enum-specifier");
 
+			token = handle_attributes(token, &attr, KW_ATTRIBUTE);
+			apply_ctype(token->pos, &attr.ctype, &sym->ctype);
+
 			// Mark the structure as needing re-examination
 			sym->examined = 0;
 			sym->endpos = token->pos;
@@ -962,8 +969,6 @@ static struct token *enum_specifier(struct token *token, struct decl_state *ctx)
 	return ret;
 }
 
-static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);
