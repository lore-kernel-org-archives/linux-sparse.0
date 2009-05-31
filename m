From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH 2/3] Replace SYM_ and MOD_ #defines with enums in symbol.h.
Date: Sun, 31 May 2009 11:44:11 -0400
Message-ID: <1243784652-31802-2-git-send-email-naesten@gmail.com>
References: <1243784652-31802-1-git-send-email-naesten@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 170-23.widener.edu ([147.31.170.23]:33432 "EHLO
	naruto.cs.widener.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009AbZEaQBT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 May 2009 12:01:19 -0400
In-Reply-To: <1243784652-31802-1-git-send-email-naesten@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Samuel Bronson <naesten@gmail.com>

Adjust the associated fields to match. While we're here, change
some nearby bitfields from "char" to "int" so GDB doesn't bother
showing character literals for them.

This should allow the gdbhelpers script to work with more versions of
GDB and/or build configurations.

Changes-licensed-under: ISC license
Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 symbol.h |  106 ++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/symbol.h b/symbol.h
index c4d7f28..4a16f0d 100644
--- a/symbol.h
+++ b/symbol.h
@@ -80,7 +80,7 @@ extern struct context *alloc_context(void);
 DECLARE_PTR_LIST(context_list, struct context);
 
 struct ctype {
-	unsigned long modifiers;
+	enum modifier modifiers;
 	unsigned long alignment;
 	struct context_list *contexts;
 	unsigned int as;
@@ -103,14 +103,19 @@ struct symbol_op {
 extern int expand_safe_p(struct expression *expr, int cost);
 extern int expand_constant_p(struct expression *expr, int cost);
 
-#define SYM_ATTR_WEAK		0
-#define SYM_ATTR_NORMAL		1
-#define SYM_ATTR_STRONG		2
+enum sym_attr {
+	SYM_ATTR_WEAK	= 0,
+	SYM_ATTR_NORMAL	= 1,
+	SYM_ATTR_STRONG	= 2,
+};
 
 struct symbol {
 	enum type type:8;
 	enum namespace namespace:9;
-	unsigned char used:1, attr:2, enum_member:1, bound:1;
+	unsigned int used:1;
+	enum sym_attr attr:2;
+	unsigned int enum_member:1;
+	unsigned int bound:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct position endpos;		/* Where this symbol ends*/
 	struct ident *ident;		/* What identifier this symbol is associated with */
@@ -162,57 +167,58 @@ struct symbol {
 		void *aux;			/* Auxiliary info, e.g. backend information */
 		struct {			/* sparse ctags */
 			char kind;
-			unsigned char visited:1;
+			unsigned int visited:1;
 		};
 	};
 	pseudo_t pseudo;
 };
 
 /* Modifiers */
-#define MOD_AUTO	0x0001
-#define MOD_REGISTER	0x0002
-#define MOD_STATIC	0x0004
-#define MOD_EXTERN	0x0008
-
-#define MOD_CONST	0x0010
-#define MOD_VOLATILE	0x0020
-#define MOD_SIGNED	0x0040
-#define MOD_UNSIGNED	0x0080
-
-#define MOD_CHAR	0x0100
-#define MOD_SHORT	0x0200
-#define MOD_LONG	0x0400
-#define MOD_LONGLONG	0x0800
-
-#define MOD_TYPEDEF	0x1000
-
-#define MOD_INLINE	0x40000
-#define MOD_ADDRESSABLE	0x80000
-
-#define MOD_NOCAST	0x100000
-#define MOD_NODEREF	0x200000
-#define MOD_ACCESSED	0x400000
-#define MOD_TOPLEVEL	0x800000	// scoping..
-
-#define MOD_LABEL	0x1000000
-#define MOD_ASSIGNED	0x2000000
-#define MOD_TYPE	0x4000000
-#define MOD_SAFE	0x8000000	// non-null/non-trapping pointer
-
-#define MOD_USERTYPE	0x10000000
-#define MOD_FORCE	0x20000000
-#define MOD_EXPLICITLY_SIGNED	0x40000000
-#define MOD_BITWISE	0x80000000
-
-#define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
-#define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL | MOD_FORCE)
-#define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
-#define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG | MOD_SIGNEDNESS)
-#define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
-#define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
-	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
-
+enum modifier {
+	MOD_AUTO	= 1 << 0,
+	MOD_REGISTER	= 1 << 1,
+	MOD_STATIC	= 1 << 2,
+	MOD_EXTERN	= 1 << 3,
+
+	MOD_CONST	= 1 << 4,
+	MOD_VOLATILE	= 1 << 5,
+	MOD_SIGNED	= 1 << 6,
+	MOD_UNSIGNED	= 1 << 7,
+
+	MOD_CHAR	= 1 << 8,
+	MOD_SHORT	= 1 << 9,
+	MOD_LONG	= 1 << 10,
+	MOD_LONGLONG	= 1 << 11,
+
+	MOD_TYPEDEF	= 1 << 12,
+
+	MOD_INLINE	= 1 << 18,
+	MOD_ADDRESSABLE	= 1 << 19,
+
+	MOD_NOCAST	= 1 << 20,
+	MOD_NODEREF	= 1 << 21,
+	MOD_ACCESSED	= 1 << 22,
+	MOD_TOPLEVEL	= 1 << 23,	// scoping..
+
+	MOD_LABEL	= 1 << 24,
+	MOD_ASSIGNED	= 1 << 25,
+	MOD_TYPE	= 1 << 26,
+	MOD_SAFE	= 1 << 27,	// non-null/non-trapping pointer
+
+	MOD_USERTYPE	= 1 << 28,
+	MOD_FORCE       = 1 << 29,
+	MOD_EXPLICITLY_SIGNED	= 1 << 30,
+	MOD_BITWISE	= 1 << 31,
+
+	MOD_NONLOCAL	= (MOD_EXTERN | MOD_TOPLEVEL),
+	MOD_STORAGE	= (MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL | MOD_FORCE),
+	MOD_SIGNEDNESS	= (MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED),
+	MOD_SPECIFIER	= (MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG | MOD_SIGNEDNESS),
+	MOD_SIZE	= (MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG),
+	MOD_IGNORE	= (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |
+			   MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED),
+	MOD_PTRINHERIT	= (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE),
+};
 
 /* Current parsing/evaluation function */
 extern struct symbol *current_fn;
-- 
1.6.3.1.169.g33fd.dirty

