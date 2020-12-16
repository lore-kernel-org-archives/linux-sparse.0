Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F8DC4361B
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 23:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5B523718
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 23:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgLPXbF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgLPXbF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Dec 2020 18:31:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9599C061794
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 15:30:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cm17so26747871edb.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 15:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XWUtoPBd9Mv5KNFNc7hhrfPsEhwDN9sW9RHFmTGCsLA=;
        b=DiRDAh1RZLRxBwvQs5XNiW4+0/P1GYoI4/P20mXI6wNiXFe8j4epSK7ZrLIeUtRw1M
         JF3MbI6t2BNweSmcEyX4BBhHoAzkecUG3Dtw50yNJLjdRm/UbFMeVy9Jro/7aU1stCnT
         1mGZp0kwPBGygybPYM/2iAR3q9vASlSjvK4YplroJ5k2Xn4KqZ1ZbbPX4NZgNxgZII8r
         w81gNhZRLS9aEdQtJv1dO0dGGY21cJnxu0GxAc2qj1bIBYHmDzBwVrFwwA0vUmk0TWau
         +x0tcYbjAHNRlxsLeYQUdwdENpzHEDoKpLRRX4AqlKlJ/tNhxfHmIjK8xz4sv/9HgrOf
         EUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWUtoPBd9Mv5KNFNc7hhrfPsEhwDN9sW9RHFmTGCsLA=;
        b=r52bxQpB6qbriHWwbwaxsicnEXGOhj3h++QI9SzlYaTlUVnn35papHGLZp1zHYWxsX
         OCeid44/0VN/iX7PQRSvDs/arkBUQ37JoWEM7XZBiA152t94IFyT+CfBWIBNuZNJRRB8
         QVpWZ68lh5epM+eqwPBYGO7EvAfxL3LY/87rmBWlJNsadUw0/XN/ocjyGBLhZAtBuBdv
         HrPLbtqnMYrGj03CzHncj9dsI+axPNZmE5BTi5rC+4KVJj5mtP4L+LCg0u51DE4dOe0M
         Lynb8i7bxHGG6QYiONLpBfsgMKU21rNH1nSzXYaeKPdQY9MvBmEg+w8fbAJxK4EzLvWe
         /leQ==
X-Gm-Message-State: AOAM530ewO2Wy+NaCZFld2LIQ6UQe/WlS3UMzKXIBaWIy6RQIqmqeBJ0
        uFxyam2Pb0SsP4Hvyux2BkvLjCxwHKs=
X-Google-Smtp-Source: ABdhPJzmu5maw/YyG1tKrFbOMrxzvz1SoX15O7ltI8HsVdwKGG3rKlKjyiFM+yYh5HBJgYoM4IRHAA==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr35912588edk.377.1608161423497;
        Wed, 16 Dec 2020 15:30:23 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:30ac:ec9a:2892:f5b7])
        by smtp.gmail.com with ESMTPSA id b14sm16716778edu.3.2020.12.16.15.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:30:22 -0800 (PST)
Date:   Thu, 17 Dec 2020 00:30:21 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: sparse attribute packed on structures
Message-ID: <20201216233021.qcnvgsup7efwanqs@ltop.local>
References: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
 <20201215205618.scarwvtzzhhtdwvk@ltop.local>
 <76c27364-e4cb-cdd4-6e55-178dd19c46ba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c27364-e4cb-cdd4-6e55-178dd19c46ba@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Dec 15, 2020 at 03:15:48PM -0800, Jacob Keller wrote:
> 
> I did find one bug, in your step (3), you have a check against
> info->packed on symbol.c:162 in lay_out_struct, but nothing ever set the
> packed value. I think you just need to initialized info->packed from
> sym_packed at the top of examine_struct_union_type, i.e.

A yes, I see, thank you. I think it was on purpose that it wasn't
yet enabled (things are it fuzzy because the code is ~2 year old)
and as I said it's unfinished.

But, with your change, does it handles 'packed' more or less
correctly?

-- Luc
