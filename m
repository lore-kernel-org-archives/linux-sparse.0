Return-Path: <SRS0=pmk5=BI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523EFC433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 11:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F18420829
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 11:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWLe/rz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2L2I (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:28:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25474 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgG2L2I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jul 2020 07:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596022087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmP5nylvfJgy0vsiygko1wmwRfGVPv7+BQMR0up0P/k=;
        b=eWLe/rz/MGhsX5M/rmvz08j8VUXMlwId4hYStF/GxFdAf1AVxJlsOSdyX/TwuHx8DFT4Dm
        hmCykL/GpZSlZjs7nZyQjblFSyx76cSezGAWY/AIUCxnVtNUT/XLeZ0capDmi3BNuL/pdm
        q/qUcqVX68927AWgZO+iYzQmJdef8B4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-HAv_h2CqMxSoPMVfuVzKnA-1; Wed, 29 Jul 2020 07:28:05 -0400
X-MC-Unique: HAv_h2CqMxSoPMVfuVzKnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82ED6800471;
        Wed, 29 Jul 2020 11:28:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7891A5C5B7;
        Wed, 29 Jul 2020 11:28:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Jul 2020 13:28:04 +0200 (CEST)
Date:   Wed, 29 Jul 2020 13:28:02 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200729112801.GA4360@redhat.com>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
 <20200728231058.3yakpfw3dqslxq5t@ltop.local>
MIME-Version: 1.0
In-Reply-To: <20200728231058.3yakpfw3dqslxq5t@ltop.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 07/29, Luc Van Oostenryck wrote:
>
> OTOH, I wonder what can be done without first evaluating
> (the type of) the controlling expression and the types of the map
> (if I understand correctly, evaluation is avoided in dissect).

Yes. I'll try to think a bit more, but so far I think I'll simply
send the patch below.

Test-case:

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


Of course, technically this is wrong, it looks as if all 3 variables are
modified. But not that bad imo, dissect doesn't even try to be "precise",
and this output still looks useful for the indexing/etc.

Oleg.


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

