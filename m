Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447BC433EF
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiEUN2H (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiEUN2E (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 09:28:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5077869284
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 06:28:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg11so13695526edb.11
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LHdEu4ZU995J7e7P8vZlHXvL8OmJCeK71/sGJQrVuPo=;
        b=YGzXm2ja70dmMogsNVgf04DjY5GuwS27UFL6sthf/CfjXsgLzziwSmyQBz1W8hep8q
         WMTHTsuRC9virxBC2cGqTX1MGkGSOJgVoVpxFJ9pfs2WaHJt9o75HxMoTYnke0DGVCz1
         oG3gwJGAr0e4cgWeQRV5rkiv4lyltN+cIbznvA7ZtXC3XAxLvMLiM3ybexoFm4mePr5G
         052MfnWJCDnTPq9ucEaWx5LuX2X5Ao8P/C7rr3dEhqYCBsCjgZYHyu/jwFFzouXvP2F2
         zI9sDy2vliTTyOIrVTLFZF7pk26kedney1JjSe49gVn1Snpu2p2ikdKsVZhPrNHgRpiG
         5QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHdEu4ZU995J7e7P8vZlHXvL8OmJCeK71/sGJQrVuPo=;
        b=izDxuxN3gMIOXW7Jmd53jGzupdqs6WgHMxphLEb675v3px653IkNDxqeq4oYtPCopL
         nmZxoxtT9ubP2JEVzbSHfp10nALNPtw9VTLsBUlz2E5JE9puFU7OyD74SZfxBTVENANy
         0IDSSwwlq1l91GjmqcXgiDzzfI+FgshtXgl89gAHiYekl+ImTHJ+CKSWSoKTKf5dQlZH
         RsOHifudrnBwkZ2oHqVM3He/ctpkCkLmkWHJbA7ybbTv3d3d0jeAObjT09Deivo/2LFt
         mdyZQPhd/ftU1y2ueenxIqDF4hATsvG3aKAcd2hXzFTg3+s39LMzNClkhNf12GBse3Ge
         wuFA==
X-Gm-Message-State: AOAM531vwB/osp80DEeCNqPAfEaRs/Db+r6hekHkKs4jK2Yt0bf9S4NW
        o8nlvzUcEIHXEta49z3wH7fcm5Ns/6k=
X-Google-Smtp-Source: ABdhPJy3Yeg5Vy95815YTkSc6+BwO2tHNUyCBmBoUx7DISsQoCkJs2+QWRaPfyNDq7v+lFCaUuHOqA==
X-Received: by 2002:a05:6402:10cc:b0:428:90ee:2572 with SMTP id p12-20020a05640210cc00b0042890ee2572mr15723314edu.103.1653139681753;
        Sat, 21 May 2022 06:28:01 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id qz24-20020a170907681800b006fea43db5c1sm2039709ejc.21.2022.05.21.06.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:28:01 -0700 (PDT)
Date:   Sat, 21 May 2022 15:28:00 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     linux-sparse@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH] sparse: Use offsetof macro to silence null ptr
 subtraction warning
Message-ID: <20220521132800.52xlazjqktxz27b5@mail>
References: <20220321112119.23308-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321112119.23308-1-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Mar 21, 2022 at 11:21:19AM +0000, Richard Palethorpe wrote:
> Subtracting (char *)0 is undefined behavior. Newer compilers warn
> about this unless it is done in system headers.

Thanks you, pushed now.

-- Luc 
