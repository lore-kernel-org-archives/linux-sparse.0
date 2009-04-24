From: Martin Nagy <nagy.martin@gmail.com>
Subject: [PATCH] .gitignore: Ignore dependencies and Vim swap files
Date: Fri, 24 Apr 2009 17:58:07 +0200
Message-ID: <20090424175807.014635a3@notas>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:46091 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZDXP6P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 Apr 2009 11:58:15 -0400
Received: by ewy24 with SMTP id 24so1104207ewy.37
        for <linux-sparse@vger.kernel.org>; Fri, 24 Apr 2009 08:58:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Martin Nagy <nagy.martin@gmail.com>
---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index a915ef3..8ea8feb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,7 +1,9 @@
 # generic
 *.o
+*.o.d
 *.a
 *.so
+.*.swp
 
 # generated
 pre-process.h
-- 
1.6.0.6

