Return-Path: <SRS0=kwZw=BJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E62FC433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5462074B
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 20:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5WVhIG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgG3UAw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgG3UAv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jul 2020 16:00:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605BFC061574
        for <linux-sparse@vger.kernel.org>; Thu, 30 Jul 2020 13:00:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so6558353ejb.11
        for <linux-sparse@vger.kernel.org>; Thu, 30 Jul 2020 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cjXRuQc4fSTZmVxSdZicIWkveJoDohCJrpqEliG6Ovo=;
        b=Q5WVhIG+XAQaayP3HpzB/5KAp/Z+DrDY6w4dmUgKnWZP4gS/0IgGl7NLu1f+DNE6Or
         9omwesufrXR/CW8+XARWaOQIS8khPoIPMgSxayO0Ux/V1WisQYhWbr1KA63MGJXiwl+3
         l95vVqGuS13XFcR4NGfMfryhWfae/bFYLCK8DYoZMSXLoOIAP2Es3kqF2bT7sjsEUYxS
         7lvXo4SvXAbRr55ejB1ULF5KKIwj0Kgb0vi13oS5YiVcqUYWWweUHRDSj8y5A4hW+h6t
         Q+9NWINTXvx1ei8DiSlQKAnnLSXH6ZoOimpBED7qmeBrDjpSDeX2NzijRinIMC9mz4nA
         1TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjXRuQc4fSTZmVxSdZicIWkveJoDohCJrpqEliG6Ovo=;
        b=mkTIofexxscegSCC2HKXiRCBqvAuZoL9ygiDnCN8LnmuPoqCRShc25fPI5rqcaCqzn
         fjJtlEEfR8dQICELGyXgx3fVk1G9zbXc613K+ol5vTMJaLU0FKHDdsMZJMWNnXundo/x
         0OdhtDv6TGpYVxVZw1kiqUU9PIm2ffplF1aJv3UR+U9aIAXf3gze73STVr4wjNJqXN+W
         wIo/udYTfpViplDJnxZSS9AtPK1fu2LeUTdN/UYf2PSo1XEbMjiLkUrcD/+H12j6uXGN
         L0ACAblmrCU+yvEnoaIbFsEHX5HDte4i2LnJkNVKvbVWC2/A5xEx6FDsj3D/tfRQDF3n
         irOg==
X-Gm-Message-State: AOAM531nPbjUldoSO9QB184NC+7hSILKf+nu6q+tEmmDIqM8CqAiyvd3
        VU/GV+wxPKu80Gx6VL/AFLU=
X-Google-Smtp-Source: ABdhPJxasn29Ld6nNTMUlTgGCNCwB3U8VDP1NNJjjE26D7CdbF/hHo6MGJV+g5Y7Z6d8zS3EPO4U4w==
X-Received: by 2002:a17:906:a2c2:: with SMTP id by2mr752013ejb.86.1596139250087;
        Thu, 30 Jul 2020 13:00:50 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:ac45:7ad7:8f03:534f])
        by smtp.gmail.com with ESMTPSA id q6sm7143636ejn.30.2020.07.30.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 13:00:48 -0700 (PDT)
Date:   Thu, 30 Jul 2020 22:00:46 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200730200046.qsbaw4iabb4idjly@ltop.local>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
 <20200728231058.3yakpfw3dqslxq5t@ltop.local>
 <20200729112801.GA4360@redhat.com>
 <20200729145025.g26jqfpqcnhd5wed@ltop.local>
 <20200730150837.GA6956@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730150837.GA6956@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Jul 30, 2020 at 05:08:37PM +0200, Oleg Nesterov wrote:
> On 07/29, Luc Van Oostenryck wrote:
> > The returned type will just be
> > quite arbitrary, but I don't know how much it matters.
> 
> Of course. And this is not good. For example:
> 
> 	void func(void)
> 	{
> 		struct B *b; struct C *c; struct D *d;
> 		_Generic(a,
> 			int:		b,
> 			void*:		c,
> 			default:	d
> 		) ->mem++;
> 	}
> 
> output:
> 
>    1:6                    def   f func                             void ( ... )
>    3:18  func             def . v b                                struct B *
>    3:31  func             def . v c                                struct C *
>    3:44  func             def . v d                                struct D *
>    4:18  func             ---   v a                                bad type
>    5:33  func             --m . v b                                struct B *
>    6:33  func             --m . v c                                struct C *
>    7:33  func             --m . v d                                struct D *
>    8:11  func             -m-   m D.mem                            bad type
> 
> But I do not know how to improve it without serious complications, and

Are you thinking about calling evaluate_symbol_list() or about
something else? What kind of complications?

> (so far) I think it doesn't worth the effort.

Yes, _Generic() clearly makes things a bit more complicated here.
Same for __auto_type, which is not yet used by the kernel but will
probably be soon.

-- Luc
