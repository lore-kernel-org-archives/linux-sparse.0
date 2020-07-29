Return-Path: <SRS0=pmk5=BI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3227C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59BE20809
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 15:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYXSjuuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2PeW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:34:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbgG2PeW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jul 2020 11:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596036860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7AmTcd43IkfbUxRIC38eZbfMTM9WW2fUZF63QkD4DM=;
        b=RYXSjuuoRxtAqgDzzDvKXTIBpJgUI3NgLHvVdprnOqxuHU7Nj5NOJjJHHvAOgqJtV+yozq
        vqUto37yBCNUj3ktHSvMKlVgzyxBBdeUhRqPnaWEIiApDb4DBngG+iwEJlj6A/1ySRL/N3
        igElHgmGWLgbrX69f77yR7tLRtnx0o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-gFB4Rzi6PdOlhdh4s36qMQ-1; Wed, 29 Jul 2020 11:34:17 -0400
X-MC-Unique: gFB4Rzi6PdOlhdh4s36qMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB611801E6A;
        Wed, 29 Jul 2020 15:34:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id D258587307;
        Wed, 29 Jul 2020 15:34:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Jul 2020 17:34:15 +0200 (CEST)
Date:   Wed, 29 Jul 2020 17:34:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [PATCH] dissect: use struct symbol::visited/inspected instead of
 ::examined/evaluated
Message-ID: <20200729153413.GB4360@redhat.com>
References: <20200729145132.81479-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200729145132.81479-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
> The dissect client uses struct symbol's fields 'examined' & 'evaluated'
> to avoid reprocessing the same symbols. But these fields are used
> internally by sparse for type examination & evaluation and despite
> dissect not doing these operations explicitly, they can be done
> implicitly

Yes. For example, test_dissect.c calls show_typename() and this can
lead to examine/evaluate.

I didn't bother to fix this because test_dissect.c is the very basic
debugging tool.

> So, add a new field to struct symbol: 'inspected' and use it, as
> well as the existing 'visited', instead of 'evaluated' & 'examined'.

Thanks! Looks good to me.

> Note: when used on the kernel, this patch avoids a lot of warnings:
> 	"warning: r_member bad sym type=7 kind=0"
> 	"warning: r_member bad mem->kind = 0"
>       and creates substantially more normal output.

So this is test-dissect, sindex should be fine even without this patch.

Acked-by: Oleg Nesterov <oleg@redhat.com>

