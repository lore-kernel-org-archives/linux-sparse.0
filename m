Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC8C433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8AEF6120F
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDQQlA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Apr 2021 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhDQQjT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Apr 2021 12:39:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F398C061574
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 09:38:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so46553647ejj.3
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13usxRuXLuRBWCplxpwESBeo3ii7hlgCEHc12avH+C0=;
        b=aeYj+35o6I7DYVVJhFhpMoAVw4uBVnWljlJDmHNUUjqRJFxzLPbvSvca8/+ix1sQzl
         11nxAeZQb0dvi14mhLq4JFnkiBSnaL5lilD5v2YW3lUHQv1YLz+uLU1Wd2d8yU80EMBV
         N1hxBMRIF1etC/2y/ScJcwe/QQWH89j3e67Q+q6A2Q++41vnrk1ZpVcG9uDL6//E5Im5
         FqBzFpkPhCx/VR0J3FeXcBGJzOSv5mMjhPD67ref7vpvC3RowLpwBuQKnqShNkeZRhLr
         Goju4CaSRC169eg5FFvMKnhcdpMmRXztz+ctbdASQzVRpMT2CBOUdKxegLZihjNk+1yx
         FvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13usxRuXLuRBWCplxpwESBeo3ii7hlgCEHc12avH+C0=;
        b=Fdde9MLgQO3TqStEkXgBzJVvS425y7Ii6EPM18WI7yElQT+m+d0JGgyQjOjtfYe0DS
         Rlru28TPKd5LUXU213WFcsmfnv4gySdqK08JLvnOqRf0y8KwiDCBTchoPJjGNYqqGXvP
         pB7G3Ztk1OP+sZvrdn+u4icG1hJha2kRFM27gohnwStJbk1Pj7QtMOaR32IVFkwkbDmj
         T6e22hw6ApTuuCngROFzH62ziLjaDi3IIq0nexOAtQkXJH/ttSaRHcV9wX4ElT5FS2og
         bF3KgiBOLkFcyAvAg7tCaIAshzBJ5Jv41ER3EUMDWExZtOY/zV1bqEbwqiu0V+TJdG93
         NEAQ==
X-Gm-Message-State: AOAM532vlwEDH47rdiBjrxWLx3ZQJ8fNQ63D5jlAiWuVClPUAaSRvluK
        /wPEH677slNlScx6/osGnfJ2meJQe18=
X-Google-Smtp-Source: ABdhPJyUNULjrfGOyDdakRbg+6G3At6/cH4i4W8t5RlIYAC7bgC178pUjk1IKD0svu3dWEU+mnlFng==
X-Received: by 2002:a17:906:5d13:: with SMTP id g19mr13621208ejt.206.1618677531882;
        Sat, 17 Apr 2021 09:38:51 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:8120:1c81:5e73:b5c1])
        by smtp.gmail.com with ESMTPSA id t15sm7967470edr.55.2021.04.17.09.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 09:38:51 -0700 (PDT)
Date:   Sat, 17 Apr 2021 18:38:50 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH] no needs to use MARK_CURRENT_DELETED() for multi-jumps
Message-ID: <20210417163850.wqkrde74s33gfghv@mail>
References: <20210417133154.53987-1-luc.vanoostenryck@gmail.com>
 <YHsKV2s9XW4w8tK9@satellite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHsKV2s9XW4w8tK9@satellite>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Apr 17, 2021 at 05:18:31PM +0100, Ramsay Jones wrote:
> On Sat, Apr 17, 2021 at 03:31:54PM +0200, Luc Van Oostenryck wrote:
> > MARK_CURRENT_DELETED() was added for the case(s) where an element
> > must be removed from the list but the address of the other elements
> > must not be changed. In this case of effectively removing the
> > element from it list, the element is 'marked' as deleted in the list
> > and the list walking macros will later take this in account.
> > 
> > However, this is not never needed for multi-jumps.
> 
> s/not never/not ever/ ?

Hehe :) Thanks.
Just 's/not never/never/'

-- Luc
