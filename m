Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356B6C4727C
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1A720739
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 21:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4dsgOr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgI3VhO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3VhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 17:37:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DDBC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 14:37:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j2so3364953wrx.7
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XpoF8AgkpNmNHd1AFYdSvTmuMRzk5AKOYRUxIkhnnBM=;
        b=R4dsgOr/JBomOuVhy4CpCaOoeeopZ6QRlw7h6UCB+/YGQ4o512RYFpEmFON8Ixn8ag
         2heFKWHd93kVhCm+af4mYHU+awNZoG6CAZ4rSmQ0huu0cuVLbhcoCt6WFpecOfJjz5at
         XGXOxdreYZuiEhP2QXZbKmPd3RjSMTOIOUsB3X9FJUeLSi9fbR+M2cgl0Z86tj64OYXX
         RzpEzcMzpI0bzHQdY8QcWLO4q6Rm35q2yXPgFgQPhixWIOOJ0bda3/z6xWscO4tCIetC
         9jWRr03qOl6A41tviSrvIgqLyOxRHbl/wFbsg98XawE34yqLnBZgLZyy9sOhW50w84mr
         jwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XpoF8AgkpNmNHd1AFYdSvTmuMRzk5AKOYRUxIkhnnBM=;
        b=L66nMnyEalY/6GJO0XQ12oyN2rSqTTWzRQLrXqqey7YOS6Sr4m5Yenndbz+Ox78vDt
         IAaC3OZbWVyo1DcP22Lzhhr3hlec5oCC7yR90n1o4dMKEH4qlE3UhiDtIve5obbun0Oy
         zPWNEek78RuZCoJfbkPO13L5W7deUqqT0/4IOQk6OqCbMMz3miJ8FoVVKKk/6J7DwiSg
         WbFbusiH2+FPuCfJ7AsUYDBq9sh2OJxNyJ2N/ks57fJ2ebibO95LPf84NLBlFV5p19y2
         utZBcfHeHWeFOjxo62o5RMuzNrM6QXwa04683cUp2aymOH67We5tLcmDuZsq/vIsBQyP
         1hmw==
X-Gm-Message-State: AOAM530mxjiub6LyQyZN6wwrGb0fEaE/7lgHRGTOSauvYIt/Cedzwv4w
        fm2L+BiSAvVKWrmN8VoVjd7GynkjNik=
X-Google-Smtp-Source: ABdhPJwepIxwCuMfRdaWJDY9HzqTsL9NfmfOEshdYahaOis33ouASiivxgmDRUABaWKyE1U4OUHiYA==
X-Received: by 2002:adf:dccc:: with SMTP id x12mr5263812wrm.241.1601501830782;
        Wed, 30 Sep 2020 14:37:10 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id m3sm445016wme.3.2020.09.30.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:37:10 -0700 (PDT)
Date:   Wed, 30 Sep 2020 23:37:09 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: update to format parsing branch
Message-ID: <20200930213709.n2n6qwv5vrso3r5g@ltop.local>
References: <3960bea7-69ef-ed00-66cf-ac73d5cd8876@codethink.co.uk>
 <20200930202934.rjcfxikrzfvesxnc@ltop.local>
 <e73b1efe-16ac-883f-4d33-4982d1a5782a@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73b1efe-16ac-883f-4d33-4982d1a5782a@codethink.co.uk>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Sep 30, 2020 at 09:59:12PM +0100, Ben Dooks wrote:
> On 30/09/2020 21:29, Luc Van Oostenryck wrote:
> > On Wed, Sep 30, 2020 at 09:35:50AM +0100, Ben Dooks wrote:
> > > I've done a rebase to v0.6.2 and put the result up at:
> > > 
> > > https://gitlab.com/CodethinkLabs/sparse bjdooks/printf-new3
> 
> [snip]
> 
> > So, is it possible to respin the series with:
> > * the small changes I've made here above
> > * removing the changelogs from the commit messages
> > * using the same email address for the author and the SoB?
> 
> Ok, will sort these out tonight.
> 
> What's the best branch to base-on for merge?

The one you used for your printf-new3:
	24bdaac6682c ("Merge branch 'linear-fma' into next")

is perfect.
-- Luc
