From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] RFC: remove warning "advancing past deep designator"
Date: Fri, 19 May 2017 15:58:47 +0200
Message-ID: <20170519135847.40720-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35009 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdESN6z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 May 2017 09:58:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id v4so18552161wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 19 May 2017 06:58:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>

This warning is issued in code like:
	struct s {
		union {
			int  i;
			long l;
		} u;
		int b;
	};
	static struct s s = {
		.u.i = 1,
		2,
	};
in other words, it is issued when a 'deep' designated initializer
is followed by a non-designated initializer.

I wonder what's really the value of this warning.
Is there really some confusion we would like to avoid?

NB. I'm not sure if this situation is covered by the standard
    (status of 'deep' designated initializers is not very clear).
NB. GCC accept this, without any option to warn about it.

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index f8ed10f13..ef4da2371 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2501,10 +2501,6 @@ static void handle_list_initializer(struct expression *expr,
 					ctype->ident ? ": " : "",
 					get_type_name(struct_sym->type),
 					show_ident(struct_sym->ident));
-			if (jumped) {
-				warning(e->pos, "advancing past deep designator");
-				jumped = 0;
-			}
 			REPLACE_CURRENT_PTR(e, last);
 		} else {
 			next = check_designators(e, ctype);
-- 
2.13.0

