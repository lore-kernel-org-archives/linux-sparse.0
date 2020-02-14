From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 3/3] dissect: enforce MOD_TOPLEVEL if SYM_STRUCT was not
 defined
Date: Fri, 14 Feb 2020 12:34:07 +0100
Message-ID: <20200214113407.GB31587@redhat.com>
References: <20200214113320.GA31578@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726092AbgBNLeN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 14 Feb 2020 06:34:13 -0500
In-Reply-To: <20200214113320.GA31578@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

A separate change for documentation purposes.

Test-case:

	void func(void)
	{
		struct UNDEFINED x;
		x.member = 0;
	}

output:

   1:6                    def   f func                             void ( ... )
   3:26  func             def . v x                                struct UNDEFINED
   4:9   func             -w- . v x                                struct UNDEFINED
   4:10  func             -w- . m UNDEFINED.member                 bad type

but in this case is_sym_local(UNDEFINED) = F makes more sense, most
probably this struct was defined somewhere else but __sparse() didn't
see its definition.

Change lookup_member() to set MOD_TOPLEVEL if !SYM_STRUCT symbol_list.
This is not 100% correct, but struct_union_enum_specifier() does the
same with the following comment:

	// The following test is actually wrong for empty
	// structs, but (1) they are not C99, (2) gcc does
	// the same thing, and (3) it's easier.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dissect.c b/dissect.c
index 1465760..f60999e 100644
--- a/dissect.c
+++ b/dissect.c
@@ -305,6 +305,8 @@ static struct symbol *lookup_member(struct symbol *type, struct ident *name, int
 			.kind = 'm',
 		};
 
+		if (!type->symbol_list)
+			type->ctype.modifiers |= MOD_TOPLEVEL;
 		mem = &bad_member;
 		mem->ident = name;
 	}
-- 
2.5.0
