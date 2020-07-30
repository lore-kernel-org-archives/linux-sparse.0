Return-Path: <SRS0=kwZw=BJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A00C433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 15:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438542070B
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 15:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czGAZ1S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgG3PIq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:08:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgG3PIp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jul 2020 11:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596121724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iKrvGf6/BMfCKd/ZD1AeUNPUIP+H2wzQmZNJbGG63A=;
        b=czGAZ1S75tst9z8U4fKtgdQ25I4M6F5RcLkjQxwkeMEuGa43bg69VzJ99Ba03mE4B8k9wm
        qy2Z8XOZa+wlUKe3EdLgPmQOoYO4dhXcEEJBB5Jn9BkRNcQ3XD3OKcnvLL7DfMkYlCAmop
        pGgPw8N1gWxXiNoJeKIZN72yJZ4l43g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238--2rdmI52MzSIpRsZ5FIR2w-1; Thu, 30 Jul 2020 11:08:40 -0400
X-MC-Unique: -2rdmI52MzSIpRsZ5FIR2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5C2F19200C1;
        Thu, 30 Jul 2020 15:08:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id AAA031DB;
        Thu, 30 Jul 2020 15:08:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 Jul 2020 17:08:39 +0200 (CEST)
Date:   Thu, 30 Jul 2020 17:08:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200730150837.GA6956@redhat.com>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
 <20200728231058.3yakpfw3dqslxq5t@ltop.local>
 <20200729112801.GA4360@redhat.com>
 <20200729145025.g26jqfpqcnhd5wed@ltop.local>
MIME-Version: 1.0
In-Reply-To: <20200729145025.g26jqfpqcnhd5wed@ltop.local>
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
> > +	break; case EXPR_GENERIC: {
> > +		struct type_expression *map;
> > +
> > +		do_expression(U_VOID, expr->control);
> > +
> > +		for (map = expr->map; map; map = map->next)
> > +			ret = do_expression(mode, map->expr);
> > +		if (expr->def)
> > +			ret = do_expression(mode, expr->def);
> > +	}
> > +
> >  	break; case EXPR_SYMBOL:
> >  		ret = report_symbol(mode, expr);
> >  	}
>
> Yes, that should do the 'walking'.

OK, I am sending this stupid patch. Better than nothing.

> The returned type will just be
> quite arbitrary, but I don't know how much it matters.

Of course. And this is not good. For example:

	void func(void)
	{
		struct B *b; struct C *c; struct D *d;
		_Generic(a,
			int:		b,
			void*:		c,
			default:	d
		) ->mem++;
	}

output:

   1:6                    def   f func                             void ( ... )
   3:18  func             def . v b                                struct B *
   3:31  func             def . v c                                struct C *
   3:44  func             def . v d                                struct D *
   4:18  func             ---   v a                                bad type
   5:33  func             --m . v b                                struct B *
   6:33  func             --m . v c                                struct C *
   7:33  func             --m . v d                                struct D *
   8:11  func             -m-   m D.mem                            bad type

But I do not know how to improve it without serious complications, and
(so far) I think it doesn't worth the effort.

Oleg.

