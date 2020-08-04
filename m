Return-Path: <SRS0=xnzy=BO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91DBC433DF
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DC520792
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 18:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA7lN/cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHDSwI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:52:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgHDSwH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Aug 2020 14:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596567126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tc+uarOW2um+deUjxrD30eSlJpPz/oG+GT+iGn7NIYY=;
        b=bA7lN/cWKkDCkOsIZ/4RmlTLfY/DA0t18wsC8aKm5ENLqEQtUVQ62cSk5Rm8Ewh3VxMTcK
        R4uFTYArSQClnU/s03ozi3/Hcg2EIYtPAfeYkgmyw0lIwxv3d1l3IeeerryhDwCuvpbXNw
        JJxEBJ0cVsTwNYaS+JyzvyCn/b6m0hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-Uf71OeGpMKGiSR_xjhH00Q-1; Tue, 04 Aug 2020 14:52:04 -0400
X-MC-Unique: Uf71OeGpMKGiSR_xjhH00Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DBB380183C;
        Tue,  4 Aug 2020 18:52:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.108])
        by smtp.corp.redhat.com (Postfix) with SMTP id C40535DA6A;
        Tue,  4 Aug 2020 18:52:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  4 Aug 2020 20:52:02 +0200 (CEST)
Date:   Tue, 4 Aug 2020 20:52:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= / sparse 
        <gitlab+9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>,
        linux-sparse@vger.kernel.org
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200804185159.GA26829@redhat.com>
References: <reply-9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_185002@salsa.debian.org>
 <note_185155@salsa.debian.org>
 <20200802213035.w7bexg4zdusr25xf@ltop.local>
 <20200803145308.o2y4mln5fzlgdr4v@comp-core-i7-2640m-0182e6>
 <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
In-Reply-To: <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 08/04, Alexey Gladkov wrote:
>
> Don't get me wrong, I don't mind renaming the utility. This is a good
> short term solution

I think it would be better to rename it in any case, whatever you and Luc
decide. We do not want the naming conflict, imo.

Just in case, I'd personally prefer to keep sindex in sparse's repository,
but of course I won't argue if you guys decide otherwise.

> but to be honest I don't like the name 'sparse-sindex'
> because it is very long.

me too ;)

> Can we think of something shorter ?

I can't. May be just "dissect" ? But I agree in advance with any name.

Oleg.

