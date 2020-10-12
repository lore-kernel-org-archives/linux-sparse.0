Return-Path: <SRS0=wjqH=DT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F64C433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Oct 2020 22:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E902076E
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Oct 2020 22:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9ks7AOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbgJLWcg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbgJLWcg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Oct 2020 18:32:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4BC0613D0
        for <linux-sparse@vger.kernel.org>; Mon, 12 Oct 2020 15:32:35 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so18751086eds.6
        for <linux-sparse@vger.kernel.org>; Mon, 12 Oct 2020 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cx9L5izp0Cc4W7CVi82VYmH0Db5GUle/O5dcBcPJRRE=;
        b=V9ks7AOu1heNt3CD/TAL6lZg40GVF7Ou4iMhjnPrTcVAa2J2UiDjNlYZpmK9kVj30m
         PHeXVy7lHJlQswFYOS7z548iOKI9iD6H0Obu0Xw2gW8Cj325D3iMpNEwSGOlDtmPRubq
         vu0UI4HJv39enSBsW16pTde6t15p3aD+duE3otyR8SyvrqA1Cx/Y+5wJYmtu0icIlEaC
         /RLmZJ4RrUB3SJoXz4P6t12eF37jkDSV/JGySwYlbtYiUidRxMcHX4H+1bankoSfe17i
         iKX5ifAHZ4MJqjgOj0dxjm89dD7evSVS27EvnWZByStJmTJrfJI54d7PSg1+z4WOVaZa
         yPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cx9L5izp0Cc4W7CVi82VYmH0Db5GUle/O5dcBcPJRRE=;
        b=N2Ssw8AujyIRYhx4Khjf9qZ5+hXK4jNFPyFzexMvcrC8ncRLg4grMkqKBXJB89rlXW
         l+pmVAODrQpipjmR5Znf/1zGDcg+ZUpya3BIdOIqhElb5jjqgon5jmBUwzMPqyXKbuqo
         +cUQ28y83Tn2U1nsAmA/EHlNmsyKaJLWLnUlXRC/0ixKRk52mm8wKi2F7AGZ1x62OCuj
         NhrlwP51zWK4KQnPrfUYQbqZzbKti8EI9i4RoF0XMN/7XPRK3J+PbsMQe3SGVDkVHoQp
         1kMtUv0SLBEIA/wK4S75IgSVea9P3SS2yv0KfWJuKf62D9uvOLjp5QE/sUv+5K4UTNOw
         DQMA==
X-Gm-Message-State: AOAM532LM2iRz7GO6hNcE5X123CAcj7iNGlWp70/SIUPydtziDy3FsL7
        WyslnK3EjIdUDu6IexG9aqqHDY/MkQE=
X-Google-Smtp-Source: ABdhPJzhM7TRNWJDhKD4/0i3n7JHcC3CScTMP+pOnANMmRbqIkA6IdRpfpJCMVfMwwlvpYfnjf0e1A==
X-Received: by 2002:a50:af21:: with SMTP id g30mr16469397edd.46.1602541954313;
        Mon, 12 Oct 2020 15:32:34 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:68a0:d8d7:26ec:2090])
        by smtp.gmail.com with ESMTPSA id a19sm11308906edb.84.2020.10.12.15.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:32:33 -0700 (PDT)
Date:   Tue, 13 Oct 2020 00:32:32 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [ANNOUNCE] Sparse v0.6.3-rc1
Message-ID: <20201012223232.yl3yigcnmbl5dqqk@ltop.local>
References: <20201011225804.fgpismx45eqjivay@ltop.local>
 <11aa016d-7a56-0759-d53b-df406f164545@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11aa016d-7a56-0759-d53b-df406f164545@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Oct 12, 2020 at 07:51:59PM +0100, Ramsay Jones wrote:
> On 11/10/2020 23:58, Luc Van Oostenryck wrote:
> > Sparse v0.6.3-rc1 is now out.
> > 
> > The source code can be found at its usual repository:
> >    git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.3-rc1
> 
> Tested as usual (on 32-bit Linux (LM19.3), 64-bit Linux (LM20) and
> 64-bit cygwin), no issues found! ;-D

Thank you very much!
-- Luc 
