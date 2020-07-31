Return-Path: <SRS0=qc3T=BK=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4DC433DF
	for <linux-sparse@archiver.kernel.org>; Fri, 31 Jul 2020 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E1C208E4
	for <linux-sparse@archiver.kernel.org>; Fri, 31 Jul 2020 16:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQwYe1nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgGaQNQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGaQNP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Jul 2020 12:13:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B6FC061574
        for <linux-sparse@vger.kernel.org>; Fri, 31 Jul 2020 09:13:15 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so19503204edv.13
        for <linux-sparse@vger.kernel.org>; Fri, 31 Jul 2020 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTTn6a2cizlFcklhWb4RTtMwtT0SCwfFjWOmaLh/Ys8=;
        b=BQwYe1nPagrOzDg1BVnDa9rtYMBkarWFWMWzQ5TQKwJuhH6j5TiFedAxKdx8Syqq4l
         ADPfmMWleJXA96Q1E0DdXJW1UxBek0+hx6e4ksC62GpwS0FUAqXUEuVSfXOJN317CrOt
         ZBcNMhVr3aVEniz7oouh3hTmzvhVN6kRA7iGaFCsQfBJ2bh6qJ81/PTZ9q0/Vfpi6/FS
         r3f2nPehtcUQPnIit4dMkP/Q/ZeRops/XS4Sw2/1JjQBk/rdX/tTkI6kFynXvpuWQn5M
         VjQOQU+/lx2LD03BYCbQLhAl6/YuMbwu5JPBjtasf4zQwU+7GWsIlwl9oe7JLrK30LnS
         Iwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XTTn6a2cizlFcklhWb4RTtMwtT0SCwfFjWOmaLh/Ys8=;
        b=HNeV6fQJrM4ecIVVqnGrf40Ecq+iuCbSW8tRiZV4tRjNmCPG2YKz5JdZpyUmtcksTe
         dqfuEJO+MyyVK7wrDIxMM4GXHVrnBXx/0rMEStdenhYue1A5/Ny7N3S857cKJDmx+PZM
         QBbQntiKfvW4OowTXQhqS0aHohS1wwETBIQ55iNFqfiFGbqfc9NhqEjL79zU5W/vdjdM
         Oe0INE3mh9NvZStWdziV0NtI3l+dRNrv2vGJ7RqwoODbskHAqDAAscsQ7i6ZCqchdYh6
         aqvmfkyJhjtuqzpPo4qQetMrGSFnNaDWItNUBM+xN2D7/irll0VJyElnRh/VsWDDvtHB
         lgww==
X-Gm-Message-State: AOAM5303pcGLA97QIpYQx8OU/1SkjK/NlQLHGdQ7y5UTcUFcXqxhZ5na
        aAu0hBCdSMBeP2Hk2TwbriI=
X-Google-Smtp-Source: ABdhPJx17QG0b5EPZUp7453kUrerjitdSKEJ6bl+I6OmKc57Pk3iy+4/2k4g3ufYYABrlajKDNWKBA==
X-Received: by 2002:a05:6402:1d97:: with SMTP id dk23mr4679438edb.1.1596211994151;
        Fri, 31 Jul 2020 09:13:14 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:6dbc:8aa:bf3f:3031])
        by smtp.gmail.com with ESMTPSA id h10sm9717213eds.0.2020.07.31.09.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:13:13 -0700 (PDT)
Date:   Fri, 31 Jul 2020 18:13:11 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200731161311.467luzxa42lmxtac@ltop.local>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
 <20200728231058.3yakpfw3dqslxq5t@ltop.local>
 <20200729112801.GA4360@redhat.com>
 <20200729145025.g26jqfpqcnhd5wed@ltop.local>
 <20200730150837.GA6956@redhat.com>
 <20200730200046.qsbaw4iabb4idjly@ltop.local>
 <20200731144300.GB13775@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731144300.GB13775@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jul 31, 2020 at 04:43:01PM +0200, Oleg Nesterov wrote:
> On 07/30, Luc Van Oostenryck wrote:
> >
> > On Thu, Jul 30, 2020 at 05:08:37PM +0200, Oleg Nesterov wrote:
> > > But I do not know how to improve it without serious complications, and
> >
> > Are you thinking about calling evaluate_symbol_list()
> 
> I meant, it is not simple to teach dissect() to handle this case correctly.
> It understand the types, but for example it doesn't even try to distinguish
> "int" and "float".

OK, that's fine. It's just like using a super type like 'scalar'
or 'basetype' or something.

> And I would like to avoid evaluate_expression/etc.
> 
> > or about
> > something else?
> 
> And something else. See the example above, this code is incomplete and in this
> case evaluate can't help. Ideally dissect should also report the (possible) usage
> of B.mem and C.mem.

OK, I begin to understand. You want your own type evaluation with
its own rules. evaluate_expression() and friends would indeed not help.

But I'm afraid that, once _Generic() will be used more extensively
in macros, it will create a lot of these 'possible usages' that would,
in fact, be irrelevant to the code analyzed, possibly with an explosion
of combinations.

> > > (so far) I think it doesn't worth the effort.
> >
> > Yes, _Generic() clearly makes things a bit more complicated here.
> > Same for __auto_type,
> 
> Yes, but hopefully dissect needs much more simple changes to handle __auto_type.

Yes, it should.

Thanks for the reply.

--Luc
