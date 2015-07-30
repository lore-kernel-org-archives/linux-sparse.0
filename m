From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 1/3] .gitignore: add cscope and Qt project files
Date: Wed, 29 Jul 2015 20:26:39 -0400
Message-ID: <1438216001-8862-2-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbG3A0u (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Jul 2015 20:26:50 -0400
In-Reply-To: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 .gitignore | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index d32d063..e1734a9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@
 pre-process.h
 sparse.pc
 version.h
+cscope*
 
 # programs
 test-inspect
@@ -40,3 +41,9 @@ series
 # local makefile
 local.mk
 
+# files related to Qt
+*.pro*
+*.pri*
+*.qt
+*.sparse
+*.save
-- 
2.4.3

