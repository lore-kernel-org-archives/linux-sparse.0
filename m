From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/16] testsuite: move no-arg out of the getopt loop
Date: Fri,  8 Dec 2017 14:14:51 +0100
Message-ID: <20171208131455.7786-13-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34542 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdLHNPW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id y82so4500436wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:21 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a preparatory step to allow to run only a part
of the testsuite (a subdir).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 72bee9dce..410190bd3 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -505,7 +505,7 @@ _EOF
 	return 0
 }
 
-while true; do
+while [ "$#" -gt "0" ]; do
 	case "$1" in
 	-a|--abort)
 		abort=1
@@ -517,11 +517,6 @@ while true; do
 		shift
 		continue
 		;;
