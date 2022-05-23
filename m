Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A259C433F5
	for <linux-sparse@archiver.kernel.org>; Mon, 23 May 2022 12:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiEWMq2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 23 May 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiEWMqE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 23 May 2022 08:46:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DFDF29
        for <linux-sparse@vger.kernel.org>; Mon, 23 May 2022 05:46:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so21240941wrc.0
        for <linux-sparse@vger.kernel.org>; Mon, 23 May 2022 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mAnl9MNocRmV5guUEEHam6a+6J5XIiAh4dGRzsskR5U=;
        b=igU3pO30h1YT21IurDvbPc85Qs0b3grX9m7rNLeikdNCt36wzyCWGYeKIZ9AedLb3O
         EqMx4C4zXqHD/vGAzibEZUZ3eIU0GkLNYFwDbBzBGLiTYTD/4sRxgST5tgwi/UiwbRHT
         cz0kcRpDq8r38rD1e1iWXgu4df+qD+fakUEXPmk2hgyqdTIvIGo5QFH93bI3Q+hnA6gk
         yRmoUl48t4TPh3TiJWsX+c+veXBp1PhUVEGwt/jPLAvWUgNLxVc/f1bmOBW3zsKGyxqk
         55cs18x5p0lSChxSlaG3kzkCccjBPAZ7RMDLtzNNYtWtONDmWobuW1kvz03pqwg34IJ7
         CYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mAnl9MNocRmV5guUEEHam6a+6J5XIiAh4dGRzsskR5U=;
        b=6CK526/4T4xmHqPt+YFxsJRi1Jcqs7HTIBQPEMNLw0e+rHdlgCtWjQBo1GBlrNTdTd
         nSvjPJ5A0Hvh3tBVIUfVP9cl7Te5dAbrBBKw7QELwGtBzr6IqOhlHnJuFvX1iGFjTyFa
         MezyRMzHb/BTJV8sAFG6nnalgcM8JKf9jOWKacPNiPi4XOxBedlnZTDnRV3U0So3MZoW
         3+uTCY9/8jC7FEAorAkyO/TgXEuALvGtoYH/xkqmIMWdD0mKWD2DJ1ypcTOb8ujFDnxk
         3tJWjWN23kHsX87YYRjd9c9bLVYvOhHGoa87BqadbWKh1jxoh/pOnunOLefR3osqMTbg
         RSLg==
X-Gm-Message-State: AOAM533S8wW8etD1c2I0q0OkXAOf+JEhlMgEXbXqsjsUaygc94RsGW0H
        GRaQTk7ziOELLckKxuomvk7bsGvJBFE=
X-Google-Smtp-Source: ABdhPJyxftevcKNz61tV1PTlhqFGTARb6i7J87WtmK4WzrmzqvRiPRTIGT/P/vxlkR0SBXjugRTNhQ==
X-Received: by 2002:a5d:5281:0:b0:20c:d5be:331c with SMTP id c1-20020a5d5281000000b0020cd5be331cmr18442771wrv.9.1653309960995;
        Mon, 23 May 2022 05:46:00 -0700 (PDT)
Received: from example.org (ip-89-103-223-28.net.upcbroadband.cz. [89.103.223.28])
        by smtp.gmail.com with ESMTPSA id r83-20020a1c4456000000b003973e8a227dsm1025526wma.46.2022.05.23.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:46:00 -0700 (PDT)
Date:   Mon, 23 May 2022 14:45:56 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/3] semind: Index more symbols
Message-ID: <20220523124556.dxhkv62cngd4r522@example.org>
References: <20211102140645.83081-1-gladkov.alexey@gmail.com>
 <20220521094622.ygnkse26visliklk@mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521094622.ygnkse26visliklk@mail>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, May 21, 2022 at 11:46:22AM +0200, Luc Van Oostenryck wrote:
> On Tue, Nov 02, 2021 at 03:06:42PM +0100, Alexey Gladkov wrote:
> > Greetings!
> > 
> > For indexing purposes, macros definitions and typedefs are added to the
> > semind database. Functions that are not used in the code are also indexed.
> 
> Thank you very much, pushed now, an ... apologies for this huge delay.

Looks like I'm the only one using this indexer at work. But in case anyone
is interested, I have a vim plugin for semind [1].

[1] https://github.com/legionus/vim-semind

-- 
Rgrds, legion

