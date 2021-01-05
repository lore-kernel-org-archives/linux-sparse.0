Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917BCC433E0
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D1722D6E
	for <linux-sparse@archiver.kernel.org>; Tue,  5 Jan 2021 20:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbhAEUjx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 5 Jan 2021 15:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbhAEUjx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 5 Jan 2021 15:39:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E68C061798
        for <linux-sparse@vger.kernel.org>; Tue,  5 Jan 2021 12:39:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a6so711177wmc.2
        for <linux-sparse@vger.kernel.org>; Tue, 05 Jan 2021 12:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+UfKPCyv/nfWMs6vIuzTzFw4f+vB640rWYTHBNV2KGo=;
        b=dVCpgpgcrqoAaizQgq1lRzFeOIvlnFCo/wkjFDnf+9taySCwbJ5REM2oFbkNHo5eHn
         ACVYjMefWkCq/Z5satd7lB614/rL+vWbjPXBK++gYf0FIQ2khzDatdI608/ufsYSYrYq
         s5u34AlTYMQIxKV8jjycaHpj9h90oauMB4Kh7nD/xjl5xxc5UiRI1Smsyc/z/yWYYIZL
         RexumSo2w/PN5aV2RPoDsLY7/9pvyxhVvdOy8j4wW5kKOucKx2Lc2T0SRZ1aljFp0a9c
         XbER1ocagkvpKmvGYzOSJ0etrr/15GcSiTqwxVhj4mtewoAoDzX0xYtjwKmcuL3FJG63
         PX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+UfKPCyv/nfWMs6vIuzTzFw4f+vB640rWYTHBNV2KGo=;
        b=tOcsN/r6zYxC9aBM1Xnk9cp7ELGGI/63XNqKfdp340RYpy3/EKjmKWFt+JqB/jkiuD
         KTq1geb5sFJ6CFBZ98XUQ0eqepeDRpkPken+4vUwCPRrOWfsL01DkX74q8TlpxePC2jx
         583W7q0afqjysomhw7YdNAdP8Y84mbRF2M5NaSuqfUgyPFHWhlB+sxX+gibnfd6K7K1a
         DCu0+sLvMRQWbCCWTY9RkBxnNWnzuoCXUld/aD2c4+y8k3+eOKyPimdvlLz80F3pBcUB
         OF08tZf7G9RX6hF8ZhQmiblJRwuGUnrDOqzgVVKci+xzvfl7zcosjYwGDkEghh05GEp4
         GEyQ==
X-Gm-Message-State: AOAM532jl+4ECruNk5H9ahU5JONx8eBtvj7kN6YzWiSwbP7mibwQ5ZmK
        PQo+6Fl8sDZGIwnKiBKxhFclevy34+E=
X-Google-Smtp-Source: ABdhPJxUmGInpeThLao9oeJTIykO9CygWz4AFPzhplWUFtsdO4wu+gRvYFpEEDOZ3401X1XzWvKm4A==
X-Received: by 2002:a1c:4954:: with SMTP id w81mr801732wma.60.1609879151424;
        Tue, 05 Jan 2021 12:39:11 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:15c4:ba26:3a7f:6815])
        by smtp.gmail.com with ESMTPSA id 67sm377693wmb.47.2021.01.05.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 12:39:10 -0800 (PST)
Date:   Tue, 5 Jan 2021 21:39:09 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 00/16] support __packed struct
Message-ID: <20210105203909.vnuhix3ukl7zxgt6@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <6a00eea2-7371-de84-05fc-1375603ed7eb@ramsayjones.plus.com>
 <20201228213338.e5tspbe3od27lo4x@ltop.local>
 <49f5ad45-5776-ab70-53c9-13fd23a1c082@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f5ad45-5776-ab70-53c9-13fd23a1c082@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jan 05, 2021 at 09:56:05AM -0800, Jacob Keller wrote:
> On 12/28/2020 1:33 PM, Luc Van Oostenryck wrote:
> > On Mon, Dec 28, 2020 at 05:18:50PM +0000, Ramsay Jones wrote:
> >>
> >> Patch #16 also looks good, but I would need to study it a bit more
> >> than I have time available to be totally happy. It does not seem
> >> to be handling the 'lowering' of 'odd bit-sized' symbols created in
> >> the previous patch (to answer my own question), so I would have to
> >> apply the patches (or fetch the above branch) to study some more.
> > 
> > Well, patch #16 doesn't contain the lowering, it kinda just enables
> > the last bits to support (without out-of-bound access) packed structures
> > including packed bitfields.
> > 
> 
> What does the 'lowering' gain us? Or, in other words, what is still
> missing after this series?

As a static checker, nothing is missing and the series is now mainlined.

The 'lowering' only matters if you want to somehow translate the
instructions used in the IR (Intermediate Representation) into
instructions for a more concrete machine, because now there are things
like: 'do a load of a 5-byte word'.

-- Luc
