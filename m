From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 07/14] allow to launch the test suite from the project root dir
Date: Mon, 13 Feb 2017 00:28:57 +0100
Message-ID: <20170212232904.49647-8-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34487 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdBLX3R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:17 -0500
Received: by mail-wr0-f195.google.com with SMTP id 89so21847923wrr.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:17 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
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
index 8692bfe98..b6ec5655e 100755
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
2.11.0

