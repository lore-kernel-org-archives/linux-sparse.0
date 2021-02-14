Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5275BC433E6
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 19:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2346364E56
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 19:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBNTIY (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 14 Feb 2021 14:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhBNTIW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Feb 2021 14:08:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F34C061756
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2021 11:07:36 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k22so4626133ljg.3
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2021 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iR6zFaRNY/fhsrzqmwn/JVZVFCvk6DBCPYDYIQyHfo=;
        b=RI+o6311ff6/KY2oB1MDn2aYFIZ37ZO7+ElRP2boyLDgrEezQY2kcJmhjWwQssySKS
         o3jxGgKHe3icceIXdUvRBS4zM10EMA0Sff4F62aHaU4ESBBDXYXw4cash1EmqdeDAWhj
         SSPqJrJI3i2beVLxhS1rUn455sMCpu97c6TWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iR6zFaRNY/fhsrzqmwn/JVZVFCvk6DBCPYDYIQyHfo=;
        b=stqygn86tYun0bEoStV4NclK2uq8su6yqyZCUw1oCFjckfETBKR2qczANApva5ooS/
         vvNG+GasE6ABVpab+a+yoB7MnzHRSni1m/LehJcp9gFPRNlHpp5ugjySq3nuEVsa60yw
         TAzrEpXHIPZgQYO2EZbXzpx74SVQw6ULsmNxSreU7XVgrX/nwHKCYlQyUnbXoynMvDNN
         SvmgsQzhu0ti9KNnjx3K5ljY3LdNj5nrBBI3q2V0R15jsyda6v+XBYfpEYJcSeqyk+xb
         IoLPmhXeuihhzNzovKU1mTI1wDCXQHLPQ53upWywuYzTafqJBpxEJPQn1JRvM08IZqO2
         dlmg==
X-Gm-Message-State: AOAM530x65oGgALVoo1+tLxlL+ouupEo6ThwH2p46dzhv8RDFefVoyZe
        bP6CjuGtbIYp5+fHUsN0P5JhGKrFSGWr3A==
X-Google-Smtp-Source: ABdhPJyKWg264LgONxdKPlsCjvuzaGnVCfSFfIGYqNLDuoApqi44ZTh/GLHIZlN8i6Y5ubLb912C8g==
X-Received: by 2002:a2e:8158:: with SMTP id t24mr6153384ljg.260.1613329654463;
        Sun, 14 Feb 2021 11:07:34 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r25sm42720lfn.213.2021.02.14.11.07.33
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 11:07:33 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id q14so5285530ljp.4
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2021 11:07:33 -0800 (PST)
X-Received: by 2002:a05:651c:112:: with SMTP id a18mr7593997ljb.465.1613329653401;
 Sun, 14 Feb 2021 11:07:33 -0800 (PST)
MIME-Version: 1.0
References: <651ac50b9ff6ed3db8cab9f176514900f6a02a0c.1613131413.git.agx@sigxcpu.org>
 <20210213031237.GP219708@shao2-debian> <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org>
 <6a8eb07f-16d5-f461-cf0b-6c4aaf93b014@ramsayjones.plus.com> <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
In-Reply-To: <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 11:07:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvoGNnqWQiz3js43fiXf9kcAfCbABaHdz98Q+3-3zg6A@mail.gmail.com>
Message-ID: <CAHk-=wjvoGNnqWQiz3js43fiXf9kcAfCbABaHdz98Q+3-3zg6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] usb: typec: tps6598x: Add trace event for status register
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Feb 14, 2021 at 11:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The C89 standard actually says that a string literal can be at most
> 509 characters to be portable. C99 increased it to 4095 characters.
>
> Sparse makes the limit higher, and the limit could easily be expanded
> way past 8kB - but the point is that large string literals are
> actually not guaranteed to be valid C.

Looking around, there's a couple of other similar cases:

  drivers/infiniband/hw/hfi1/./trace_tx.h:727:1: error: too long token expansion
  arch/x86/purgatory/kexec-purgatory.c:1340:9: warning: trying to
concatenate 21400-character string (8191 bytes max)
  drivers/scsi/constants.c:318:9: warning: trying to concatenate
26550-character string (8191 bytes max)
  kernel/trace/trace.c:5290:1: warning: trying to concatenate
10842-character string (8191 bytes max)

but those four are the only ones I see from a quick x86-64 allmodconfig build.

Please try to avoid it.

          Linus
