From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH 1/3] Add -*- gdb-script -*- to the top of gdbhelpers, for Emacs
Date: Sun, 31 May 2009 11:44:10 -0400
Message-ID: <1243784652-31802-1-git-send-email-naesten@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 170-23.widener.edu ([147.31.170.23]:33432 "EHLO
	naruto.cs.widener.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbZEaQBR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 May 2009 12:01:17 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Samuel Bronson <naesten@gmail.com>

Changes-licensed-under: ISC license
Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 gdbhelpers |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gdbhelpers b/gdbhelpers
index 7223ffd..34407d6 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -1,3 +1,4 @@
+# For emacs: -*- gdb-script -*- 
 
 # Don't forget to rebuild sparse with uncommented debug options
 # in the Makefile. Also, gcc 3 is known to screw up with the
-- 
1.6.3.1.169.g33fd.dirty

