From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 6/6] remove origval from struct access_data
Date: Sat,  8 Apr 2017 23:19:01 +0200
Message-ID: <20170408211901.40507-7-luc.vanoostenryck@gmail.com>
References: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36703 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdDHVTT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Apr 2017 17:19:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so3594358wmd.3
        for <linux-sparse@vger.kernel.org>; Sat, 08 Apr 2017 14:19:17 -0700 (PDT)
In-Reply-To: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In struct access_data, the field 'origval' seems to be a
leftower of some previous version and is set but never really used.

Change this by removing this field.
---
 linearize.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1f93da9ae..af4c40650 100644
--- a/linearize.c
+++ b/linearize.c
@@ -843,7 +843,6 @@ struct access_data {
 	struct symbol *result_type;	// result ctype
 	struct symbol *source_type;	// source ctype
 	pseudo_t address;		// pseudo containing address ..
-	pseudo_t origval;		// pseudo for original value ..
 	unsigned int offset;		// byte offset
 	struct position pos;
 };
@@ -909,13 +908,8 @@ static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 	struct instruction *insn;
 	pseudo_t new;
 
-	new = ad->origval;
-	if (0 && new)
-		return new;
