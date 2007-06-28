From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 3/6] cgcc: preserve sparse exit code if -no-compile is used
Date: Thu, 28 Jun 2007 01:40:04 -0400
Message-ID: <20070628054004.30704.72118.stgit@dv.roinet.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:38930 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988AbXF1FkF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:40:05 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3mjd-0008Kj-8U
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:05 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1I3mjc-000803-Nr
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:04 -0400
In-Reply-To: <20070628053954.30704.66440.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cgcc |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/cgcc b/cgcc
index 226a7a7..2b9f89c 100755
--- a/cgcc
+++ b/cgcc
@@ -50,8 +50,11 @@ if ($do_check) {
 	$check .= &add_specs ('host_os_specs');
     }
     print "$check\n" if $verbose;
-#    exit 1;
-    system ($check);
+    if ($do_compile) {
+	system ($check);
+    } else {
+	exec ($check);
+    }
 }
 
 if ($do_compile) {
