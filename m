Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DDC433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 22 May 2022 12:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbiEVMWj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 May 2022 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbiEVMWi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 May 2022 08:22:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D63BFAE
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 05:22:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p26so15925880eds.5
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LG8EYp1+onYXfFssPBwlYdjbgVsgQherIbV0lUMWZRU=;
        b=OiDaf0aMEGjQBHhExJo2zPDd25tfS7Vq7QG43OoO7i6PmLeDXUJXVX8lSvzzADwBmE
         pOeBZo3mOMjBsIjBSKWzXIu3QOQUHbkgPkMURCxxixfIaKj3C4x4Vtzj9w7n8sQsYJJA
         PBVltCk64kJ+kBXNGhO/to6U57AMUisqcHNo01HqA+6g1k4oYT6BORKVjhIqK+rd29Zg
         sgB1brkgVUjoN/ZKtHirrcI77tvEnlX15nr25p18YAWzZ9BAtFdk7a7Umj48Z/2noE8t
         05YQUbF/croL/iH8BDhEIs3ak/FNDXfZWjAPTB86DHsLNYIvmdjo/NVexzKJ3yr31Nh/
         lruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LG8EYp1+onYXfFssPBwlYdjbgVsgQherIbV0lUMWZRU=;
        b=CDhP21GWDhPo9uyHcEFtKHA5ZfZUQFH2wyRy81ZW+5+uzStk0iLzsi/y/UPo0+6gkt
         l3ATrvhVhh5CXC9RsBMIX0z1SlDedlAcrwWd/zsTTqVNuv7H5rEfYKEftRQ8XHNtSlO8
         lisCrq50cUipmncNuWBJ7qiwChUm/tp9xKjAqSuFYTNknxC9GFXh6OXGnFx8iUCDJ45o
         wdPIihgAUmQv4ooH/s7hPuPkn3FpzdoYmt4aEvGBhP961zFzmA/VBrL+R13Uf+rF2Rfp
         qIPkrTNbsLpP4wXeWcEaiJxBf0fH9XILjtYMwfHzsZHyiUd1epB31CJKI/pbxEwEy8bI
         t2fA==
X-Gm-Message-State: AOAM530FXYQDnp1tnPjYZY4BWfN6aT69z/Wj8kdNU+mGFZwJiaBRkQ21
        F/6ny+EVTMnQes0bzlnt7jU=
X-Google-Smtp-Source: ABdhPJxXXghxr1/WVYv2CZl/gdaRY6GsXi72CsD+lhzmNuak7+LmRz7VjyOtwSyThG8KvIqvhQrZNA==
X-Received: by 2002:aa7:d4c8:0:b0:42a:a406:a702 with SMTP id t8-20020aa7d4c8000000b0042aa406a702mr19250936edr.129.1653222149306;
        Sun, 22 May 2022 05:22:29 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090695ce00b006febd5a0f5bsm1621285ejy.59.2022.05.22.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 05:22:28 -0700 (PDT)
Date:   Sun, 22 May 2022 14:22:27 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     linux-sparse@vger.kernel.org, pvorel@suze.cz, chrubis@suse.cz,
        io@richiejp.com
Subject: Re: Linux Test Project vendored Sparse
Message-ID: <20220522122227.mcgnatle6zmgqycn@mail>
References: <87k0ggbjb0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ggbjb0.fsf@suse.de>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Dec 07, 2021 at 01:33:56PM +0000, Richard Palethorpe wrote:
> Hello Sparse contributors,

Hi,

Please accept my apologies for replying so lately.
 
> After trying a number of static analysis tools we settled on Sparse to
> roll our own C checks.

Nice!

> We use a mixture of the linearized form and AST. If you are interested
> please see:
> https://github.com/linux-test-project/ltp/blob/master/tools/sparse/
> Also I will attach the main code to the body of this e-mail it is only
> 283 lines.
> 
> I still don't have a firm grasp on how Sparse works, so any feedback
> would be welcome. BTW we include Sparse as a git module and so far there
> have been no complaints.

I've taken a good look at it and everything look good.
I also think that using Sparse as a git module is the good choice.

If you have any question, do not hesitate to ask (I should be much
more responsive now).
 
Best regards,
-- Luc
