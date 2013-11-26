From: Franz Schrober <franzschrober@yahoo.de>
Subject: [PATCH 2/2] FAQ: Remove outdated section about the license
Date: Tue, 26 Nov 2013 18:11:15 +0100
Message-ID: <1385485875-4379-2-git-send-email-franzschrober@yahoo.de>
References: <2707831.Oy8a70NHiK@bentobox>
 <1385485875-4379-1-git-send-email-franzschrober@yahoo.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm19-vm9.bullet.mail.ir2.yahoo.com ([212.82.96.242]:24488 "HELO
	nm19-vm9.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932309Ab3KZROd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Nov 2013 12:14:33 -0500
In-Reply-To: <1385485875-4379-1-git-send-email-franzschrober@yahoo.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, Franz Schrober <franzschrober@yahoo.de>

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
