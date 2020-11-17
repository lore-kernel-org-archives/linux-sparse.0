Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D97C388F9
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 00:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F88A24682
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 00:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isbVbhDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgKQAm2 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKQAm2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 19:42:28 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E97C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 16:42:27 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id i19so27009134ejx.9
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 16:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QWkieetnDoRK7gbO9k4OQUeIRksyzYZmDfcBPEnc82Q=;
        b=isbVbhDbL6ZkysNGCFoBd6Jd9iWHf7ekhVjw+ckE9ZxHMFL09XAZhcFSoGehBaYrvC
         pwNhk+whIJjeJAcAnIEFeipZNiTb7ak9AVj4+2JByjQtbcWNh8UZmvKPxwf2ul/8qt1m
         fgrCxIz0M2/6XfS7itOAgifPEFA6D+5pxrTxkJKuJbZYnmzPkqiQLvTRYAMkYfdX83Sb
         BVE57pmggWu32XYG+r7keJ2ByenB5O8J+/GbzXiZ8/h9Bx0gHLaYyomIdu9Gnyi5liTi
         WI3noiM4OkCM9m7qAr8AMLchcfKn6YICH3E9pVtJ4HywWm7L6rl9/Txn/q2KMOK4YbWL
         yVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWkieetnDoRK7gbO9k4OQUeIRksyzYZmDfcBPEnc82Q=;
        b=Zs2jQm4nLkkR0NTD+JRz0U2d4R5v63RkmYHDqsKt9GIHFgPVF5i/BJXZUw8aQm9CzO
         mp/+ej//+o2AQOYZzgbNcwBQTDbVzyfzC2TyaWBIK93gtLaAS7nze1YdCI/LsZ7O0Pji
         LJ3MCeJHQRthAtuqGKY6MCN3258cRyFdB8q1QN90YOuYUp06CUqJtGzsHsoW08MGC5Qk
         miJqmRFXPdkGmTdU1XkrVj7Ypsk9Dnwul24lcN7C/OWodnwP09Rr7ZVUUr1b8r3Hu/BC
         e4p6an3h7FN1wePt2ygasXS/BhZn1nN9lKh+YEe7Y9T2AoEkupkXJiSCy8Gd1zZUMwaS
         8kSw==
X-Gm-Message-State: AOAM531BJo/iF+NUTqK6HYlBrqSGjQzutCzGWQ8HqrzZFa4fDjPFREm1
        gh9XhkPoOy+QtnYSpvXwX37UCHXwREs=
X-Google-Smtp-Source: ABdhPJxhR2XQuzNPOUXXgpLrsnU0bnbbFt8t/LUZMDStfswJXf1E0633U90FCj6QleZzqh+6ftg+Cw==
X-Received: by 2002:a17:906:a444:: with SMTP id cb4mr17724611ejb.416.1605573745795;
        Mon, 16 Nov 2020 16:42:25 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id g7sm11589841edl.5.2020.11.16.16.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 16:42:25 -0800 (PST)
Date:   Tue, 17 Nov 2020 01:42:24 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 4/8] cfg: adjust phi-sources when merging BBs
Message-ID: <20201117004224.n44c3zwdiqogteyc@ltop.local>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
 <20201116222927.51939-5-luc.vanoostenryck@gmail.com>
 <CAHk-=wiSQ-=SRspfVWdE17ORGJtjJzPCvCOo7ETwM9jeUG6uvg@mail.gmail.com>
 <20201116234712.7nk5ktce4ntcumbs@ltop.local>
 <CAHk-=whOLb3-HR=imWNtKk4n2FwZTuZSgYDB2sH=307mqQN+SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whOLb3-HR=imWNtKk4n2FwZTuZSgYDB2sH=307mqQN+SQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Nov 16, 2020 at 04:16:01PM -0800, Linus Torvalds wrote:
> 
> Could the phi_users list be just replaced by the target (OP_PHI)
> pseudo (or instruction)?

Yes, trivially if set liveness is calculated. But this
information could be useful earlier, then it would need some
work to track it (not sure it would be worth, though).

-- Luc
