Return-Path: <SRS0=xnzy=BO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B2C433DF
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EDF20842
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 20:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2KYWiXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgHDUCG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDUCG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Aug 2020 16:02:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835FC06174A
        for <linux-sparse@vger.kernel.org>; Tue,  4 Aug 2020 13:02:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bs17so12042855edb.1
        for <linux-sparse@vger.kernel.org>; Tue, 04 Aug 2020 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXCLE5mc0n5Czq37GHUE6F5f7JCJxIYV87enNbiw78o=;
        b=J2KYWiXu+Gb9eHJ9u5rZ1dfp//t1DmKpT0sg3r39vQrZ49qf/fQA2K908PgxCwHbMR
         NiUg5O8rNOZ6o2hkHBAUUGzVeLK0wdJJXzdodmcUxJAqusy2c4tDAwtf8k9BMJga4uUY
         SCI3yVAGkt5/43lf/DLtPIQX+ZEpiekbZ4yIThIz4u5g9Ec2E/Y3qIjdopQ7L8fiWl7y
         Fk0492Uif0AH39WcBxxAqQZioIQG1bR7zc2uhedMrcDCrFBylNQGlZABuMLOD6xhGAdq
         7AAbxffSt8dfATgwxY5UWFusu9SQg+la6whdHFUTNbn7flM8TKfuzd7Jd3vifPDAjqWf
         ZLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXCLE5mc0n5Czq37GHUE6F5f7JCJxIYV87enNbiw78o=;
        b=LIirXZcd2wNOlZqzgJuAUfn5j+qj2cw36jWmftUUGK4jR1Z78zocLBDBCbu1nmPNSJ
         QZ/Zej8xZdY4bUWfeHzhIP2wkDcwAns2J4xbycI68VZSapfnRA8pKcush3cAJIxFCGXP
         ag8Ca2qGhgpJuhTqz4pdeLaC2rOK20DyWlFYDKxP7rXk5uFbLMzJ9s8LYl/32/Vejhd5
         KEgsXrLEY5EcNKeSG0mDHqV7C2bkGnxWQsrCXNimkIEYcOKH8TBQ3BwKjWXvHC9WtQWG
         Bh2cdVi4phwCX9qtzIvqKDpNtsJboY8Trh4+Exe4uLWEVh0TxkrFytrXs9B5QXqM5My0
         N61A==
X-Gm-Message-State: AOAM533jFtUUpD4UGqa47AEK42wFZZQf9XOUkUmRmXp5i4Zdj0ynngPY
        v7I/ZN/RmNVuiRfkCELvU1E=
X-Google-Smtp-Source: ABdhPJzKoVKYhMv8/adBqnk5CqbrtTwJXzX2U3x6UsWa91UA2K1xU9aExNvNzwxpxwZV52r4FBGrEQ==
X-Received: by 2002:aa7:dd49:: with SMTP id o9mr22457898edw.92.1596571323593;
        Tue, 04 Aug 2020 13:02:03 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d068:a44f:fa3b:62da])
        by smtp.gmail.com with ESMTPSA id g10sm19044691ejm.120.2020.08.04.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:02:02 -0700 (PDT)
Date:   Tue, 4 Aug 2020 22:02:01 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>,
        linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200804200201.enysyyt6vo3l5ggl@ltop.local>
References: <reply-9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_185002@salsa.debian.org>
 <note_185155@salsa.debian.org>
 <20200802213035.w7bexg4zdusr25xf@ltop.local>
 <20200803145308.o2y4mln5fzlgdr4v@comp-core-i7-2640m-0182e6>
 <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Aug 04, 2020 at 06:38:12PM +0200, Alexey Gladkov wrote:
> Don't get me wrong, I don't mind renaming the utility. This is a good
> short term solution but to be honest I don't like the name 'sparse-sindex'
> because it is very long.

I also think 'sparse-sindex' would be a bad name for anything
but this 'very-short-term-solution-for-this-package'.

> Can we think of something shorter ?

Yes, of course. Propose anything. You're the author of this tool,
as such I consider that you have full moral rights on it, including
its name.  It's really up to you.

Best regards,
-- Luc
