From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/3] dissect: fix sym_is_local(SYM_STRUCT/UNION/ENUM)
Date: Fri, 14 Feb 2020 12:33:43 +0100
Message-ID: <20200214113343.GA31587@redhat.com>
References: <20200214113320.GA31578@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58640 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgBNLdu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 14 Feb 2020 06:33:50 -0500
In-Reply-To: <20200214113320.GA31578@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Now that struct_union_enum_specifier() sets MOD_TOPLEVEL we can
simplify sym_is_local(sym) and rely on it even if "sym" is type.

Test-case:

	// copied from linux kernel
	# define __force	__attribute__((force))
	#define WRITE_ONCE(x, val) \
	({							\
		union { typeof(x) __val; char __c[1]; } __u =	\
			{ .__val = (__force typeof(x)) (val) }; \
		__write_once_size(&(x), __u.__c, sizeof(x));	\
		__u.__val;					\
	})

	void func(int *p)
	{
		WRITE_ONCE(*p, 0);
	}

before this patch the widely used WRITE_ONCE() generates a lot of spam which
can't be filtered out using sym_is_local(),

	11:6                    def   f func                             void ( ... )
	11:11  func             def . v p                                int *
	13:9                    def   s :__u
	13:9                    --- . v p                                int *
	13:9                    def   m :__u.__val                       int
	13:9                    def   m :__u.__c                         char [1]
	13:9   func             def . v __u                              union :__u
	13:9   func             -w- . v __u                              union :__u
	13:9   func             -w-   m :__u.__val                       int
	13:9   func             --- . v p                                int *
	13:9   func             --r   f __write_once_size                bad type
	13:9   func             -r- . v p                                int *
	13:9   func             -r- . v __u                              union :__u
	13:9   func             m--   m :__u.__c                         char [1]
	13:9   func             --- . v p                                int *
	13:9   func             --- . v __u                              union :__u
	13:9   func             ---   m :__u.__val                       int

plus it triggers warning("no context") in test-dissect.c. With this patch
the only "nonlocal" report is __write_once_size() call.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 3 ++-
 dissect.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dissect.c b/dissect.c
index 40baf64..1465760 100644
--- a/dissect.c
+++ b/dissect.c
@@ -238,7 +238,8 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 				return;
 
 			dctx = dissect_ctx;
-			dissect_ctx = NULL;
+			if (base->ctype.modifiers & MOD_TOPLEVEL)
+				dissect_ctx = NULL;
 
 			if (base->ident || deanon(base, name, parent))
 				reporter->r_symdef(base);
diff --git a/dissect.h b/dissect.h
index 326d3dc..38ac877 100644
--- a/dissect.h
+++ b/dissect.h
@@ -29,7 +29,7 @@ extern struct symbol *dissect_ctx;
 
 static inline bool sym_is_local(struct symbol *sym)
 {
-	return sym->kind == 'v' && !(sym->ctype.modifiers & MOD_TOPLEVEL);
+	return !(sym->ctype.modifiers & MOD_TOPLEVEL);
 }
 
 extern void dissect(struct reporter *, struct string_list *);
-- 
2.5.0
