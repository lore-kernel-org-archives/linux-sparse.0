Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2228C433B4
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Apr 2021 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB2B6008E
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Apr 2021 22:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhDKWFd (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 11 Apr 2021 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhDKWFd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Apr 2021 18:05:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D42C061574
        for <linux-sparse@vger.kernel.org>; Sun, 11 Apr 2021 15:05:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so17084032ejc.4
        for <linux-sparse@vger.kernel.org>; Sun, 11 Apr 2021 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u4si2dSAxfn0m5fRKyNgdlc+qCZhufRCPhIdYAyjldU=;
        b=p5iMg7Xy/5NsmsxGCGBkkhD5RsgCwbAsgoEevTNtYkmp1FFiYPW2AKlgZSlorQyoUM
         o4D1GQJCTga/bEN6jW0V1RInfh14FYyuFp5s6067/ePRK3S4yXR52VXouqFVezDdzfa7
         Xz/hJ+5T1tts1M1+4qyghKYwAJJatd7BOTepw+7rM5r+LaYgsNzVQWsyStBKuOkYLmV2
         ru1lXtLVIO+T9Khdc0CV32hZZUIg2ryIQs/S2mCArsGYOABQL8kDAVQOrwAbVYkUVEFV
         Tb7677BGqShSNapfgweaiJ+tPsTijmQroiiienujyZ7oOpAIpm9gWwyABfKBKdsN1xmC
         dmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4si2dSAxfn0m5fRKyNgdlc+qCZhufRCPhIdYAyjldU=;
        b=tAXd5aqpH5jGR+KxwmDjymjNW3FeTuijt2KwJYxj236iJ+x+rD+xrWP6Rk2f8arbXQ
         j6Tc5p9UM0NmfpOWNyl8Xpj/hTU1fbCwC3pfOkw+CSJpgLuP9OJDJG8VhOzLl8j2V6q7
         XALGCTtYwRipEFXo9TEWfnF0DEZlyhiLKPfwoeOp1WP+3yqmn5o1z/CIOKxhNygrBB1Q
         rXNwo/yq4TdWNgEpKzrq71f7wOfGUdFoxtvvWnD0MI2Et/zfffYu4bxLx5Ofo9AwEMDq
         xldUpGFvwCikOZwDWRY0qOMzo0YWi6ZBARsBvVS7dnofK0e+V2ibqjWJfUyiOmI1VmjN
         MOXQ==
X-Gm-Message-State: AOAM532KrUnWjsukMNPVojrGcUfrPK+fp6qT748sR6HKgWf7IbXtp/29
        X695Lob5EFb6M9Hmh2xod6KFFObm4bk=
X-Google-Smtp-Source: ABdhPJwJa9ghe3MDpogEuAVwwVuHc+Bad5VlxTXlq5kC2lHQ1Lweonu3L6KQfOOSgVktpmxCmtv6BA==
X-Received: by 2002:a17:907:969e:: with SMTP id hd30mr24859447ejc.5.1618178714985;
        Sun, 11 Apr 2021 15:05:14 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:7910:ab4b:7e77:688f])
        by smtp.gmail.com with ESMTPSA id f10sm5184894edd.29.2021.04.11.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 15:05:14 -0700 (PDT)
Date:   Mon, 12 Apr 2021 00:05:13 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/8] builtin: define a symbol_op for a generic op acting
 on integer
Message-ID: <20210411220513.plsj6wwv6o57phfq@mail>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
 <20210410133045.53189-3-luc.vanoostenryck@gmail.com>
 <9bca36d1-b84a-7b6f-37cb-fd5285a86f0f@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bca36d1-b84a-7b6f-37cb-fd5285a86f0f@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Apr 11, 2021 at 09:40:19PM +0100, Ramsay Jones wrote:
> On 10/04/2021 14:30, Luc Van Oostenryck wrote:
> > This can be used to define some generic (polymorphic) builtin
> > with a signature like:
> > 	op(T)
> > 	op(T, T)
> > 	op(T,T, ... T)
> > where T is some integer type.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  builtin.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  builtin.h |  2 ++
> >  2 files changed, 52 insertions(+)
> > 
> > diff --git a/builtin.c b/builtin.c
> > index ff03dbab9a06..f03bf109c818 100644
> > --- a/builtin.c
> > +++ b/builtin.c
> > @@ -390,6 +390,56 @@ static struct symbol_op overflow_p_op = {
> >  };
> >  
> 
> I must apologize in advance, I've got a head cold, I'm tired and
> should probably not be commenting (especially since I am only
> skimming these patches), but ...

Sorry to hear this, and it's me that should apology, really.
This patch was a quick rough draft that I forget to return to it.
It's indeed very broken.

Thank you very much for noticing this.

-- Luc
