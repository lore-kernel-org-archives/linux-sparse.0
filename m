From: Franz Schrober <franzschrober@gmail.com>
Subject: [PATCHv3 4/5] FAQ: Remove outdated sections about the license
Date: Fri, 29 Nov 2013 13:30:09 +0100
Message-ID: <1385728209-23222-1-git-send-email-franzschrober@gmx.de>
References: <1385633782-775-5-git-send-email-franzschrober@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:43565 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab3K2Mad (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 29 Nov 2013 07:30:33 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so4355038bkz.0
        for <linux-sparse@vger.kernel.org>; Fri, 29 Nov 2013 04:30:32 -0800 (PST)
In-Reply-To: <1385633782-775-5-git-send-email-franzschrober@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: jw+debian@jameswestby.net, sparse@chrisli.org, Franz Schrober <franzschrober@yahoo.de>

From: Franz Schrober <franzschrober@yahoo.de>

Reported-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Franz Schrober <franzschrober@yahoo.de>
---
Changes since v2

 * Removed paragraph in "Why not GPL?" about "give-back" parts of the license
   which no longer applies

 FAQ | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/FAQ b/FAQ
index 290de0e..8ef6e84 100644
--- a/FAQ
+++ b/FAQ
@@ -42,30 +42,6 @@ A.  See the previous question: I personally think that the front end
     they want to have a proprietary back-end, that's ok by me too. It's
     their loss, not mine.
 
-    At the same time, I'm a big believer in "quid pro quo". I wrote the
-    front-end, and if you make improvements to the semantic parsing part
-    (as opposed to just using the resulting parse tree), you'd better
-    cough up.  The front-end is intended to be an open-source project in
-    its own right, and if you improve the front end, you must give those
-    improvements back. That's your "quid" to my "quo".
-
-
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
