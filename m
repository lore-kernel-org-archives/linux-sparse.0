Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AFAC433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 09:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbiEUJoZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiEUJoW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 05:44:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F095D649
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 02:44:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f9so19657830ejc.0
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJLYm6B/ts8NZFQY6OcO8A0/vgfZ2swTN8KI+IfZY20=;
        b=pG+BxLvC2PxfKBxxhy8MCw1uZ9X+pyaE2KzNbaKqa0EsKfYx0COQF0HPVo70Pt4ZCq
         DIvsw+K2UIwwuK62A1MB//phVhbagXOxG1ailrrbITTqnVKt4Slwe1wm3o370hlHFXNF
         Fejg7Cr5elzNlhdvPSWn3wOMMj2/UsZxxFU5GeskX7TTf+R2eN3OKYlLlrUxNE33gIPD
         b3NaqDvPF0JAEytTmuM2YbVIhWr4KTM+6mb6yDSryFX7FwfynwcHdTN+Voj/GPRkf6ty
         YPcP2tYXxXJ617laXTm3jm8zNIUnScH6qKo3MkEIAylyMSLMK2BBVGEtZ45foiULAnoP
         jwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJLYm6B/ts8NZFQY6OcO8A0/vgfZ2swTN8KI+IfZY20=;
        b=hJMPNGUXuYTyIfBuR0kiMKAktiFSjRc6d5t2qSmJCpxpkTbU++YRqs3MczzGAh+hLL
         U6UaLyaF2nxmgIHIMBJj9MXF73GV/9PEZsZD/nzS04TDY968xRVQzb7Ff2/IexZFRPMx
         lk6MeXCh+Wjcumojkh9z3pTmBdQegfTxIvsypmE4SHEFGQoCOIsnL7cF+MfisOUmIhqr
         6+/q+m4f7a28cEkN7QXcnFQoVDVfpBjFoYuDqEHYZv0CLTtE5tmP7iY7FBx8FeTdpxlr
         tEKJVUCKn9cBev3fa89vmbl4tNEyMJhxdK/07v73CGmBnf0HUiLLFNJ8vDVIItvTakq7
         7tGQ==
X-Gm-Message-State: AOAM5300bgs15BdNceTS+jZBeksioJEfn+Z0JgPcbw5AMWqvUFyk+l5G
        oNy5GAiF+NIBNXV2Jg+hBZc=
X-Google-Smtp-Source: ABdhPJwar8b0Iwkj9dXNH7m2BZKCQJmo2k7nQ5b9A5/iLyr1O+/nrSo6ob5QIrBhHMxz+YodPb9KPQ==
X-Received: by 2002:a17:907:6d87:b0:6f8:95d2:6814 with SMTP id sb7-20020a1709076d8700b006f895d26814mr12112251ejc.232.1653126259899;
        Sat, 21 May 2022 02:44:19 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906778a00b006f3ef214dfesm4079479ejm.100.2022.05.21.02.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 02:44:19 -0700 (PDT)
Date:   Sat, 21 May 2022 11:44:18 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] sparse v0.6.4 regression
Message-ID: <20220521094418.pf6s4usfq4npktn6@mail>
References: <c29182d4-3141-83c6-21f6-d7f368b3d3c5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29182d4-3141-83c6-21f6-d7f368b3d3c5@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Sep 28, 2021 at 12:41:27AM +0100, Ramsay Jones wrote:
> 
> Hi Luc,

Hi Ramsay,

> I noticed a regression introduced by commit a69f8d70 which, effectively,
> disables the 'memcpy-max-count' check. (I had done a 'make CC=cgcc' in
> git, expecting to see some warnings, including the 'memcpy-max-count'
> check, and it didn't appear ... :( ). Sorry for not noticing before, but
> the 'sparse' make target is supposed to suppress that warning for the
> pack-revindex.c file, so ... ;P
> 
> [I tried finding your last 'kernel sparse warnings change' list email
> to see how many of these warnings still appear in the kernel ... well
> it would be zero with v0.6.4!]

Now I can see 4 of them.
 
> I also included the 'case label' patch I sent before, this time with
> a commit message and a test. (The test could be extended when sparse
> is updated to include the full label-positioning of C23!).

Thank you very much, pushed now, and ...
apologies for this huge delay.

-- Luc 
