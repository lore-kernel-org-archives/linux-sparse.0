Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11071C47420
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1212072E
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601570183;
	bh=DGc0UpE8Cgs12gqLLu9kIOC06Ou5f9TB04R75xDzvuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CRExaL5+pFvzlokz6+mgEdAhnrrjcoueavN6+WhvD1NohaKIvzLP/b6XfuDqrvLrt
	 n08B9jhr6Q6UTHBsDapZKmzDgAoxHLUGwDYN/BCZt7hubb3B1G+HztKFlJIBeXfISF
	 Gc4fzB0DNy1FwemL5jdY7kj6jpIn2tRlVsnC8Ycc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbgJAQgX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbgJAQgW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 12:36:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2883C0613D0
        for <linux-sparse@vger.kernel.org>; Thu,  1 Oct 2020 09:36:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v23so5215762ljd.1
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2020 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koh1LmL93ZYnBHojCkjSacBAfLtL7WU8JlNtQLHFwBY=;
        b=Izl7ZjJZC4+LGqKhFXgj6LZHg8dOU5dIfqs6JpwUx3VKfusTJzZjt7P7iOlRxdy3j3
         0gsze6oXHbr6+OWss7/0iMjT6FqXyGVLgaTsDzVefonfx9HCGRlcmNzIJIdJrnS3zpR1
         4H7/DsAW3A0Zh/8MZZqGaVwm0AkiFjuNbSuJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koh1LmL93ZYnBHojCkjSacBAfLtL7WU8JlNtQLHFwBY=;
        b=Uxg5SGC997oAUeM+DKx0WY7Mp9MK8fN06fAtxIrts5uNc9jvfU85Ma8gLzEqYr88P2
         ISrmNoQMrqgw/oMaUJy5dHZ6xqChfIhjnqa0LIw3XllO68OUeOn2pf3IR1AR/jivyg6m
         3u6cgo0cBTK+UNYS0CoSIqOuPnBaJzLzHYt+Xf5yJ41mxysyjzZwbYvqy+/Tc1861lOm
         giUUkj5huKbSRR5n93dV8VW3/v1DwtvFLcJ6TREUiPtYLJdSey84lgFrPqZ7r20fUbdd
         MFWcw0ln9DG8mYNKVNJPFLmxcRVg4VW+EnTGcKcApxAVXnNwGMSiPBZUjCq25PTIo9j4
         KAmQ==
X-Gm-Message-State: AOAM5307Qtw09DbXJgsF8yNsIU7eYqfq2R4hcxyY4UFs0VvWpee08/Ug
        /M5PXXhdlhfMFZ/NbX37iQnXwRIL45/X9w==
X-Google-Smtp-Source: ABdhPJwUmmzJ8nocCmCCvOsKZP3hWgMiEb0k7+oOC65WXZ43nYOBz0krL4J1ouANHQHT70YUG2cUJA==
X-Received: by 2002:a2e:8841:: with SMTP id z1mr2486521ljj.292.1601570179761;
        Thu, 01 Oct 2020 09:36:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a25sm605797lfi.267.2020.10.01.09.36.18
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 09:36:18 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 77so7383701lfj.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2020 09:36:18 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr2629300lfr.352.1601570178419;
 Thu, 01 Oct 2020 09:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Oct 2020 09:36:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9iAOHCtE82UYeRxuYWyPdVyQmY70dm178RWdPu+h0mA@mail.gmail.com>
Message-ID: <CAHk-=wi9iAOHCtE82UYeRxuYWyPdVyQmY70dm178RWdPu+h0mA@mail.gmail.com>
Subject: Re: [PATCH 00/13] add warnings for flexible arrays
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Sep 30, 2020 at 4:18 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Flexible array members have some restrictions (must be last
> in a structure, not in a union) and a number of dangerous or
> non-sensical usage (in an array, in nested structure or even
> using sizeof() on the containing structure).

Thanks, this looks good apart from the one patch I reacted to. Maybe
you had some other reason for that patch, and it's just the commit
message that needs fixing, but as it is now I think that patch didn't
make much sense..

                Linus
