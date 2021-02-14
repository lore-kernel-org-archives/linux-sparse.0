Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26705C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF5F64E26
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 20:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBNUma (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 14 Feb 2021 15:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhBNUmN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Feb 2021 15:42:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7904C061574;
        Sun, 14 Feb 2021 12:41:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v9so1494864edw.8;
        Sun, 14 Feb 2021 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KDcTJbYVBqjxtWBYJMrAm8lX3M9uPlglIDxfV1YFvj8=;
        b=JZhXGU7P/V1+TT/yLZELapCCPW4GQMsCAHhqsmDr+uHyw7GjSd81Rd8W96blnCNozm
         V1FDtM5ZkM+aRAvAyEHyNllsrlKIVu2UPQUpmVjUyQsrgWLKduKLUf4S2UPK92Fasqo1
         wV02AoChHhlYWVkGQ4UKt3lMp/D8yisjxIrEls6JEB1yJhuA6b0gV5zxEwDOb4IQubp9
         /lFfYzhv6oUGfVApr2O516sTUQr81FvfKdsZdhao4VMM6x8ayCg4lLs+i2mJaZDBdHWw
         sZguvPKpV8poFLNSitfO2p1D+jxW2aJEEa0uShXmxcbR5qJTJVkIjpe3qHkw2w+3rB1e
         ppzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KDcTJbYVBqjxtWBYJMrAm8lX3M9uPlglIDxfV1YFvj8=;
        b=b/f0YWB3AP8SiUsiL69idgRsK+e8vi9sdnlNqRUInaMFPdavHpVMjWwTPrlWTHxKCg
         PNV/sbEqCxVS8eDu93/kMBEPdmls8fJy4Nkg0IyyPHL0OmvnqiJ9w5rI5SfYaQJxzQ7+
         Z21QTg6h/vPVjD9Ndl1ezeyEto0Uw2EG+j/vRQx+k92EGZu3r9Z/cAEYUiixsgke65KD
         SfWw460ZKOCzgaxCCC7hHlqwi7kHHFmJUOarEhxi8s3M4Q9aO2qcWE0LXMSSTEa7xPol
         44/8QGN9trCi4yFNc9ckRW3HrFNnv44+SApeOn0HqAWGtPr4w/3216C/U+Q1yutOZCEp
         emhQ==
X-Gm-Message-State: AOAM5332OiflNyBKjJkRll+fc3tEXU/UMPSLf6UE7LVIWerwbQwH1lxC
        +ra7aU3Qu9YXyC41UDQ+v5HzipO5+Ko=
X-Google-Smtp-Source: ABdhPJxd+6/th/057yvcsS26fXVMGOYRmLKwBeP/WHRtVNjcXteOrgShvw42vCiZRH9A3CROb2D22w==
X-Received: by 2002:a05:6402:558:: with SMTP id i24mr12807371edx.190.1613335288737;
        Sun, 14 Feb 2021 12:41:28 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:8c5d:a37a:9f02:aeed])
        by smtp.gmail.com with ESMTPSA id z13sm8876848edc.73.2021.02.14.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 12:41:28 -0800 (PST)
Date:   Sun, 14 Feb 2021 21:41:27 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] usb: typec: tps6598x: Add trace event for status
 register
Message-ID: <20210214204127.ezrlr4u76onqcxl7@mail>
References: <651ac50b9ff6ed3db8cab9f176514900f6a02a0c.1613131413.git.agx@sigxcpu.org>
 <20210213031237.GP219708@shao2-debian>
 <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org>
 <6a8eb07f-16d5-f461-cf0b-6c4aaf93b014@ramsayjones.plus.com>
 <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Feb 14, 2021 at 11:00:48AM -0800, Linus Torvalds wrote:
> On Sun, Feb 14, 2021 at 10:42 AM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> >
> > >
> > > I looked around but didn't find any hints how to fix this. Any pointers
> > > I missed (added the sparse list to cc:)?
> >
> > This is a limitation of sparse; when using the 'stringize' pre-processor
> > operator #, the maximum size of the resulting string is about 8k (if I
> > remember correctly).
> 
> Well, yes and no.
> 
> The C89 standard actually says that a string literal can be at most
> 509 characters to be portable. C99 increased it to 4095 characters.
> 
> Sparse makes the limit higher, and the limit could easily be expanded
> way past 8kB - but the point is that large string literals are
> actually not guaranteed to be valid C.
> 
> So honestly, it really sounds like that TRACE_EVENT() thing is doing
> something it shouldn't be doing.

In itself, it's OKish but it does a lot of macro expansions and most
arguments are macros of macros of ... but the problem seems to be
limited to TP_printk().

In the current case, the offender is the string 'print_fmt_tps6598x_status'
which is just under 26K long especially because it expand
TPS6598X_STATUS_FLAGS_MASK but also because the arguments use FIELD_GET()
and thus __BF_FIELD_CHECK().
> 
> I don't think there's any fundamental limit why sparse does 8kB as a
> limit (just a few random buffers). Making sparse accept larger ones
> should be as simple as just increasing MAX_STRING, but I really don't
> think the kernel should encourage that kind of excessive string sizes.

Like you noted, there are just a few cases in the kernel and IIRC
there is or was one case in it too.
I would tend to increase MAX_STRING to something like 32 or 64K,
in order to keep it reasonable but let sparse to continue its processing,
but add a warning when the string/token is bigger than the current 8K.

-- Luc
