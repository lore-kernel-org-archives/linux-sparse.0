Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB39C4360C
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2EA223C8
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgL1Wzw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbgL1VNQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 16:13:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFF4C0613D6
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 13:12:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d13so12493183wrc.13
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 13:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=foFtcGiyXiPMe+rQwkI8ltNxR3fR758fLw9rx2dkIvo=;
        b=tVabswoukTy2x1ujr5+Uca6XjWn0srSBgVjj9WlCImSdI9nv+Vc1yq/shIzva/6JR2
         HhnJTNKOgawGbJrNiFVSBzWXrej/bj1W3+w8zEPFF6S3EpvLdLZnoyStYSaY4s1sIloj
         Q92AJWvji27IfZIPoFbLvnF66xCr2kBYnoquzWnxKr5ZZ2xc+9rWHOU3hbdecwgQSVSz
         wh6GxL9KiYkQN0H3S9kUTj2bUYrge1JE0CfRS5OKi8+c9uoYUa09Ytc4BKEYMYrqVWoS
         yUsU1FaY+WV3N+3Gk5QNu6ZB4lFasa/PnGH23VA+52LfGd5G6BF+V3mPMdap2tUfKr51
         YSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=foFtcGiyXiPMe+rQwkI8ltNxR3fR758fLw9rx2dkIvo=;
        b=lZQKwgPCSdbnT6tuTLe0frmLGnAJv9EeBk8yzetVx8LPPEwhygDx775wm7MuZwoWTb
         Dz92+s9kJd8UVKeVrTDQBuJOhmhQpe5YNZ3/A2Oc9g1kesLC5ntO36w5VjeUN2xMoAmN
         YvJZtqpBO8m1cWvK+ikYGThma5ydirGW8gJfPdOfB1e4td0+Ec+09VdKvsxlEHaVhVCW
         8GlcGqio9hQh3eXSVXUPx/2Dka8W8WS3iMOIy/TKFnRXX9adgbGniZWFH9IoWAYuz/sX
         xMkcRLWurzbbAcfGM/IAefy5Dg1apRu5tUgQKz4ZLE0iXY3oGIrldzjxsOW7pX9PO7zy
         twnA==
X-Gm-Message-State: AOAM532JaYRND77ppMoD+D2BbD4y7NwQY/WhCVjsVvf2D7lBcBfj0kDV
        u0jA6QSso/W0d9Q1dEGGEoc=
X-Google-Smtp-Source: ABdhPJxyaz4Zoc5DSUpKmwWnAb23fiedHBuZWAX8dLTVqtqd1R0SG07rnc+9SlHq0TCufqqe5pgxzQ==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr52077380wrx.7.1609189954530;
        Mon, 28 Dec 2020 13:12:34 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id h184sm678723wmh.23.2020.12.28.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 13:12:33 -0800 (PST)
Date:   Mon, 28 Dec 2020 22:12:32 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 15/16] packed: no out-of-bound access of packed
 bitfields
Message-ID: <20201228211232.weajlanyegb23hef@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-16-luc.vanoostenryck@gmail.com>
 <09c3a7d2-7787-e7af-53ff-089312f3fd50@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c3a7d2-7787-e7af-53ff-089312f3fd50@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

> 
> Hmm, I didn't know the IR could represent this! ;-)

It was already used but I would prefer to avoid it.
For example, when copying a structure:
	struct s {
		char name[5];
	} s, d;

	...
	d = s;
will linearize into a single 40-bit load + store.
In this case, it's quite OK because it directly translate to
a memcpy().

> Is the 'lowering' code already present? Maybe next patch.

I had several versions, all more ugly than the others. It's why
I ended with this 'OK, keep things simple for now'.
Also, there is several ways of doing this and I'm not convinced
of which one  should be used. Worse, the case:
	struct {
		a:10;
		f:14;
	};
should probably not be handled like the case:
	struct {
		a:5;
		f:30;
		z:5;
	};
since the problems are different (the first one is just a question
of not doing an out-of-bound access, while for the second case we
have a field not wider than 4-bytes but which can't be accessed 
in less than 5 bytes).
 
-- Luc
