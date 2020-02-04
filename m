From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 3/4] dissect: change deanon() to handle the !node case
Date: Tue, 4 Feb 2020 17:51:42 +0100
Message-ID: <20200204165142.GA24346@redhat.com>
References: <20200204165119.GA24330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60002 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727310AbgBDQvv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Feb 2020 11:51:51 -0500
In-Reply-To: <20200204165119.GA24330@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Change deanon() to always initialize base->ident when parent != NULL
but still return false to avoid the pointless ->r_symdef().

Test-case:

	struct {
		union {
			int x;
		};
	} var = {
		{ .x = 0 },
	};

before this patch:

	1:8   s def  :var
	5:3   g def  var                              struct :var
	5:3   g -w-  var                              struct :var
	6:12  s -w-  ?.x                              int

after:

	1:8   s def  :var
	5:3   g def  var                              struct :var
	5:3   g -w-  var                              struct :var
	6:12  s -w-  :var.x                           int

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index d34b38a..57dcdb2 100644
--- a/dissect.c
+++ b/dissect.c
@@ -195,8 +195,10 @@ static bool deanon(struct symbol *base, struct ident *node, struct symbol *paren
 	struct ident *pi = parent ? parent->ident : NULL;
 	char name[256];
 
-	if (!node)
+	if (!node) {
+		base->ident = pi;
 		return false;
+	}
 
 	snprintf(name, sizeof(name), "%.*s:%.*s",
 		pi ? pi->len : 0, pi ? pi->name : NULL, node->len, node->name);
-- 
2.5.0
