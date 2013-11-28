From: Franz Schrober <franzschrober@gmail.com>
Subject: [PATCHv2 4/5] FAQ: Remove outdated section about the license
Date: Thu, 28 Nov 2013 11:16:21 +0100
Message-ID: <1385633782-775-5-git-send-email-franzschrober@gmail.com>
References: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:62557 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab3K1KRC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Nov 2013 05:17:02 -0500
Received: by mail-bk0-f42.google.com with SMTP id w11so3763138bkz.29
        for <linux-sparse@vger.kernel.org>; Thu, 28 Nov 2013 02:17:01 -0800 (PST)
In-Reply-To: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: jw+debian@jameswestby.net, sparse@chrisli.org, franzschrober@gmail.com, Franz Schrober <franzschrober@yahoo.de>

From: Franz Schrober <franzschrober@yahoo.de>

Signed-off-by: Franz Schrober <franzschrober@yahoo.de>
---
 FAQ | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/FAQ b/FAQ
index 290de0e..56a2618 100644
--- a/FAQ
+++ b/FAQ
@@ -50,23 +50,6 @@ A.  See the previous question: I personally think that the front end
     improvements back. That's your "quid" to my "quo".
 
 
-Q.  So what _is_ the license?
-
-A.  I don't know yet.  I originally thought it would be LGPL, but I'm
-    possibly going for a license that is _not_ subsumable by the GPL. 
-    In other words, I don't want to see a GPL'd project suck in the
-    LGPL'd front-end, and then make changes to the front end under the
-    GPL (this is something that the LGPL expressly allows, and see the
-    previous question for why I think it's the _only_ thing that I will
-    not allow). 
-
-    The current front-runner is the OSL ("Open Software License", see
-    http://www.opensource.org/licenses/osl.php), together with a note on
-    what makes source derivative and what does not to make it clear that
-    people can write back-ends for it without having to make those
-    back-ends available under the OSL. 
-
