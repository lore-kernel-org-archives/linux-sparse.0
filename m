Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E6C4361B
	for <linux-sparse@archiver.kernel.org>; Fri, 11 Dec 2020 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB59F2410A
	for <linux-sparse@archiver.kernel.org>; Fri, 11 Dec 2020 21:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394380AbgLKUPK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 11 Dec 2020 15:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbgLKUPF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Dec 2020 15:15:05 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D2C0613CF
        for <linux-sparse@vger.kernel.org>; Fri, 11 Dec 2020 12:14:25 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id i24so10632510edj.8
        for <linux-sparse@vger.kernel.org>; Fri, 11 Dec 2020 12:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uli/o6eceoyXB2qiakFjMaGDF66c+5YraeXTkCoYzUo=;
        b=njWUiLW+U8MpmbS2+01Z6B+stNCXPEPeLnxZV8wTZ3L4dsnC/rfavuUrgOHi4cQYdr
         Lr6NMiuki4n14AVuaDl5KC+iH3S/Q78+GsON2cESp8eWUt3PhI57K19dC8+IKRhgMqV0
         5rTOeSkQeTfDSuthLcYMruJ/nhCirG4sIxNlZr4lIqFtHFwXkNhQ9AmKRPg+jts61Tdq
         lEmlyr8CBdqAdfn5DqUqyffDjYzJXZF8btpXr3o0tqCzYhKpDxUb5mwo81gfMA9MHzha
         5N8pRCuB0yp8Q8r5C1GtFqSuypJc5I6Am+/zP11iLO+4AZMRjtKh4yofWGmR5BeTysCz
         IsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uli/o6eceoyXB2qiakFjMaGDF66c+5YraeXTkCoYzUo=;
        b=q4dqdf0faTrf1KaDoDhw4OuaNMhn68jewvfU0BMppV14DajSjRpFYAWfPpw+EOLWbZ
         hEk/3nsUTPrRJIyQW2FVsoyMgq26Dy9J8HFhk9CNVgQQxqenp80+ZTcw7GncfXHWsvUA
         lJVDMq9/1MYBEG5IIDSppakNTzYZHholWMrDwbrPB0zIeuvxomCF9LAqMuLauM4iZDlb
         tcKHjzHTHmfHXpooTb5IIJyht/tAImgqdXCYgvw6m06aySWLOFbMA6agHtoBbf8XJKFI
         iJqs4KTKFFbO0trdwpbfHiFSsOgUm8PZdlEV1uByBPIdWwFOkejx3T6zs+Yl3oKcP/Wm
         +ndw==
X-Gm-Message-State: AOAM533NA/6rFTwXXuL/I5NSMD33v3yn0yhabZIeuvTR6sFM0QhCZrpr
        140Z3trhOV7bumbrQ+COM4PjKzDh58w=
X-Google-Smtp-Source: ABdhPJwrfwkLuvtr5Cmxn7oNNqSHu4JNVxnrxIyXMKKXCYgt1kbGVDvIQBE2pdAVicHz0JA0pQTqyg==
X-Received: by 2002:a05:6402:7d7:: with SMTP id u23mr13415460edy.325.1607717664115;
        Fri, 11 Dec 2020 12:14:24 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:5577:141:774:9c4b])
        by smtp.gmail.com with ESMTPSA id m5sm3967549eja.11.2020.12.11.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:14:23 -0800 (PST)
Date:   Fri, 11 Dec 2020 21:14:22 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH] testsuite: fix parsing of tags used in the testcases
Message-ID: <20201211201422.meemxz2bx5gqbxuu@ltop.local>
References: <20201211130619.71317-1-luc.vanoostenryck@gmail.com>
 <4176615c-73b8-ff5e-d705-f6a71ea49cab@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4176615c-73b8-ff5e-d705-f6a71ea49cab@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Dec 11, 2020 at 04:39:15PM +0000, Ramsay Jones wrote:
> 
> I needed to apply this to get the testsuite to pass on tonights
> 'fetch'. However, my immediate thought was 'what if you had more
> than one space before/after the '*'?
> 
> It just so happens that I had a couple of 'warning: <file>: test unhandled'
> after applying the patch (for asm-empty-clobber.c and asm-goto-labels.c)
> where they had two spaces after the '*', so ... :-D

Yes, I messed up twice here :(
Thanks for noticing.

-- Luc
