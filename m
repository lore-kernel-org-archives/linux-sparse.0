From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] ptrlist.c: fix a typo in a comment
Date: Mon, 18 Jun 2012 23:39:21 +0200
Message-ID: <1340055561-28496-2-git-send-email-j.neuschaefer@gmx.net>
References: <1340055561-28496-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:51108 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753627Ab2FRVj1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2012 17:39:27 -0400
In-Reply-To: <1340055561-28496-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 ptrlist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ptrlist.c b/ptrlist.c
index 2620412..5dc1117 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -35,7 +35,7 @@ int ptr_list_size(struct ptr_list *head)
  *
  * The array to linearize into (second argument) should really
  * be "void *x[]", but we want to let people fill in any kind
- * of pointer array, so let's just call it "void *".
+ * of pointer array, so let's just call it "void **".
  */
 int linearize_ptr_list(struct ptr_list *head, void **arr, int max)
 {
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
