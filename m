Return-Path: <SRS0=3N5e=EG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0AAC55179
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B38520731
	for <linux-sparse@archiver.kernel.org>; Sat, 31 Oct 2020 22:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE8Lntnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgJaWIQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 31 Oct 2020 18:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJaWIQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 31 Oct 2020 18:08:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D919C0617A6
        for <linux-sparse@vger.kernel.org>; Sat, 31 Oct 2020 15:08:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dk16so12844432ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 31 Oct 2020 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=de7h/5N+EIPyTDJznGgwMx7r9BpKFiI+A93J6ztPubY=;
        b=dE8LntnbZBYvdmaVhRGZMOSwPTZOOcgJ+hXzXJ0Obyl1UbAYvkGHLpvtC26CrkVNVj
         PNXMMr6MP2HXoJ0gwW9b8QlHm3a0mSIVe1HLc6Y6aNc27qwCBFQhkLqV/VEWtKBmRAID
         ePQ+Sd+XIG8DNwG4loBE9ARzynHxjNj7GpnoclxEidUPoanDhrGtuHinmlQ3BIOXxFym
         nutPQFdYrl/tMjIiOtHygW+fbbMxrgu2rV/LuQdQz7mU44Dc7+zuDF72rEiDAaoeP5KQ
         JS4GvDMbCbqMah04yaY/ncvDa27uCedRxitloK8yodHXS8rC/vuFHPLabhDwZS8lE7Sr
         nf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=de7h/5N+EIPyTDJznGgwMx7r9BpKFiI+A93J6ztPubY=;
        b=JZp9q/9/Iqx1bjybS7qHWb0uzfa8RRPFOtcu2JpgrcbI2FPnhr9fZGmCwoifcZnMup
         E9KZEWxya017FMVM7kgnjEpHYJ7Krfy9sfcdwZ/mC8TWiicOXH+hLTjAEVysiIU0gGAW
         jG5icBwBZThK5OUvG8f0qz6urh2CyqUCliq1+S66VFIy3Pq0wuktBLjfvnJQRWxURfSu
         bU2dTKoY0peCvoTrIyC+GEXjX5KmWZL2DkovYC2kcxG1IX96OD1A9ljHTav84r09+LvU
         Rj9UcymjuEuDUsvA4NKsyRqdc0uqv/5AZWbnZHK4eQZKKOUrfQzDyEGNHZjbkVj6t1s/
         ghFA==
X-Gm-Message-State: AOAM533cnS6fAc9IX86fc9ymF8CMc9ajCt0l2SubtAZnTvEUjpX5ocjC
        KaaojGIa2E74iMMPDj+TPgTKDhGHzBc=
X-Google-Smtp-Source: ABdhPJzV9VtXdwP2lJH0ypz2Elqr374saYBHgu0yiWI2hXoM1jvNJo6mlYJdPQdlZXjxudVqd9y+tg==
X-Received: by 2002:a17:906:9a4a:: with SMTP id aj10mr4575965ejc.389.1604182092946;
        Sat, 31 Oct 2020 15:08:12 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a86e:27a8:de95:3d6])
        by smtp.gmail.com with ESMTPSA id p14sm6272927eds.35.2020.10.31.15.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 15:08:12 -0700 (PDT)
Date:   Sat, 31 Oct 2020 23:08:11 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 1/2] testsuite: add a new tag: check-output-match
Message-ID: <20201031220811.ygdwj6pqq6h6t5j3@ltop.local>
References: <20201031200402.31312-1-luc.vanoostenryck@gmail.com>
 <20201031200402.31312-2-luc.vanoostenryck@gmail.com>
 <6cc4c620-0821-d3dc-6d46-803344a379bf@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc4c620-0821-d3dc-6d46-803344a379bf@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Oct 31, 2020 at 08:50:37PM +0000, Ramsay Jones wrote:
> On 31/10/2020 20:04, Luc Van Oostenryck wrote:
> > +	grep "$patt" "$ifile" | sed -e "s/^.*$patt(\(.*\)): *\(.*\)$/\1 \2/" | \
> > +	while read ins pat; do
> > +		echo "ins: $ins"
> > +		echo "pat: $pat"
> 
> Left-over debug?

Grnn, yes. Thank you for noticing this!

-- Luc 
