Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E1C43331
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF9E2222A
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgL1Wzw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgL1Vk0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 16:40:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1BC0613D6
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 13:39:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c124so547893wma.5
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 13:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ia26yDoq4nauhcsyzDn8wdrnIdXtBJjmBnaUzVQMszg=;
        b=iBoPXx4f1eTI8AsDc/OLBm9aUdrERAI/ilxWl3f3x82IyowPdD8j4OH69Hqi98p6zk
         2XYfnpwzmPfHMg1bvpBAUcH/+uhkt58PVuRUvawZ6lbQqj7xTM31kkGjaVPhgY+vni5F
         6F6SiprTDVpKqrpOP6Zpwk1k4Wwv4oxOzd6UIDbm3zUBmgX29jTNquQQzoLNYXTToBdt
         Qd8QiAoShuzSmZgS2IUfL4qmXsOiAtI4MEUkH5q8f19pCfyfXCfeXdjH7qh7tdkubjoj
         /aG3oDBZZssB4A3BOsz5TqyHyKzRRiX1Wij9PAdONFQMT8EgxvslnEM5HmBw8NoZMmJ8
         a9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ia26yDoq4nauhcsyzDn8wdrnIdXtBJjmBnaUzVQMszg=;
        b=amcdJAI55+O8gWQCcsU7gvNVRcp8juWNZB3edVFVJRdLuqmmsxj2QzqPo8mFVAG+eN
         SOMNlFDPBgwYU4Jyxt78/TwMZc4M7XzQKz23yHteYz+eSGqrKMNEvC6Fh79NwmPhxyNO
         t7ndgXY2B9V43EucAeBMXhnibwFqLuJTH5CovRX1ufTXRNZ3/y0x2mxJIYZk6l/6BTMP
         Z9eAicrYqVM1yjwA6hhlUZ9ZAqyWY80WrBzfj536PRIauxTUVrMu9kT6kOii+0kX1n16
         JZ0oAf5zQIMsLNBTk5TbeiM4yJo58mgMu6OEiPRRea0RG7LO0xsrRtWit7kXl5W4N2PA
         S36w==
X-Gm-Message-State: AOAM533NtECPpiNJGrNJGSBykM3cck1aCVUE3VyHcLI+57+nu8SUbqcs
        ZRslocrtGb15fLXygibNo3NmlwjjEcA=
X-Google-Smtp-Source: ABdhPJw+TH8kFThA1Rt/N7bmZUWMU3vTknBM6OO+PicpvTVYI66DPuC4OX6o6uPyPZtbj0MdHtVC0Q==
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr652487wma.105.1609191584846;
        Mon, 28 Dec 2020 13:39:44 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id c10sm60547964wrb.92.2020.12.28.13.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 13:39:44 -0800 (PST)
Date:   Mon, 28 Dec 2020 22:39:43 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/2] fix rem_usage()
Message-ID: <20201228213943.honhyxpk6apd23tg@ltop.local>
References: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
 <20201227092759.30999-3-luc.vanoostenryck@gmail.com>
 <52a111f5-aea4-d705-f0c3-d71ecb2226dc@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a111f5-aea4-d705-f0c3-d71ecb2226dc@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 05:22:36PM +0000, Ramsay Jones wrote:
> 
> 
> On 27/12/2020 09:27, Luc Van Oostenryck wrote:
> > rem_usage() is used to remove an element from a def-use chain. Optionally,
> 
> Hmm, rename this to 'remove_usage()' at the same time?

It can't, 'remove_usage()' is already taken and 'rem_usage()' is more
for internal uses than 'remove_usage()'.

-- Luc
