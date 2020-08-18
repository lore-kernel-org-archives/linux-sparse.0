Return-Path: <SRS0=Baf2=B4=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43ACC433DF
	for <linux-sparse@archiver.kernel.org>; Tue, 18 Aug 2020 19:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2C220772
	for <linux-sparse@archiver.kernel.org>; Tue, 18 Aug 2020 19:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks8ElLpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRTXm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRTXj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Aug 2020 15:23:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD86C061389
        for <linux-sparse@vger.kernel.org>; Tue, 18 Aug 2020 12:23:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id di22so16137171edb.12
        for <linux-sparse@vger.kernel.org>; Tue, 18 Aug 2020 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KxH6crY0oGG19eTpcCUp7otXtzxhVDUpnI+7IFZ44to=;
        b=Ks8ElLpCrAqLta6PbrilGgyBJuko8Ex5Qx119uNtrLZEL2Mq4sLMb0Jz3VibURj9a2
         2TB/gJq9WlzC1H93LaQbKGKuK2y+Qw+nwiIABJsM8zHPG0A+pobkIuCKgcekS7nFeVBe
         VwLdzLCqD7G1j+kk14QUpS74IdMrnx11LukbXIZcMb0/TKWXEf6cj64D4oqmM++vVV8L
         kbvKdk7or+E6VgI8I0lKaj4kypRGPOGQqLSXco6OAC7t2d8T4WpYBKIswIHmsQvFNoyW
         Pc6+AIQT+6yagnVp/9pskegYiOPbRN0iCdOmxAFUEIJhVjeXshELLQ7Nc1NcU9d7XCcQ
         dZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KxH6crY0oGG19eTpcCUp7otXtzxhVDUpnI+7IFZ44to=;
        b=JK6foCZJdLtMj98eb+tXdm9DKKV9O8C/uSQteBx/xe7ycvM80XPKGfBwV8N/udpgnR
         EP71LGsSvRwQ7wWYMA7ZKK50rhG/VOjhbeNo5SP0TYrOsVLheuAnzlgTuLMTuVkul1WW
         Qtl4VtVAms1uJOoT2evO08n28FUDmLv1bvwUEAX73oZwjm9jpr4T5wnz2uakC5E9FtIY
         +WnjghrMm4gUBvHDpe45cwLse/IsCaJ5zp35fuEQabE4peBNejfpgiSonEh1a52fvAGQ
         J0N9GhMJP+ymONbb+VXxQEJ8mvJK/iUaVwwPFoLjsWDKVaJOIb2TGJGJtkqGQ9JLpVnv
         7M4g==
X-Gm-Message-State: AOAM531+cLVTV26n8ZnGEUNPNHakINdzkrhJxVPXiM1TAuz9DTQHlTYq
        3BQg55fKlAAN3PpMQXCgR64=
X-Google-Smtp-Source: ABdhPJwWqB781CWGiEEfDY+5UNBN4i2pmC13gLXem8GML4xa2mHA6HC21ydQtC/ou2M/uivOPGGY9g==
X-Received: by 2002:a05:6402:3193:: with SMTP id di19mr21767348edb.224.1597778615944;
        Tue, 18 Aug 2020 12:23:35 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:4849:d57c:e9b7:a560])
        by smtp.gmail.com with ESMTPSA id w18sm16978363ejf.37.2020.08.18.12.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:23:35 -0700 (PDT)
Date:   Tue, 18 Aug 2020 21:23:33 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux-Sparse <linux-sparse@vger.kernel.org>
Subject: Re: sparse problem with duplicate __iomem?
Message-ID: <20200818192333.jal3gsdgz2mnhssr@ltop.local>
References: <bdbcbf14-07b1-76e1-faee-4d27225778e5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbcbf14-07b1-76e1-faee-4d27225778e5@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Aug 18, 2020 at 11:09:52AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On kernel 5.9-rc1, either i386 or x86_64 builds, I am seeing these
> sparse warnings:
> 
> ../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: warning: duplicate [noderef]
> ../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: error: multiple address space given: __iomem & __iomem
> 
> for this source line:
> 
> 	u8 __iomem *dst, __iomem *sig;
> 
> 
> Should one of those __iomem-s be removed?

I think so. It's a bit like writing
	int const *a, const *b;
or
	int unsigned *a, unsigned *b;

> I.e., does "__iomem" apply to everything after it, up to the ending ';',
> or just up to the next comma ','? 

The (simplified) syntax for declarations is:
	declaration:
		declaration-specifiers [init-declarator-list] ;
	init-declarator-list:
		init-declarator
		init-declarator-list , init-declarator
	init-declarator
		declarator
		declarator = initializer
	declarator:
		[pointer] direct-declarator
	pointer:
		* [type-qualifier-list]
		* [type-qualifier-list] pointer
	direct-declarator:
		identifier
		...

Essentially, attributes are type modifiers, some acting like
qualifiers and others are more like specifiers. But qualifiers
and specifiers are never allowed directly after the comma because
they appertain to the declaration-specifier part of the declaration.
So, yes, the first __iomem applies to the whole declaration and
the second one should be removed.

But maybe it's not 100% clear and the best should be to use a
separate declaration for each variable?

Best regards,
-- Luc
