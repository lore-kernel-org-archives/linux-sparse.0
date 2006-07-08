From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix warnings from gcc 4.1.1
Date: Sat, 08 Jul 2006 02:00:04 -0400
Message-ID: <20060708060004.20321.50429.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:31379 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964811AbWGHGAL
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 8 Jul 2006 02:00:11 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fz5rO-00017Q-DS
	for linux-sparse@vger.kernel.org; Sat, 08 Jul 2006 02:00:10 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fz5rK-0005Hs-TJ
	for linux-sparse@vger.kernel.org; Sat, 08 Jul 2006 02:00:06 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

These warnings are reported for every file:
lib.h: In function 'add_symbol':
lib.h:171: warning: value computed is not used
lib.h: In function 'add_statement':
lib.h:176: warning: value computed is not used
lib.h: In function 'add_expression':
lib.h:181: warning: value computed is not used

That's the way new versions of gcc warn about values that are cast to a
type but not used.

The cast in add_ptr_list_tag() is not really needed.  Its return value
is used only in one place (add_pseudo) where it's converted to (void *)
anyway.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 ptrlist.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index b42a0ca..7a786cb 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -46,7 +46,7 @@ extern int linearize_ptr_list(struct ptr
  * extensions..
  */
 #define add_ptr_list_tag(list,entry,tag) \
-	(TYPEOF(*(list))) (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list), (entry), (tag)))
+	(CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list), (entry), (tag)))
 #define add_ptr_list(list,entry) \
 	add_ptr_list_tag(list,entry,0)
 #define free_ptr_list(list) \
