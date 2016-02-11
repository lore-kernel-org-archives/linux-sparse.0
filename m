From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: s/mode_t/usage_t/ in report_member()
Date: Thu, 11 Feb 2016 23:47:10 +0100
Message-ID: <20160211224710.GA4989@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38650 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbcBKWrM (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Feb 2016 17:47:12 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

Cosmetic, fix the typo.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index 2d13d2a..67428ec 100644
--- a/dissect.c
+++ b/dissect.c
@@ -130,7 +130,7 @@ static inline struct symbol *no_member(struct ident *name)
 	return &sym;
 }
 
-static struct symbol *report_member(mode_t mode, struct position *pos,
+static struct symbol *report_member(usage_t mode, struct position *pos,
 					struct symbol *type, struct symbol *mem)
 {
 	struct symbol *ret = mem->ctype.base_type;
-- 
2.5.0


