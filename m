From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] Fix -E handling
Date: Tue, 12 Jun 2007 14:37:02 +0400
Message-ID: <20070612103702.GA5719@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:52505 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbXFLK3O (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Jun 2007 06:29:14 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1245925wra
        for <linux-sparse@vger.kernel.org>; Tue, 12 Jun 2007 03:29:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

sparse accepts -E[anything] as directive to preprocess only. On some mips
targets -EL slips into command line resulting in 400-800M logs with
preprocessing results :^) Accept '-E' only from now.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/lib.c
+++ b/lib.c
@@ -252,7 +252,8 @@ static char **handle_switch_D(char *arg, char **next)
 
 static char **handle_switch_E(char *arg, char **next)
 {
-	preprocess_only = 1;
+	if (arg[1] == '\0')
+		preprocess_only = 1;
 	return next;
 }
 
