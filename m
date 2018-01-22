From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] test-suite: handle format with filename.c not existing
Date: Mon, 22 Jan 2018 11:05:09 -0800
Message-ID: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38350 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeAVTFO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 14:05:14 -0500
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

From: Randy Dunlap <rdunlap@infradead.org>

In error(), quiet is undefined when the command:
  $ ./test-suite format filename1.c foobar1

is used and filename1.c does not exist. This causes a shell script error:
  ./test-suite: line 147: [: : integer expression expected

because $quiet is undefined in
  [ "$quiet" -ne 1 ] && echo "error: $1"
so the error message is lost.

Just initialize quiet before any command line parsing.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 validation/test-suite |    2 ++
 1 file changed, 2 insertions(+)

--- sprs.orig/validation/test-suite
+++ sprs.next/validation/test-suite
@@ -368,6 +368,8 @@ arg_file()
 	return 0
 }
 
+quiet=0
+
 case "$1" in
 	'')
 		do_test_suite


