Return-Path: <SRS0=kwZw=BJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A7CC433DF
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C52070B
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 15:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbmA/BiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgG3PKH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:10:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbgG3PKG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jul 2020 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596121805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ws3ahWvUFwovprVmM2St+Yo7UIaTUsWi58xk29ljtAg=;
        b=CbmA/BiTmZ+VELXBJZpALl8Wm2OHB1Iom0H8FbUmqOfsQASNgxc7urcPk2LyHqBRDRNyoq
        rDaVBbW84mKTR3KCfbcY5qbV1jEakiC8/BIgUb9fQCDQGwJBVV2yk4+5D7fkXxIuLn3gXo
        VZBqNvc3eYNAvjJ+HMG4ZMe4d2TFSAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-4PkSnivCOw6Paf5JT9LQzg-1; Thu, 30 Jul 2020 11:10:03 -0400
X-MC-Unique: 4PkSnivCOw6Paf5JT9LQzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58C91102C7F6;
        Thu, 30 Jul 2020 15:10:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id 010B771906;
        Thu, 30 Jul 2020 15:09:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 Jul 2020 17:10:01 +0200 (CEST)
Date:   Thu, 30 Jul 2020 17:09:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH] dissect: support _Generic() a bit more
Message-ID: <20200730150958.GB6956@redhat.com>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
 <20200728231058.3yakpfw3dqslxq5t@ltop.local>
MIME-Version: 1.0
In-Reply-To: <20200728231058.3yakpfw3dqslxq5t@ltop.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Change do_expression(EXPR_GENERIC) to inspect expr->control/map/def.
The is the minimal "better than nothing" change, technically incorrect
but still useful for the indexing.

Example:

	void func(void)
	{
		_Generic(a,
			int:		b,
			void:		c,
			default:	d,
		) = e;
	}

output:

   1:6                    def   f func                             void ( ... )
   3:18  func             ---   v a                                bad type
   4:33  func             -w-   v b                                bad type
   5:33  func             -w-   v c                                bad type
   6:33  func             -w-   v d                                bad type
   7:13  func             -r-   v e                                bad type

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index a633c8bf..fd09707d 100644
--- a/dissect.c
+++ b/dissect.c
@@ -342,7 +342,6 @@ again:
 	case EXPR_TYPE:		// [struct T]; Why ???
 	case EXPR_VALUE:
 	case EXPR_FVALUE:
-	case EXPR_GENERIC:
 
 	break; case EXPR_LABEL:
 		ret = &label_ctype;
@@ -472,6 +471,17 @@ again:
 		} while ((expr = expr->down));
 	}
 
+	break; case EXPR_GENERIC: {
+		struct type_expression *map;
+
+		do_expression(U_VOID, expr->control);
+
+		for (map = expr->map; map; map = map->next)
+			ret = do_expression(mode, map->expr);
+		if (expr->def)
+			ret = do_expression(mode, expr->def);
+	}
+
 	break; case EXPR_SYMBOL:
 		ret = report_symbol(mode, expr);
 	}
-- 
2.25.1.362.g51ebf55


