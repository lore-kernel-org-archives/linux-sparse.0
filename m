Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C0C63777
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 23:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2964024641
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 23:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb8T36Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgKPXrQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKPXrP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 18:47:15 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774D2C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 15:47:15 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id za3so26898624ejb.5
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 15:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KyLht7HxFEsIkS7JR6c50TtbTvt38CjYOrlTG/juufY=;
        b=kb8T36NaLSDH3jukS7i7mZhJhnXpSshiUnS7Un6JLxpozRFktHGxLeb1pppkEzY1qF
         m2CiTUssFmr1l5B4PugtHjYJTyQLv3aEeOn3Q4FjSFmsowGrO1MVzY1cSLoGRkFAx8xf
         xvCQMN3cOeDO2c622y0qZpZVoTmgcLr3yoNYfRoIf4wo0azGEmMYvUeCnEffdWTsBqyL
         +3ftZApTCk3ycgK9k1bZ/W/GPAAlV+H7rxhLDZn3QEyebrpcDiaFfKICuv+d+U3aSpvK
         NedSzhrQMGPKzS6KvwFuIUUIyGNKoZx9+C0rHh9LKfU3OLf20TQvJ/wIzWTIawAwkAGa
         Y5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KyLht7HxFEsIkS7JR6c50TtbTvt38CjYOrlTG/juufY=;
        b=mi0r4djuhyqoyYBRq4sLXAz3nmpcYUTjrgnIbv8Jbq2CjUgfkXdO7p7DJpjOspb3+m
         L8XB1UIbVFc7NJm5QwBMeeB2HlHWSrLOLmhAc6Ai9gJt86HATOKsQAJuEhrziw2SjVP7
         VhdiPlTgRliebLO9blHe0Bvgt7LhV1671OdpRB5AI5FOyD1Qmw/deeA9l8m0WZREhW22
         +B7cx3vKAjrLJtRqQZTGH8wpt93xt/z+U0G57N47dSv25hzvX0OkPGGuTsb0zsArEOdw
         p6lfhl7v7YvB4MQUQkv4Xsqh9Qa6EpfjSXjbcv2CxH8WhgxkERd/+4IAhoLWewSjZAM+
         9RHA==
X-Gm-Message-State: AOAM530EQQjkVAOpvAxNg+q85zs53KLbfeV+1F+BiGZFmNwnpuUqO/uy
        aD4OwMVFV05hJLm6hBNfUQdlMwCxdJ4=
X-Google-Smtp-Source: ABdhPJxYMm8ymCud/8ww85nNGPfAQTt8roBKzO/fk4kXFa6FFUCFmZw164BaU6a9Muhbje+1OqZl7A==
X-Received: by 2002:a17:906:9458:: with SMTP id z24mr17645262ejx.318.1605570434142;
        Mon, 16 Nov 2020 15:47:14 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id c8sm11424739edr.29.2020.11.16.15.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:47:13 -0800 (PST)
Date:   Tue, 17 Nov 2020 00:47:12 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 4/8] cfg: adjust phi-sources when merging BBs
Message-ID: <20201116234712.7nk5ktce4ntcumbs@ltop.local>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
 <20201116222927.51939-5-luc.vanoostenryck@gmail.com>
 <CAHk-=wiSQ-=SRspfVWdE17ORGJtjJzPCvCOo7ETwM9jeUG6uvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSQ-=SRspfVWdE17ORGJtjJzPCvCOo7ETwM9jeUG6uvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Nov 16, 2020 at 02:53:21PM -0800, Linus Torvalds wrote:
> On Mon, Nov 16, 2020 at 2:30 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > +static void adjust_phisrc(struct basic_block *top, struct instruction *insn)
> 
> My only issue is that this is a really odd name, and calling convention.
> 
> "adjust"?
> 
> Wouldn't it be more sensible to call this "remove_phisrc()", because
> that's what it does. It removes the matching phisrc instruction in the
> specified basic block.

Yes, the name is horrible and doesn't mean much. I'll change it.
 
> (I also think it might be a bit more obvious to do the get_phinode()
> in the caller, and simply pass in the OP_PHI instruction, but maybe
> you had reasons to do it that way).

In fact, I wrote it first like that but then I've another piece
of code that need exactly the same info so I change it into
a separate function.

This code is a bit weird though, because it actively use the fact
that each phi-sources feeds a single phi-node while the underlying
data structures are designed so that phi-sources can be shared
between phi-nodes (but I think that allowing them the be effectively
shared would bring too much problems).

-- Luc
