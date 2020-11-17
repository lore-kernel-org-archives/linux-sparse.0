Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9733DC388F9
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 00:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F09F24654
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 00:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NnB5dEvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKQAQX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKQAQW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 19:16:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E7C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 16:16:20 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id x9so22246160ljc.7
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akwxBPpXZQuUIxvn9F4Lr2r7OHDFDzTuPM6MJQGziCg=;
        b=NnB5dEvd0S1wGFhnBkQjgRKTGajP7dbRv0F+XLIWy7CfBBOxj1u2A9MOmPzK7pgDZ0
         v6WPLQ+jBiv26LE3intgH54QeFlRN3+Dv80Wumib0UYG3Qy/f7jlhWXXYOMVlQdk4fcG
         SKsegHBYu5tiMouQVflEJfLePz4G9rdOa1sGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akwxBPpXZQuUIxvn9F4Lr2r7OHDFDzTuPM6MJQGziCg=;
        b=qxzoA7d5bZO3r081XpFZ+YjI6LtqPda46ujaLCTJAooRPeZEnzMkYW0mwe7A0+D01n
         QHjl3GjFW0rwwByFiEP3tBc3taroNOBUuqYfnVPHg08tp2rO2kx8H9aj4oyZZuM7SXFx
         FFeJUcBQp970wWBKqc+UsxsaprAKYtfr5s0t6RWSRGHYN2RPK4BfwBBTMpWV6xDSz+/w
         qXf1R/phEycl2gFWecqUzxwAQ+BiudpDMpGKL1vsAUkMQzayFwvetLue5jv6GfquLvjR
         +OfdI+ZFI+ZJG4z9goJ4/9jQkdTgnKuX65GXe9h50VjpgE/Gq08sAksyc89YWAxOH9XZ
         dJkQ==
X-Gm-Message-State: AOAM532pyqVbzfCxBYwMGRjB93/8aTwo0m4BnFz1CcsBK/SLQ26jbMSJ
        eONIOCRQApkOYJGAKGBiWXObh2f7YJp3bQ==
X-Google-Smtp-Source: ABdhPJzYcGZcoNK3DYKBRXO/W3CzXeOifTwRfZmICEyxRo/keqVYvnMLg8dbsqN1wvCcqOASChXXkg==
X-Received: by 2002:a05:651c:210e:: with SMTP id a14mr759838ljq.128.1605572179077;
        Mon, 16 Nov 2020 16:16:19 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id d28sm368451lfm.201.2020.11.16.16.16.17
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 16:16:18 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id o24so22228547ljj.6
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 16:16:17 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr679537ljo.371.1605572177641;
 Mon, 16 Nov 2020 16:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
 <20201116222927.51939-5-luc.vanoostenryck@gmail.com> <CAHk-=wiSQ-=SRspfVWdE17ORGJtjJzPCvCOo7ETwM9jeUG6uvg@mail.gmail.com>
 <20201116234712.7nk5ktce4ntcumbs@ltop.local>
In-Reply-To: <20201116234712.7nk5ktce4ntcumbs@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 16:16:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOLb3-HR=imWNtKk4n2FwZTuZSgYDB2sH=307mqQN+SQ@mail.gmail.com>
Message-ID: <CAHk-=whOLb3-HR=imWNtKk4n2FwZTuZSgYDB2sH=307mqQN+SQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] cfg: adjust phi-sources when merging BBs
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Nov 16, 2020 at 3:47 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> This code is a bit weird though, because it actively use the fact
> that each phi-sources feeds a single phi-node while the underlying
> data structures are designed so that phi-sources can be shared
> between phi-nodes (but I think that allowing them the be effectively
> shared would bring too much problems).

Yeah, the phisource nodes are strange

 I was confused when I wrote the original phi code, and you fixed it
all up (to the point where I suspect none of my original confusion
exists ;^), but they are still a bit strange.

Could the phi_users list be just replaced by the target (OP_PHI)
pseudo (or instruction)?

           Linus

          Linus
