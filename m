Return-Path: <SRS0=GPIt=BV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787AC433E1
	for <linux-sparse@archiver.kernel.org>; Tue, 11 Aug 2020 04:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76E620756
	for <linux-sparse@archiver.kernel.org>; Tue, 11 Aug 2020 04:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orgSvBY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgHKEpE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgHKEpE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Aug 2020 00:45:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8647C06174A
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 21:45:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qc22so11652500ejb.4
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uKRKlxryNmf4EgqmbF99DbrVgcsglb7xIFGWg2osx7A=;
        b=orgSvBY8nq/ijy7d8u7bRmfnqLnq0R5LsQW3NjwnoJmUrjHD/sYDIGXLuiHRV8UQ/9
         RcgY2/QYdatSkGbycwunf3vET7tybbjAV9DybQrkyRhvoCqJXeJLLq3e8UFqT91UIjRN
         b+2oPM5QILIS1K43LWfGVndi4Se6D3U0tfeRV+h9NUntv9SueGdIZgvS2e4hzAL83bS4
         V5EtnaUPfYU6ekPZKCOy+s4pyoSwxpChc5JrI1SSiL7SJlupyXux4wT4EJbME9UMZjsq
         2scE22sRSfxiCfuVTGWohgmf8y5Z0byZXRifhfiEWux4/5epU8z2HpE5wIZrCZaghpUL
         ZU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uKRKlxryNmf4EgqmbF99DbrVgcsglb7xIFGWg2osx7A=;
        b=URZOQsGN3ggaLhq/gcKXCpn/okS341nTTnwafw82Z+Sc2EHAFTThIf0cQocIojtaWn
         jYgY641aPeWI5fCh+hf4HVA+a86V2FQf5aFr5QDq7exfnnfmh2rStwaEb+R8lRYwKWgD
         /EFHew3LOxFipofpD5kpq/j2dOidsSEYOoPjN9r5q92GUtF8J3Fk3D+7TU0oTNxu2LRs
         6Kez30qdolbOoSxofw7RaRkrONyPj2HlfVQK5NmFsjqRnLLTgZhUjGemx9eNdC9P53Y5
         4Kh85zOzUE9SBYn491i0dW4H8cK23OxFNnuVZPzCGodpXncAk8mEg4nDtZI/Ll5RfHGt
         FXUw==
X-Gm-Message-State: AOAM531qn8i2mr4K/S9p3xn3CxHJ6c8emtccZs4aCdrkgyOnhc3D9WjC
        46ea+ZuJW2zku+L8H6D0C2ELiVE1
X-Google-Smtp-Source: ABdhPJymF0gz9yXFFx9R1vZlWZyCa8iLPjQRbg+teRG7u4K4DxxxhmMQCu3mh3WmvtUSTJJjyQuQQA==
X-Received: by 2002:a17:906:64d7:: with SMTP id p23mr24255558ejn.185.1597121102443;
        Mon, 10 Aug 2020 21:45:02 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:200a:e537:5e99:259d])
        by smtp.gmail.com with ESMTPSA id g11sm11527063edt.88.2020.08.10.21.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 21:45:01 -0700 (PDT)
Date:   Tue, 11 Aug 2020 06:45:00 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] bug-assign-op0.c: fix test on 32-bit builds
Message-ID: <20200811044500.5d2il2ygw4mwrrma@ltop.local>
References: <69f6f834-b350-5553-8227-1c7b4c6532c2@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f6f834-b350-5553-8227-1c7b4c6532c2@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Aug 11, 2020 at 04:15:23AM +0100, Ramsay Jones wrote:
> 
Hi Ramsay,
> 
> Tonight my 32-bit build/test run on 32-bit Linux failed this test.

Yeah :( When writing I thought "I must make them 64bit ones" but ...

> The first version of this patch was a simple one-liner to add an
> '-m64' argument to the test-linearize 'check-command'. This seems
> to be the usual fix for this, but I thought I would try something
> different. ;-)
> 
> If you prefer the one-liner, then go with that (I tested it on 32-bit
> Linux, but not on 64-bit Linux - I can't imagine that it would fail!).

No no, it's fine so when 64-bit vars are needed. Usnig -m64 is only
OK when 'long' is needed and that these long need

Many thanks for reporting and fixing this.
-- Luc
