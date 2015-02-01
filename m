From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] Teach sparse to display data/initial values
Date: Sun,  1 Feb 2015 03:19:45 +0100
Message-ID: <1422757186-8007-4-git-send-email-luc.vanoostenryck@gmail.com>
References: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
 <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:42576 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbBACUf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Jan 2015 21:20:35 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so32990103wgg.4
        for <linux-sparse@vger.kernel.org>; Sat, 31 Jan 2015 18:20:33 -0800 (PST)
In-Reply-To: <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, linux@rasmusvillemoes.dk, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sparse.c b/sparse.c
index 6b3324cf..e87f8c4f 100644
--- a/sparse.c
+++ b/sparse.c
@@ -285,6 +285,9 @@ static void check_symbols(struct symbol_list *list)
 				show_entry(ep);
 
 			check_context(ep);
+		} else {
+			if (dbg_data)
+				show_data(sym);
 		}
 	} END_FOR_EACH_PTR(sym);
 
-- 
2.2.0

