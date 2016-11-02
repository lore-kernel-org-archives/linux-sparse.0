From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] allow to launch the test suite from the project root dir
Date: Thu,  3 Nov 2016 00:22:24 +0100
Message-ID: <20161102232224.74747-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33582 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756412AbcKBXYe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 19:24:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id u144so5295112wmu.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 16:24:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The test suite must be run from the validation/ dir
which is sometimes slightly annoying.

Change that by letting the script to first do a cd to
the validation dir.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index 03421a24..9a033439 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -2,6 +2,8 @@
 
 #set -x
 
+cd $(dirname "$0")
+
 default_path=".."
 default_cmd="sparse \$file"
 tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
-- 
2.10.1

