Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA5FC433F5
	for <linux-sparse@archiver.kernel.org>; Sun, 22 May 2022 10:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiEVKHp (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 May 2022 06:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEVKHp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 May 2022 06:07:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8C3E5FB
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 03:07:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i40so15711092eda.7
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yOGPlOEFl5bvJcI65Dm9SeqI2qkNszG/6pRJKiA7gew=;
        b=br8WgvEe/AQf9NzgBBOJmXnWxX3vGoyfvXMFd7Sn/wK8J8unthrE7044tYY0usWuQh
         tkuslcd2XBeOBXhJ+HWCvY16lgGAgSeUbM0PLmejvEDk1wVlqbES7fwyb88fmY9vQFAs
         KcrIpV56+wnr5DB+6qZ2VxkRW4yIUdQpEp0t82bk2EXOpN7TPE3BeINbojgDzDGkammi
         jE7gVirl4/e01/ZYz1aP5T53SzvUzS1c5GMou7yG6lYkRlAACeE6qeC0qxWB88Ts8F7J
         /tNxcWWUMd0c0FIjuLYaBbd9ju18fDsRmnvWFk8YdHi4GGbU/kQOwe1sFMcIQJZE/N66
         gsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yOGPlOEFl5bvJcI65Dm9SeqI2qkNszG/6pRJKiA7gew=;
        b=iQfJ/MkceiZP3mtxuyNj8R3QzryGYm2kLBvx200DgOwbWnZpMiaTYdBe4IRwzkFo51
         QMbxHtZ49DR4da+NehTy9GCRF4WpOlsVXniLBHy9FXXqrbcwu9E48C0QS3d+Wo6ywJJe
         oEuQanX/nF+uglx8Ggvdb78bYb5lSmszKEYvpNwsuq8wwq+WdXZaurTjmvY3jj15hRfv
         JymVfRAYDdffQGTzTXBxI8MRg0nLYXUfh3/8vDm2UFmbqsA9tPs+wpCZj7UB6NMQ9kwQ
         LDlg7t46FF/b3nxSY3CceH1TYJFfP/EhbQdAPet+ynLQBTbX+fNxgxZxAaBDzyBcoM9x
         /qCg==
X-Gm-Message-State: AOAM533AwrSxZ4UsAKb6lFbFMhl8gzeZv5UzHB5o0NhsgzjUAhQZDhm+
        vyrwZ1Kg7UJOFOBui31oizg=
X-Google-Smtp-Source: ABdhPJz2e5n4nvEt3qiXFLJ9v50DYSh79sWIyz0Xsb+bILYBhSIonqNSfMsEfk7ZGD2xr2/Hp+97NA==
X-Received: by 2002:aa7:d707:0:b0:42a:bcb9:b8ac with SMTP id t7-20020aa7d707000000b0042abcb9b8acmr18773911edq.231.1653214061988;
        Sun, 22 May 2022 03:07:41 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id fy28-20020a1709069f1c00b006febc1ef61csm1625348ejc.106.2022.05.22.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 03:07:41 -0700 (PDT)
Date:   Sun, 22 May 2022 12:07:40 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH] cgcc: add Xtensa support
Message-ID: <20220522100740.poyqecyvx4oyu6om@mail>
References: <144ce263-cb62-5531-b35-c8ab13ce68f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <144ce263-cb62-5531-b35-c8ab13ce68f7@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Apr 20, 2022 at 02:31:34PM +0200, Guennadi Liakhovetski wrote:
> Add support for the Xtensa architecture.

Thank you. Pulled and pushed.
-- Luc 

> This should be used with the Zephyr RTOS on Xtensa as implemented in
> https://github.com/zephyrproject-rtos/zephyr/pull/43776

Nice!
-- Luc 
