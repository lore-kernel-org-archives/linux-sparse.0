From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v0 1/4] be more careful with concat_user_list()
Date: Sat, 11 Mar 2017 16:47:22 +0100
Message-ID: <20170311154725.87906-2-luc.vanoostenryck@gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36695 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755335AbdCKPto (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 10:49:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id v190so3364299wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 07:49:32 -0800 (PST)
In-Reply-To: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In convert_instruction_target(), once all users have been converted
the old user list is concatened to the one of the replacing pseudo.
But this pseudo may be one for which a user list is meaningless,
like PSEUDO_VAL.

While as such it's not a problem, it inhibit the reuse of the users
pointer for other uses.

Fix this by doing the concatenation only if the pseudo can have
an use-list.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index 8111e1ae6..6878c0b4c 100644
--- a/flow.c
+++ b/flow.c
@@ -254,7 +254,8 @@ void convert_instruction_target(struct instruction *insn, pseudo_t src)
 			*pu->userp = src;
 		}
 	} END_FOR_EACH_PTR(pu);
-	concat_user_list(target->users, &src->users);
+	if (has_use_list(src))
+		concat_user_list(target->users, &src->users);
 	target->users = NULL;
 }
 
-- 
2.11.1

