From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH 3/3] Fix build with GCC 4.6 series.
Date: Wed, 13 Apr 2011 13:06:06 +0200
Message-ID: <1302692766-30217-3-git-send-email-flameeyes@gmail.com>
References: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44327 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758436Ab1DMLJk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 07:09:40 -0400
Received: by wya21 with SMTP id 21so385797wya.19
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 04:09:39 -0700 (PDT)
In-Reply-To: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>

The label_statement attribute in the anonymous structures' union was
duplicated for label_arg and labeled_struct alises, which were
identical. Since the former is never used, delete it and leave the other as
the only copy.
---
 parse.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/parse.h b/parse.h
index 6b21e23..b26bd03 100644
--- a/parse.h
+++ b/parse.h
@@ -35,10 +35,6 @@ struct statement {
 		struct /* declaration */ {
 			struct symbol_list *declaration;
 		};
-		struct /* label_arg */ {
-			struct symbol *label;
-			struct statement *label_statement;
-		};
 		struct {
 			struct expression *expression;
 			struct expression *context;
-- 
1.7.5.rc1

