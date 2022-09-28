Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14AC04A95
	for <linux-sparse@archiver.kernel.org>; Wed, 28 Sep 2022 18:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiI1SGN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 28 Sep 2022 14:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiI1SGM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Sep 2022 14:06:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B437C1F5
        for <linux-sparse@vger.kernel.org>; Wed, 28 Sep 2022 11:06:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b75so13196466pfb.7
        for <linux-sparse@vger.kernel.org>; Wed, 28 Sep 2022 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lg8DJ4PVGf/UE/b9agj2E3jF0biYJ2TzSjDWoqo1nWk=;
        b=kX6MiQJJ++GzWgnGDgSHhlrCPXkUnTfSWuw5a1vTXKi13Y13VyCmf0QKz9GO79Hl9h
         lytSSUqbfN/S/Ah/mnF4XU0V59XNaRA/1kXJDF/OU4N76i45SgkcHk4RiaBdM3X11q3P
         ngv3+AbyQkBAOyZ4Efs1UnxU8fMOnw5TwIofU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lg8DJ4PVGf/UE/b9agj2E3jF0biYJ2TzSjDWoqo1nWk=;
        b=mJQwu31vqXkJb+g/QfjgLj/CvzAO7GmeqQO1GeBVlHd+OMoX6+l4mxmxooHf+9dDuY
         /9iOUK2Xt0oX7L008JBPLzY2nYtv2m/N9sXkg1bNzI71aHB/Ja6BuOIv3uWbrbtAsV2s
         e849xRmEcshrD201in/U07tyvJ4mu1WVvIGCmoHoz1sZgJJdOpSt5aIoeCQf2qU64Us6
         a/CMWRheuWyamLYVkjyLyW/wXFyRJRRx81YtVdiYpnRnYBiaykm773e2fF2qxZYu3hy3
         DCAU3a1P/NjFbrpEDerMKCucZSOSm2SoH2juPAgmGfsAAkF/At77GxueBn4g5FXZQjth
         C8rw==
X-Gm-Message-State: ACrzQf1b1YPqqT4of0iHfzXLK8ix1tqkKAs/V8Q5gfGACo8+OMNnAJ1P
        YFswDZTk+DVwSA5Ex5K1OpkLQg==
X-Google-Smtp-Source: AMsMyM5YqTL3LfyC56o9MrGg1TzPcXSkd4eESKCY3Dzo1hitrUn0UwkQLKFW1M9B3lIoMGRQbkcRdw==
X-Received: by 2002:a65:4609:0:b0:434:8f0b:5d05 with SMTP id v9-20020a654609000000b004348f0b5d05mr29993911pgq.606.1664388369685;
        Wed, 28 Sep 2022 11:06:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mt10-20020a17090b230a00b00203059fc75bsm1706643pjb.5.2022.09.28.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:06:09 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:06:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v13 5/9] drm/i915: Check for integer truncation on
 scatterlist creation
Message-ID: <202209281102.A86D736@keescook>
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
 <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
 <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Sep 28, 2022 at 10:09:04AM -0700, Linus Torvalds wrote:
> Kees, you need to reign in the craziness in overflow.h.

Understood. I've been trying to help the drm folks walk a line between
having a bunch of custom macros hidden away in the drm includes and
building up generalized versions that are actually helpful beyond drm.
But I can see that it doesn't help to have a "do two things at the same
time" macro for the assignment checking.

-- 
Kees Cook
