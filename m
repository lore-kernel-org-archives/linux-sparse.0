From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: process extra options without exec
Date: Sun, 17 Dec 2017 16:00:55 +0100
Message-ID: <20171217150055.9147-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44498 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757346AbdLQPDB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Dec 2017 10:03:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id t8so24963673wmc.3
        for <linux-sparse@vger.kernel.org>; Sun, 17 Dec 2017 07:03:01 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Commit 399c43889 (testsuite: get options from env too) allowed
the testsuite to takes extra options from the environment but
did it in a crude way involving exec.

Change this by using 'set --' instead of doing an 'exec'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 5655ac40b..f1d3301a6 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -2,13 +2,6 @@
 
 #set -x
 
-## allow flags from environment
-flags="$SPARSE_TEST_FLAGS"
-if [ ! -z "$flags" ]; then
-	unset SPARSE_TEST_FLAGS
-	exec "$0" $flags "$@"
-fi
