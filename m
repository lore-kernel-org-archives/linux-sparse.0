Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9BAC433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 16:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiFZQHO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZQHN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 12:07:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6F65C7
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:07:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so9858933edm.13
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tv8lr2Op4sJ2l0m16lCHcErr5KBxuhP+hjJDUYE3/0o=;
        b=i3KKvErZFJk6VuAGz8ZPvTDN9BsGfpDN0p39yaYttNSnEABT2fwLra1lRVNBiYCSvk
         aZubc6Y5+f3EItAJPavzSVCR9usBQT0LDXFf72sK6nq1ufzMzgUQrY8ODVbjerFkVTx2
         B3uCmo96nrDm+3NXBX6o6DzLZDnBSZbXPXr3ea/YLwoVBKZheEqM9W5M/P4O7xM4meJ/
         4nULxVmENFF05WSYMBzEwZaBY9i5N7YPVtkE3V8EM8O0idtto+qjrQyntsLye3JCMR7n
         mVXDBl36ysd5jGRAuQaeT5vhiHNn6pVroNDDCgNR8Gg9XcDayZFnOgq9uS30cthxQLuk
         a3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tv8lr2Op4sJ2l0m16lCHcErr5KBxuhP+hjJDUYE3/0o=;
        b=GFXL6UGmAhsOG4r+kI8/M3TjLtrAQ9l+eHJEi9lpdcucN8W1rQ4Ky18V/hi6sAetlg
         NLsvz/pREl3gj2EzUc3IFPkkGN1qCQzkZ+y1i+w8fh8Fw2Me5U2/64V2GsX2IdvkjLXF
         bjow/hdX2LGUlMNlxmZph88gtCS9BrRcoywGdB2Ws/WPdEH7Juw1ks5LRVW75SaD/uiA
         4+tjKS/YQ8umi1ueyQITLClldxCDNvtVSYa7oiWH96C6qn0dJF7LrYY84iwE/joFNzNp
         4stTd54RRsLQt1DiZb4iqGrvk5MkpBoZhbQoCYeBleOGvW35AqxTFxwtSAnqX3OirboS
         cT/A==
X-Gm-Message-State: AJIora+R8LADmxxYtlWlvi4UahAzlcB2ViCEka9vI4RczFBOLMjhSYe3
        2dvv8jRRuBUWCvPELe2lqFE=
X-Google-Smtp-Source: AGRyM1tXcIJIMjGNkOjKVYoeS6x1MDR4KltOLayi1vajyhva2FwYW3hxwSh37yss2AVvQEICLkRYkA==
X-Received: by 2002:a05:6402:50c7:b0:435:923b:9b23 with SMTP id h7-20020a05640250c700b00435923b9b23mr11889280edb.336.1656259631487;
        Sun, 26 Jun 2022 09:07:11 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906604600b006f3ef214de7sm3976417ejj.77.2022.06.26.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 09:07:11 -0700 (PDT)
Date:   Sun, 26 Jun 2022 18:07:10 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Luc Van Oostenryck <lucvoo@kernel.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/6] inline: comment about creating node of node on
 variadics
Message-ID: <20220626160710.ltuelqb5rkde5ubx@mail>
References: <20220626130748.74163-1-lucvoo@kernel.org>
 <20220626130748.74163-3-lucvoo@kernel.org>
 <ff0997f3-aefa-08cf-24b9-c5931e21958b@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0997f3-aefa-08cf-24b9-c5931e21958b@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Jun 26, 2022 at 03:42:30PM +0100, Ramsay Jones wrote:
> 
> 
> On 26/06/2022 14:07, Luc Van Oostenryck wrote:
> > From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > 
> > When inlining a variadic function (unsupported in general by
> > sparse but OK when the arguments are unused and occurs as such
> > in the kernel), the extra arguments are added in the declaration
> > list as SYM_NODE.
> > 
> > But these arguments can already be SYM_NODEs. Sparse doesn't
> > support everywhere such nested nodes (they must be merged) but
> > in this case it's fine as the node will be merged when evaluated.
> > 
> > Add a comment telling the situation is fine.
> > Also, move the code to where the variadic arguments are handled
> > since the fixed one will be anyway directly overwritten.
> > 
> > Note: Sparse doesn't really support inlining of variadic functions
> >       but is fine when the arguments are not used (and such cases
> >       occur in the kernel).
> 
> This note prompted a feeling of deja-vu :) It is simply repeating
> (in slightly different words) the content of the first paragraph.

Hehe, indeed. I'm really bad at rereading myself.

Thanks for noticing.
-- Luc 
