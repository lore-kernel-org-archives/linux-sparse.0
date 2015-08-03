From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 1/3 v2] .gitignore: add cscope and Qt project files
Date: Mon,  3 Aug 2015 13:41:00 -0400
Message-ID: <1438623660-18026-1-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-2-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766AbbHCRlC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Aug 2015 13:41:02 -0400
In-Reply-To: <1438216001-8862-2-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com, sparse@chrisli.org

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index d32d063..1e35eac 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@
 pre-process.h
 sparse.pc
 version.h
+cscope*
 
 # programs
 test-inspect
@@ -40,3 +41,6 @@ series
 # local makefile
 local.mk
 
+# files related to Qt
+*.pro*
+*.pri*
-- 
2.4.3

