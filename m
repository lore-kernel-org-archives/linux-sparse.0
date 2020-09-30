Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED145C4727C
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 21:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02A82075F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 21:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai2MW8dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgI3Vjy (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3Vjx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 17:39:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A6EC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 14:39:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id x23so932543wmi.3
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7tZ9N8kTWYC7imy1jgiLGGjWpq3IkCNR0SqRY0NvEP0=;
        b=Ai2MW8dOVHdk74yJl031gIhpvZx7xP0HDEp6Mo112KDevJJdIr5H9JSA16vY+by099
         5Lr3pPkV549nnnA2igamQDF6uQ2PzXv8OAgT/1zY4Lt3aidO7teX4Of6ep+iVkDqAew5
         3dPfJkAdRrAU9Pp1DELx/Pa9YMDIjWkfHjkddIPBKPmHiaHDAlbRXCiBq0XJW7rTrrBz
         fe5ybb6+tCC1HKMGO9TyfFBc3UOmEOfBLRry+nGe2xThQ2pyYG18b2zFMXxOuzCmOFHe
         K806F6OQtuB0hAa8SMLpRVuTLIUy3oQZn7mFrJiMiVTPr+AGbUqmrJUvHfkW8SSCVPLy
         lO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tZ9N8kTWYC7imy1jgiLGGjWpq3IkCNR0SqRY0NvEP0=;
        b=otVQwn16iQbJWV/gzGczOxAc/QwUurqkxgdG7AkPD/opkTEi2JkMo/bSzwTUMmDHy6
         IP6pzmNv4M1f55E5v/6M68GFE9V0O+5unG7lWPzREVgYFuy1wFuXAMKdZKvQY1sy6w2m
         nJ9HajqjjlLjip6NpVq9mpC8JjuZ3oLOUI+goOL9G7Yj1kH5oZwCPMBRyAWzPA9jX9yE
         qdUODjywV6pZOKrekcqsZJPQWg9byjhJ8STPlTOQsjTtUTeiHyNFCPkt83M2dcNyeYyd
         QRNEb7lDq+OryOMmTV4JekL0l1SkTiwNzPn0borO4KPmlbxN0blBc4mhYGCXYyyXvrPU
         gFwQ==
X-Gm-Message-State: AOAM531E9Skd2TMAhS1ZADko5gba0NfPT12Xq23bFBArdcRWIHEFwqby
        thIVVCat24+i44gQvsfwWZVEKCVvESU=
X-Google-Smtp-Source: ABdhPJzcejR7r6xQC8gZWfXwmKgJuYSRqGLErRtOz021IUxgAiLtazHatqdkBF50Qp0wK3y5PzOmXw==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr5078822wmc.100.1601501990011;
        Wed, 30 Sep 2020 14:39:50 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id z9sm5117178wmg.46.2020.09.30.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:39:49 -0700 (PDT)
Date:   Wed, 30 Sep 2020 23:39:48 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: update to format parsing branch
Message-ID: <20200930213948.hh5dqfzaocgcgipi@ltop.local>
References: <3960bea7-69ef-ed00-66cf-ac73d5cd8876@codethink.co.uk>
 <20200930202934.rjcfxikrzfvesxnc@ltop.local>
 <fb7680ab-eab1-9c32-f515-c2737b78d6a5@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7680ab-eab1-9c32-f515-c2737b78d6a5@codethink.co.uk>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Sep 30, 2020 at 10:05:36PM +0100, Ben Dooks wrote:
> On 30/09/2020 21:29, Luc Van Oostenryck wrote:
> > On Wed, Sep 30, 2020 at 09:35:50AM +0100, Ben Dooks wrote:
> > > I've done a rebase to v0.6.2 and put the result up at:
> > > 
> > > https://gitlab.com/CodethinkLabs/sparse bjdooks/printf-new3
> > 
> > Great.
> > 
> > I've one last request, the email address given as author is not the same
> > as the one used in the Signed-off-by and the copyright notice.
> > 
> > So, is it possible to respin the series with:
> > * the small changes I've made here above
> > * removing the changelogs from the commit messages
> > * using the same email address for the author and the SoB?
> 
> I can't see any diffs between git-authour and the SoB in the series.

	$ git log 5c15b086cd50
	commit 5c15b086cd501633be2ad5fedeeb97c09874409a (bjdooks/bjdooks/printf-new3)
	Author: Ben Dooks <ben-linux@fluff.org>
	Date:   2018-10-30 10:36:26 +0000
	
	    add -Wformat
	    
	    Add option to enable/disable format checking (and default it to off)
	    
	    Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>


The author is:  Ben Dooks <ben-linux@fluff.org>
but the SoB is: Ben Dooks <ben.dooks@codethink.co.uk>

-- Luc
