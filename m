Return-Path: <SRS0=xoI2=CQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D67FC43461
	for <linux-sparse@archiver.kernel.org>; Mon,  7 Sep 2020 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FC5215A4
	for <linux-sparse@archiver.kernel.org>; Mon,  7 Sep 2020 22:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d26hEKlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgIGW2n (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgIGW2h (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Sep 2020 18:28:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56497C061573
        for <linux-sparse@vger.kernel.org>; Mon,  7 Sep 2020 15:28:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so14036091edk.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Sep 2020 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQEJkYBaHsYu8hTVgDKnt7CXPkXSd0x5a+Nv8DpvBaE=;
        b=d26hEKlfO4DC3hrBxj4erUdjtvQcL16Ips8DWAakIPA4+a3jhq4beBmWJEG2bLXu+5
         adsYs4xZnRr+qXpI6DTAiEi+D6aLGxLiS0uRHgfJr249OoNFdYyFFtBZzXxA3maJt0S0
         3YawK7emCy6EAZEgKh+dVD1a3bruyNhJ6baPicBRhvDaMrgPeCDjNtnazUmEyMBeYKT/
         MztPFkfiPDxFsWcRzskfjXQlYXeNXG0k7EqgzBABUU/FYVkowTa6BYotw4XUDENFpbbq
         qvD8QiKRkQiJ6PRzYlBmJtyyAXkbZvAqviWLFDYg75hB1Lq64oRddhuOaCD0fBXpLSPJ
         R4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQEJkYBaHsYu8hTVgDKnt7CXPkXSd0x5a+Nv8DpvBaE=;
        b=YYxTNKUW8/QqRsU4h9DT/q7aeprB8nR1EdDT6rsx6aVa4ihaVzelDE2EU6nTdwvK1d
         UG8xxsp56OEcUPleVDSdy7f0Sq+mDV68oO2wg6jEaKNcBCAHwbOcv/MskgTFn0mr3b6D
         3fZiriYgcKJDWONA2wXsRF8G2xCNB3+8+sBV/SeRtc2VzKhQF9qXreL1QHIaI2UTUhOl
         GfV6dyOhkpTz0elGkHUJqN7p9la3nPWJ8zevvL+faYH8rZp16KFOACKHqOD6M0op4v6I
         xgRLay66swh2XFLvSU9EU0ij0YwCXEtNLvw4QjkEaQhyu9zR0LlOPqtHTcesxrANrv+L
         xP/Q==
X-Gm-Message-State: AOAM530F8T4wGiNAgAAgDPg43i5RfkA5VvZ28s6WUuKUHX73Q1anAaMi
        ybvEY2vWcTuokQd0ovnAUjhOnCk9It0=
X-Google-Smtp-Source: ABdhPJzidPI+H/gJWY/IzGWAgDGHFAKlCx0YVP/8czzN/j2Pa/LFy4x5REJvBL4q64YXmyF/e4vQ2w==
X-Received: by 2002:a50:d7ca:: with SMTP id m10mr13903930edj.259.1599517715112;
        Mon, 07 Sep 2020 15:28:35 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a4cd:133f:f17f:2a5d])
        by smtp.gmail.com with ESMTPSA id ce14sm16235211edb.25.2020.09.07.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 15:28:34 -0700 (PDT)
Date:   Tue, 8 Sep 2020 00:28:33 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/3] add more testcases for existing AND/OR
 simplifications
Message-ID: <20200907222833.tsbptcqsvk4lzikx@ltop.local>
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
 <20200906211646.58946-3-luc.vanoostenryck@gmail.com>
 <5ba9625b-4670-ea6a-c59d-d795406b9c39@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba9625b-4670-ea6a-c59d-d795406b9c39@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Sep 06, 2020 at 10:54:25PM +0100, Ramsay Jones wrote:
> > 
> > diff --git a/validation/optim/and-shl-or-and0.c b/validation/optim/and-shl-or-and0.c
> > new file mode 100644
> > index 000000000000..298dcb434fc7
> > --- /dev/null
> > +++ b/validation/optim/and-shl-or-and0.c
> > @@ -0,0 +1,15 @@
> > +// =>	(b << 12) & 0xfff00000
> > +unsigned and_shl_or_and0(unsigned a, unsigned b)
> > +{
> > +	return (((a & 0xfff00000) | b) << 12) & 0xfff00000;
> > +}
> > +
> > +/*
> > + * check-name: and-shl-or-and0
> > + * check-command: test-linearize -Wno-decl $file
> > + *
> > + * check-output-ignore
> > + * check-output-excludes: or\\.
> > + * check-output-excludes: lsr\\.
> 
> Hmm, this still doesn't sit right - have you discovered the
> reason for this?

Sorry, I don't understand what I can add.
Such expressions are simplified into something where the OR and
the LSR are absent. This is what is checked by the test.
 
-- Luc
