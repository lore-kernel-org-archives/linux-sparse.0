Return-Path: <SRS0=RsLd=DJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF1EC4363C
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Oct 2020 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6148206FA
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Oct 2020 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgNRLXUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbgJBQDs (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQDs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Oct 2020 12:03:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C2C0613D0
        for <linux-sparse@vger.kernel.org>; Fri,  2 Oct 2020 09:03:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k18so2295258wmj.5
        for <linux-sparse@vger.kernel.org>; Fri, 02 Oct 2020 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8VPLVIq3OjXZJ8lkyufWIFXocQqjtC8nInnBZ71Xumg=;
        b=pgNRLXUycC+MqDG9b/aIUovKblocqsRVelwChKlGCH3XETG8514Oz1sw8WKDqR7Yo1
         iherQoWgpbJIGIVHiKo6BHhURlG+5XkPfdLcC1MSLiBXtfBtEtYj5AKagXLAlZdfnHpK
         rOvGGPtDngBuwBiQ7UDYkiJF+B4NPN/b4dYFDixnTRSxy8hzzLK5bB1OBDU4oD50vq/9
         8XeyREPY2lJCNwjlrJKtjT0rOXXsZ3y0oqa6KLZ5oV/Wf9VaYxEMNTxwQ1cjfWN0SsD5
         HTI1yiwPtO6XctRoefxBo9VD3vg4A/g/wzFpeIU/O6xxCetY2NPd8Q2JQ7z+MG9aUSSG
         27oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VPLVIq3OjXZJ8lkyufWIFXocQqjtC8nInnBZ71Xumg=;
        b=fEnPA7zJ1cSJ9d5kanlp1qyv+Kbw/omi/2epTk//X9Ce+CUHtRUxE9W+0LZAubAVKT
         Rz7N/bryzazFSIj+uxLyU3v9JvFDTEK0K+pKwm+8NieLfXQl8mnjx+95Lw61VX8DztwO
         M0k34xpXP2dczzy8KVFLiAbWQm137CoteiA1KdEU+AkB0Pg1A0LN33v056V76qd1gmGQ
         onpfe/4dibPU5mfMev7wq668pGijvi+oxl5cb3TCwZmZz69wlunSnj9Byc8xTyI9pHF2
         /8HxmeSVG1e4Eclx7Sf+A/hz8NzhgwLYhe2XJhPZZMHe17LvrxA3cspwk5xv3IMQORk5
         U9Aw==
X-Gm-Message-State: AOAM532d80MhOrBV38+1raPjqoJkud1swib+xeFIqcpZPgAkKMZ6bMjg
        PxPjIpoftflpRJOuVbCpQ6BX4zRDbtE=
X-Google-Smtp-Source: ABdhPJx2cajVEUOvggqH8B8NMh8BDYlHrHUU5tCo0C6uYzfV0SxjVQz23ODSNHRMfTOtEe3lT46rcw==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr3612778wmg.174.1601654626415;
        Fri, 02 Oct 2020 09:03:46 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a5ae:cc4b:7eb5:86fb])
        by smtp.gmail.com with ESMTPSA id j206sm2262661wmj.5.2020.10.02.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 09:03:45 -0700 (PDT)
Date:   Fri, 2 Oct 2020 18:03:44 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sparse@vger.kernel.org, thomas.preston@codethink.co.uk,
        christopher.phang@codethink.co.uk
Subject: Re: format updates for handing format attribute
Message-ID: <20201002160344.iqrl2i2cv5s3ieay@ltop.local>
References: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Oct 01, 2020 at 10:19:19AM +0100, Ben Dooks wrote:
> Hi, this is the update set for the format attributes.
> 
> I think the only thing I'm still thinking about is whether to
> just merged patches 3 and 4.
> 
> branch:
> 
> https://gitlab.com/CodethinkLabs/sparse.git  bjdooks/printf-v062

This looks all good. Thanks.

I still need to do some runtime checks but this will be for later.

-- Luc
