From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: enforce toplevel() if SYM_STRUCT was not defined
Date: Thu, 27 Feb 2020 16:21:15 +0100
Message-ID: <20200227152115.GA19970@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729084AbgB0PVX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 27 Feb 2020 10:21:23 -0500
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

Change lookup_member() to set type->scope = file_scope if !symbol_list.
This is not 100% correct, but struct_union_enum_specifier() does the
same check with the following comment:

	// The following test is actually wrong for empty
	// structs, but (1) they are not C99, (2) gcc does
	// the same thing, and (3) it's easier.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dissect.c b/dissect.c
index c48214b9..1970e46f 100644
--- a/dissect.c
+++ b/dissect.c
@@ -304,6 +304,9 @@ static struct symbol *lookup_member(struct symbol *type, struct ident *name, int
 			.kind = 'm',
 		};
 
+		if (!type->symbol_list)
+			type->scope = file_scope;
+
 		mem = &bad_member;
 		mem->ident = name;
 	}
-- 
2.25.1.362.g51ebf55
