Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B7C3E8C5
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A265206F7
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 22:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BFIysL90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbgK0Wpl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbgK0Woy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 17:44:54 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CE9C0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:44:40 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so9061764lfh.2
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mq5iIrwFnQYjeRAxpBAuFhtbGNg6g2yJ8J0FY7TeQxs=;
        b=BFIysL90KVPBjVl8XvtDvqttHUfFt+nqbpm23nM52GPut3/55xKvcfb5VZIsq3ni9L
         Shvr0Eb/R5XKTlbcGN9qQzxkOhq5omfuzzhv56lRp2niAg31jK6Y32gltdhi8ucv8phb
         OMCQFW53pw0L9vgMxjNfchXJV+57G6A55AnDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mq5iIrwFnQYjeRAxpBAuFhtbGNg6g2yJ8J0FY7TeQxs=;
        b=VhZUGbmpPQm8xSVKtDpXsHzKOODz8M2cb5RwaOug/uavr++d0JBadS+7CqD0/Ofccq
         5ALlUDrYEeqMhqrNTj+1J45m3/53fGP9LJCe77DHUcCEOVI5lgaBM5wWG+I3EmwPfCSn
         aI8eUSuEWpK8+M2IBV6TxJ0Noio/mxY9wmKvv29199ljKQINDsIplnnQqAABI4/0bYdM
         3HJsoLcMwr3FO16XiIS/RBc74D6uIL1MC7FjSIw+4+y8GLAJlJZPWnlAdTeRm9Go2TdD
         8zGBwBxl/X37Qn9wbEk4WZwKwt4WCiXwkLqu4Dk5mCW6GUQyI+BIItyNaVn0sGrwymat
         WI2w==
X-Gm-Message-State: AOAM5322v6C/wheyGJHWTPRTbWL8BorrSu514RiB3s4sEv9/n+043mRg
        DgIwxAiQ0voAJLVAMq66tZCkuXcN5cEHng==
X-Google-Smtp-Source: ABdhPJyYfz5omWb27Zg/YzHc7nBo5RmMoOA4qLTbAWD2PIOkBkmGL/3tzKGjLAzFb+4ralyNw8ioIQ==
X-Received: by 2002:a05:6512:24d:: with SMTP id b13mr4832809lfo.544.1606517078900;
        Fri, 27 Nov 2020 14:44:38 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j23sm853492lfh.88.2020.11.27.14.44.38
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 14:44:38 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id i17so7519001ljd.3
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 14:44:38 -0800 (PST)
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr4747353ljj.312.1606517077746;
 Fri, 27 Nov 2020 14:44:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
 <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201127222516.44915-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 14:44:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKe+Op2HnXE=hWh36n_dhaq_AB4_UcetD-nts6YuiCNQ@mail.gmail.com>
Message-ID: <CAHk-=wjKe+Op2HnXE=hWh36n_dhaq_AB4_UcetD-nts6YuiCNQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] 'bits translation' simplification
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Nov 27, 2020 at 2:28 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> With a better if-conversion mechanism it also allows to optimize
>         int translate_bits(int x)
>         {
>                 int y = 0;
>                 if (x & 4)
>                         y |= 16;
>                 if (x & 8)
>                         y |= 32;
>                 return y;
>         }
>
> into this nice:
>         translate_bits:
>                 and.32      %r2 <- %arg1, $12
>                 shl.32      %r5 <- %r2, $2
>                 ret.32      %r5
>
> when applied on top of the previous 'factorization' series.

Heh. Very nice. Thanks,

            Linus
