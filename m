From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] remove unused "container" macro
Date: Fri, 08 Apr 2011 00:39:37 +0200
Message-ID: <4D9E3D29.2000402@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep20.mx.upcmail.net ([62.179.121.40]:62707 "EHLO
	fep20.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab1DGWjm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Apr 2011 18:39:42 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

This macro seems to be unused since commit e7fb6e0 (4 years ago).
But my estimation that it does not currently have any practical usage for
navigating through the sparse structures may be wrong.

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 ptrlist.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index fbfc080..58d3bda 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -9,9 +9,6 @@
  * (C) Copyright Linus Torvalds 2003-2005
  */
 
-#define container(ptr, type, member) \
-	(type *)((void *)(ptr) - offsetof(type, member))
