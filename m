From: Alecs King <alecsk@gmail.com>
Subject: [PATCH] fix a memory leak in pack_ptr_list
Date: Sat, 31 Dec 2005 15:20:27 +0800
Message-ID: <20051231072027.GA1619@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:24120 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751315AbVLaHOA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 02:14:00 -0500
Received: by zproxy.gmail.com with SMTP id 13so2191883nzn
        for <linux-sparse@vger.kernel.org>; Fri, 30 Dec 2005 23:14:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>

Free the last entry when the whole list gets empty.

Signed-off-by: Alecs King <alecsk@gmail.com>


diff --git a/ptrlist.c b/ptrlist.c
index 14d8416..467a108 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -72,6 +72,7 @@ restart:
 			if (!entry->nr) {
 				struct ptr_list *prev;
 				if (next == entry) {
+					free(entry);
 					*listp = NULL;
 					return;
 				}

-- 
Alecs King
