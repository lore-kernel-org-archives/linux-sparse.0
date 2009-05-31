From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH 3/3] Whitespace tweaks in symbol.h
Date: Sun, 31 May 2009 11:44:12 -0400
Message-ID: <1243784652-31802-3-git-send-email-naesten@gmail.com>
References: <1243784652-31802-1-git-send-email-naesten@gmail.com>
 <1243784652-31802-2-git-send-email-naesten@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 170-23.widener.edu ([147.31.170.23]:33432 "EHLO
	naruto.cs.widener.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbZEaQBS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 May 2009 12:01:18 -0400
In-Reply-To: <1243784652-31802-2-git-send-email-naesten@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Samuel Bronson <naesten@gmail.com>

Changes-licensed-under: ISC license
Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 symbol.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/symbol.h b/symbol.h
index 4a16f0d..3dd4531 100644
--- a/symbol.h
+++ b/symbol.h
@@ -24,16 +24,16 @@
  * declared.
  */
 enum namespace {
-	NS_NONE = 0,
-	NS_MACRO = 1,
-	NS_TYPEDEF = 2,
-	NS_STRUCT = 4,  // Also used for unions and enums.
-	NS_LABEL = 8,
-	NS_SYMBOL = 16,
-	NS_ITERATOR = 32,
-	NS_PREPROCESSOR = 64,
-	NS_UNDEF = 128,
-	NS_KEYWORD = 256,
+	NS_NONE		= 0,
+	NS_MACRO	= 1,
+	NS_TYPEDEF	= 2,
+	NS_STRUCT	= 4,  // Also used for unions and enums.
+	NS_LABEL	= 8,
+	NS_SYMBOL	= 16,
+	NS_ITERATOR	= 32,
+	NS_PREPROCESSOR	= 64,
+	NS_UNDEF	= 128,
+	NS_KEYWORD	= 256,
 };
 
 enum type {
@@ -59,7 +59,7 @@ enum type {
 };
 
 enum keyword {
-	KW_SPECIFIER 	= 1 << 0,
+	KW_SPECIFIER	= 1 << 0,
 	KW_MODIFIER	= 1 << 1,
 	KW_QUALIFIER	= 1 << 2,
 	KW_ATTRIBUTE	= 1 << 3,
-- 
1.6.3.1.169.g33fd.dirty

