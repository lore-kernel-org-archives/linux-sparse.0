Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF135C432C3
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DD62222A
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgL1Wzw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbgL1VeV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 16:34:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26FC0613D6
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 13:33:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q18so12601094wrn.1
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 13:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EqiOo2bquos0n0Lnm1FyUvveYPtrdZp0JuhHsDYTUik=;
        b=pjgb77lm0mAdjhP6rTASEqA+Xg45nLrtGx/AhUtTcdjrfi7kOF6KSRiZk/BX0Rzxx0
         5JYEd1WqwiLAeLpoyipYFloWAC/1jbbLHqUk13HZe/NmXi9jyhnb4jqjOlZiZvhx0TAv
         ns8EgTx7tsOfUVafWjmOyNQYUUBLv3v7GhkVfDXkNcVy73BnzmXbAxBUARlemSAp7Sns
         rwkVOvc1RGCp04ftMI6eJzoJfceuqKnBegLggnvsVYw4AjrBf+AAvsZtxcgjDA13Y4wS
         lYZSLjnJP4kjiszO1n5ADkQQbRlt9L+uDMX40EhSyf+jv5q3a3dK62Up/mgxhvJzEgPb
         d60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EqiOo2bquos0n0Lnm1FyUvveYPtrdZp0JuhHsDYTUik=;
        b=F+eO5VSu5mWjB4nOCt6eySBjpm96dEgbPv4krGZQYiuAjdHHS9fcWqy8OxXnoSIcKw
         cGMzkYJVyo+IKZLi3hvALBn6nQTdW+00QlfKg3GyDKZwwhIZeFX9sfvRcAKyfbcrMdUY
         A2ch3VvIZDXGR2kjil6IbcXgcayFhH6Rk2NrqLSPl9gnZUnM+3wKBnTn91Hwvq50ClXX
         gTJmYx4ekOu6y5C6flZiF2Hyb43j9KHTpB6PDaxwPpgFwRo8vb6K45EAqRdo9yVNoMfU
         dEB8oTmrTks8PdKrbtYuRLwZY9jT4cW9ZAIBJa5AoASarBoqQBI1w9i17wBycJhvgSOw
         vT2g==
X-Gm-Message-State: AOAM530ZX4+FVyvauho/x6I7yuJ4cnjSKRMZNpC9MNDCuyaRY6Fgg+nP
        kc6N8eSxwNnqcNXjl6F3i84ljBactQ8=
X-Google-Smtp-Source: ABdhPJxW+C+ImOF73f7UXTwZRN4STxh5h86sNOuhzVPgZmcRT3FW+p432z2CdCIT1tIauq2XY14ipg==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr52141388wru.213.1609191219498;
        Mon, 28 Dec 2020 13:33:39 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id b14sm56408054wrx.77.2020.12.28.13.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 13:33:38 -0800 (PST)
Date:   Mon, 28 Dec 2020 22:33:38 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH 00/16] support __packed struct
Message-ID: <20201228213338.e5tspbe3od27lo4x@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <6a00eea2-7371-de84-05fc-1375603ed7eb@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a00eea2-7371-de84-05fc-1375603ed7eb@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 05:18:50PM +0000, Ramsay Jones wrote:
> 
> 
> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> > During parsing, Sparse recognizes the attribute 'packed' but this
> > attribute is otherwise ignored for several reasons:
> > 1) the attribute in 'struct __attr { ... }' is wrongly handled as
> >    belonging to the whole declaration but it should belong to the type,
> > 2) the attribute in 'struct <name> { ... } __attr;' is simply ignored,
> > 3) the layout of packed bitfields need special care.
> > 
> > This series contains 2 parts:
> > 1) handling of type attributes
> > 2) correct layout of packed structs, including packed bitfields.
> > 
> > 
> > This series is also available for review and testing at:
> >   git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git packed-v2
> 
> I left a couple of minor comments, but (apart from patch #16) this
> otherwise LGTM.
> 
> Patch #16 also looks good, but I would need to study it a bit more
> than I have time available to be totally happy. It does not seem
> to be handling the 'lowering' of 'odd bit-sized' symbols created in
> the previous patch (to answer my own question), so I would have to
> apply the patches (or fetch the above branch) to study some more.

Well, patch #16 doesn't contain the lowering, it kinda just enables
the last bits to support (without out-of-bound access) packed structures
including packed bitfields.

> Hope you had a good holiday.

Thank you. In truth, it was strange and quiet, very quiet.

I wish you all the best for 2021!

-- Luc
