Return-Path: <SRS0=qc3T=BK=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CBEC433DF
	for <linux-sparse@archiver.kernel.org>; Fri, 31 Jul 2020 14:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EC522B3F
	for <linux-sparse@archiver.kernel.org>; Fri, 31 Jul 2020 14:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CytbJRxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGaOnI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:43:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48852 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgGaOnI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Jul 2020 10:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596206586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpQYRFrcE8HXPYN3GrirZ8qI6AXFmUt2JnG65PGUoOM=;
        b=CytbJRxy+ufSLRuuXoYtrc5M+D/KT3iWVC5E1AMctAWgMjq71TTm9DdQxcOT3+2/8PjiRW
        wJ/GhXbTfoEbEUD2QNDbWjJmLXHjmEfbmbQ6e8W2iYG9zoo1T+BkJJKSWoO2moKeSsmoNa
        X8H0t/xkqO05A3ZgjzmIYWOGXtUKxPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-GGN-8ZaINu-obGHPbJEppw-1; Fri, 31 Jul 2020 10:43:04 -0400
X-MC-Unique: GGN-8ZaINu-obGHPbJEppw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A766B8015F7;
        Fri, 31 Jul 2020 14:43:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9C3AE7C0E0;
        Fri, 31 Jul 2020 14:43:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 31 Jul 2020 16:43:03 +0200 (CEST)
Date:   Fri, 31 Jul 2020 16:43:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200731144300.GB13775@redhat.com>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
 <20200728231058.3yakpfw3dqslxq5t@ltop.local>
 <20200729112801.GA4360@redhat.com>
 <20200729145025.g26jqfpqcnhd5wed@ltop.local>
 <20200730150837.GA6956@redhat.com>
 <20200730200046.qsbaw4iabb4idjly@ltop.local>
MIME-Version: 1.0
In-Reply-To: <20200730200046.qsbaw4iabb4idjly@ltop.local>
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

On 07/30, Luc Van Oostenryck wrote:
>
> On Thu, Jul 30, 2020 at 05:08:37PM +0200, Oleg Nesterov wrote:
> > On 07/29, Luc Van Oostenryck wrote:
> > > The returned type will just be
> > > quite arbitrary, but I don't know how much it matters.
> >
> > Of course. And this is not good. For example:
> >
> > 	void func(void)
> > 	{
> > 		struct B *b; struct C *c; struct D *d;
> > 		_Generic(a,
> > 			int:		b,
> > 			void*:		c,
> > 			default:	d
> > 		) ->mem++;
> > 	}
> >
> > output:
> >
> >    1:6                    def   f func                             void ( ... )
> >    3:18  func             def . v b                                struct B *
> >    3:31  func             def . v c                                struct C *
> >    3:44  func             def . v d                                struct D *
> >    4:18  func             ---   v a                                bad type
> >    5:33  func             --m . v b                                struct B *
> >    6:33  func             --m . v c                                struct C *
> >    7:33  func             --m . v d                                struct D *
> >    8:11  func             -m-   m D.mem                            bad type
> >
> > But I do not know how to improve it without serious complications, and
>
> Are you thinking about calling evaluate_symbol_list()

I meant, it is not simple to teach dissect() to handle this case correctly.
It understand the types, but for example it doesn't even try to distinguish
"int" and "float".

And I would like to avoid evaluate_expression/etc.

> or about
> something else?

And something else. See the example above, this code is incomplete and in this
case evaluate can't help. Ideally dissect should also report the (possible) usage
of B.mem and C.mem.

> > (so far) I think it doesn't worth the effort.
>
> Yes, _Generic() clearly makes things a bit more complicated here.
> Same for __auto_type,

Yes, but hopefully dissect needs much more simple changes to handle __auto_type.

Thanks,

Oleg.

