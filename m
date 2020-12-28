Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2527CC433E9
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019722222A
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgL1Wzv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgL1Ui3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 15:38:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F55C0613D6
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:37:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d26so12427406wrb.12
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BsO3qMHct0BBiOjd/1epqyEJ9cxpsEWl696pzn+ZAzA=;
        b=IYn+Dw/Q+1I+2GaxhbOdGEDq0rXIkElHah6KamFDNWQnT083Fa68Mho76XG54zLmt6
         fvia4wyXB28vPl24zEVKSdYeaaeEsmFFSZdZb3KsBYYG87sTgk2JB7W3TlBfWQOAW/6F
         ZDwHX4CojiFBOHxLt0uc2RpPmv981S0wiZwZ5hA3JUId0K789IP3PczN5pTjki1VnizO
         K4uNfk7+a7dMvyhSW/1z8bbV9LxxGCJCCP9izqcfCGYq+1hdZyoytPckGGSl8ZoVsU3K
         LcPJBJAVb5ax0iduPuG7o+DGRv2uFj55w5hhmdt6jpn7HNO0ooOlhg9Qj4KfnmN91WCt
         ocHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BsO3qMHct0BBiOjd/1epqyEJ9cxpsEWl696pzn+ZAzA=;
        b=mjrkrAKtQKviFvT5GcnxGdpmRNDCqhFaRPzlV4LNAS86wSVZDkqqLn4xmFrFig8Na1
         HWrHymlfMF5xdjgzknzdOQPaOK+mVdn+uio4g/ZV4iqRHTnTgPgQ+AwNfvDA5GGGl2cv
         LeKAI6Wysx9UJCygZ1fdgAcASxkGQzcTgH45bXyyvRyzVRVsBcx1NsfTaXoY4kjJEaZ4
         etgm2WfzZA6CV82bm4JIPQRySJVyK/NBDBpzy9T/qvdcrfQUC29B/RJlvQmtSeLOCEK4
         tUM+yn3dkRqsRf17PMnUna583qAaUemDReQNPr4IQ2PfSO2yMbK/YGhav0Yue/06NRgI
         K2aA==
X-Gm-Message-State: AOAM531ON6RGIa9yuWBYBEUtM8/qKa0ZxzOJJ7ukEwi3Ab9mC8Ug4Pbp
        3Ew5bERRQGYvstGErd+1+MQ=
X-Google-Smtp-Source: ABdhPJxzX+uB7CJPV147kKgObC3F12C8+yacv2v2k8eqTd6ev/+kudTSsjy3v2VqRRdz7IF3XrmC8g==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr51470542wru.327.1609187867528;
        Mon, 28 Dec 2020 12:37:47 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id b14sm56258636wrx.77.2020.12.28.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:37:46 -0800 (PST)
Date:   Mon, 28 Dec 2020 21:37:45 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 08/16] apply_ctype: reverse the order of arguments
Message-ID: <20201228203745.bahrevokbb3ty5si@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-9-luc.vanoostenryck@gmail.com>
 <3be177c7-b744-2d79-7f9b-935bc22b3db9@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be177c7-b744-2d79-7f9b-935bc22b3db9@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 04:47:01PM +0000, Ramsay Jones wrote:
> 
> 
> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> > apply_ctype()'s argument order is: src, dst (so the reading
> > direction) but the assignment/memcpy() order is much more used:
> > 	dst = src;
> > 	memcpy(dst, src, n);
> > than the order here is confusing.
> > 
> > So, change its argument order to comply with the memcpy()/
> > assignement order and stop the confusion.
> 
> Hmm, how about:
> 
> """
> apply_ctype()'s argument order is 'src' then 'dst', which reads as
> copying 'src' to 'dst'. However, assignment, and many library functions
> (eg. memcpy()), use the opposite order for the source and destination
> of a copy operation.
> 
> So, change the argument order of apply_ctype() to mimic the order of
> memcpy()/assignment, to hopefully reduce any potential confusion.
> """
> 
> Heh, well that is probably not much better! ;-)

It's better but I'll try to reformulate it to better express that:
*) the 'reading direction' (left to right) vs. the 'assignment direction'
   (right to left) is a question of API choice
*) the left-to-right direction confuses *me* endlessly, but it's just me.

-- Luc
