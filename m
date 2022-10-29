Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FF3FA3743
	for <linux-sparse@archiver.kernel.org>; Sat, 29 Oct 2022 07:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJ2HcS (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 29 Oct 2022 03:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ2HcR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Oct 2022 03:32:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB004CA02
        for <linux-sparse@vger.kernel.org>; Sat, 29 Oct 2022 00:32:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h185so6653625pgc.10
        for <linux-sparse@vger.kernel.org>; Sat, 29 Oct 2022 00:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZy5lCa/2Ecq1kSp+TM41cU7cXmzgRAAem3qyDrtqVE=;
        b=A6ozaRuL05mZkdsRzdSlURHF6+RyhhlQMHJ17oRbpBtm3eHluiPPTe/pjG6GCA10vk
         tspsEtfuGzEps6YAzOIbVmjuDaXvqm1pWzEH1nBnDI3wqRh0OvIqYp2m7/OwTKipwoyl
         NAZ2yriUdMjhNWS1Wx7WX9sK0FE0Y59FOGeLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZy5lCa/2Ecq1kSp+TM41cU7cXmzgRAAem3qyDrtqVE=;
        b=K3DS+PNCHZ4nlNSiulf9dqwmzhu2d931EbxY5Fwn8EzR8ieSG74M0jlCqUU/OHPRMl
         y8P44Ezk59GJPVynVKOV5U0sp19ajt9Uc/NdO0kHD1imQHkLscj5HfcSOkHx7PylErW0
         S7BDCikGgUZMym5tXttRU6eg7kQNX2Hb4Pfz7PKb/XCM3/GGjD3iDB9Zlja3Q3nqT5yK
         aH1YtV14nmIc6EA3jEztvzjgU9BFVx6C4m13FQ6goX5GFamyWpgSUNQjMyJTcsTU6lEL
         eyqg8t32WOMqSZjYVmcl/lajNlkMWVgB5UWscnwD3jccFulAsdS6a45OCLrZzTrU7+Lj
         PtPQ==
X-Gm-Message-State: ACrzQf0vDXlcbPSyU7foxd52RxQ3SRdEDBrXfEkhwK8GQPEAs9QwHnBa
        5VqlFh+/YE4mCo5bTqFAgdem4Q==
X-Google-Smtp-Source: AMsMyM6/CT3Vh+btOf4K3+q/dntWfviHzwWozBtDItq+XamMQLfaCbtowXk6VHNabYjKDdbmPNU6XA==
X-Received: by 2002:a05:6a02:10a:b0:461:26b8:1c95 with SMTP id bg10-20020a056a02010a00b0046126b81c95mr2895261pgb.503.1667028736033;
        Sat, 29 Oct 2022 00:32:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b001868ba9a867sm607345pll.303.2022.10.29.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:32:15 -0700 (PDT)
Date:   Sat, 29 Oct 2022 00:32:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     airlied@linux.ie, trix@redhat.com, dlatypov@google.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        llvm@lists.linux.dev, arnd@kernel.org,
        intel-gfx@lists.freedesktop.org, nathan@kernel.org,
        rodrigo.vivi@intel.com, mchehab@kernel.org,
        tvrtko.ursulin@linux.intel.com, mauro.chehab@linux.intel.com,
        ndesaulniers@google.com, gustavoars@kernel.org, vitor@massaru.org,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v5] overflow: Introduce overflows_type() and
 castable_to_type()
Message-ID: <202210290029.3CD089A86C@keescook>
References: <20220926191109.1803094-1-keescook@chromium.org>
 <20221024201125.1416422-1-gwan-gyeong.mun@intel.com>
 <ffcfb7ce-7646-c827-8d29-7c41e4b121d6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffcfb7ce-7646-c827-8d29-7c41e4b121d6@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Oct 29, 2022 at 08:55:43AM +0300, Gwan-gyeong Mun wrote:
> Hi Kees,

Hi! :)

> I've updated to v5 with the last comment of Nathan.
> Could you please kindly review what more is needed as we move forward with
> this patch?

It looks fine to me -- I assume it'll go via the drm tree? Would you
rather I carry the non-drm changes in my tree instead?

>
-- 
Kees Cook
