From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] make 'ignored_attributes[]' static
Date: Wed,  2 Nov 2016 18:16:02 +0100
Message-ID: <20161102171602.17833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36444 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbcKBRQH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 13:16:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id c17so4027539wmc.3
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 10:16:06 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

And so quiets a warning from sparse about an undeclared symbol
when running on its own code.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 205e1264..70b3a076 100644
--- a/parse.c
+++ b/parse.c
@@ -501,7 +501,7 @@ static struct init_keyword {
 	{ "__word__",	NS_KEYWORD,	MOD_LONG,	.op = &mode_word_op },
 };
 
-const char *ignored_attributes[] = {
+static const char *ignored_attributes[] = {
 	"alias",
 	"__alias__",
 	"alloc_align",
-- 
2.10.1

