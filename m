Return-Path: <SRS0=rEfk=C2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E182FC43461
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902192220A
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVACBh+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgIQOUj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgIQOUh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Sep 2020 10:20:37 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB59C061A10
        for <linux-sparse@vger.kernel.org>; Thu, 17 Sep 2020 07:20:19 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n22so2719457edt.4
        for <linux-sparse@vger.kernel.org>; Thu, 17 Sep 2020 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UprHQRbpLmJw4Ib7e87+sts9FhpoOq1SSY0HkS8N+lc=;
        b=RVACBh+4oi4KRarhzroRtvPx+A2SoqtMHhyL5xQdM3uH9CPNvjefUQiDm1xwGYK1/A
         /lHzE76wahXVm/CwRV4F2noR2Ak9TnRnXUtC4slEbwmuS8OgjCPZEHAL6I/aQ5CXXfhE
         sRcRGo+dDe84RNmSmiK/ukmox6F3tKon8Ng5ASJ0OCvn5J0Tyh3WnYtbLPhG4orXKbyq
         OcUATSKrIkBykwAEvVgUHV8wvnUFPH1osfcvZ5ix8n5O2PcNBey99aVSC5oZTJVTlHK6
         N7J2NRBiC1oqn09jydR1lxgB8di8Dmb3wY1JucWPDOvrbywwl553DaQDqIM0+DXKmiBC
         qO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UprHQRbpLmJw4Ib7e87+sts9FhpoOq1SSY0HkS8N+lc=;
        b=r8/0rB1sYcCmIVVsVTJ+KCo6nOJAuaQFFreAOtcsx0gni6IQud6YL8aWJbV4zimO4c
         c1+M3CNmDO85dtRdrv3OeB3GSPwPwXEiTEuSRlBTXqp9zVBQ2zneao50ro12bcsLrZKP
         xvMki6CzZHRfegkTxIiPnz2ociuQ5GY57PExwzKMuHW9QIjlQjPxeyEFD8kM1a9ITDJw
         ToQuHMRrUB9mtlgtQQIIm/YyeZslwoE12irsktzKQV+dt+sHPZb0Nkd0w4xxoTgUYOXZ
         QllzlIWIu+ViD3pLs07iBPE+lg660aqBBGvt3XUG/7aWciw/FTdzLnU5f1QTXzD1mH2w
         tr7w==
X-Gm-Message-State: AOAM532cqOF+g+k6zj77YlGSZxJ2QI/FY7G1M7Iz32Ham0qkYyYFu5xO
        pMKVyNEbPr9FlnGlyqQUiqRf7Gvimos=
X-Google-Smtp-Source: ABdhPJxVNw0UkWMf29b6WEc8ZnHtLxs/UT3Lat03Fmjp/TC4uLR26TFKaR8p7aILEmHj79iOeMf8hg==
X-Received: by 2002:aa7:d144:: with SMTP id r4mr33447817edo.303.1600352418656;
        Thu, 17 Sep 2020 07:20:18 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a961:f985:92d:1742])
        by smtp.gmail.com with ESMTPSA id t3sm6115323edv.59.2020.09.17.07.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 07:20:18 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:20:17 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: Segmentation fault when running sparse with current linux master
Message-ID: <20200917142017.5fhdjdfrwjyjqlpu@ltop.local>
References: <1832426.vqaiCtIcaR@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1832426.vqaiCtIcaR@n95hx1g2>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Sep 17, 2020 at 01:08:57PM +0200, Christian Eggers wrote:
> Build of the current linux kernel breaks on my system due to segmentation fault when running sparse.
> 
> Sparse version: 0.6.2 (built by openSUSE build service)
> 

Hi, 

This has already been reported and fixed in the main tree in late July.
It's not clear to me if the latest OpenSUSE packages for sparse contain
or not the needed fix.

Can you try the version compiled from the source? It's super-easy:
	cd $dir
	git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
	cd sparse
	make 
	cp sparse ~/bin/

It's what is used by the test bots.

Best regards,
-- Luc
