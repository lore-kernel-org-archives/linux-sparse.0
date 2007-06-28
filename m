From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 5/6] Fix warnings about undeclared globals,
	they are irrelevant to the test
Date: Thu, 28 Jun 2007 01:40:14 -0400
Message-ID: <20070628054014.30704.58376.stgit@dv.roinet.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:38937 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565AbXF1FkP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:40:15 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3mjn-0008LU-Ec
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:15 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1I3mjm-00080e-Tn
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:14 -0400
In-Reply-To: <20070628053954.30704.66440.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 validation/bitfields.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/bitfields.c b/validation/bitfields.c
index 292a110..16aa16d 100644
--- a/validation/bitfields.c
+++ b/validation/bitfields.c
@@ -5,13 +5,13 @@
  *
  * "warning: a.c:16:10: incompatible types for operation"
  */
-struct {
+static struct {
 	int x:4;
 } y;
 
 extern int a[];
 
-int b(void)
+static int b(void)
 {
 	return a[y.x];
 }
