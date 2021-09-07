Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEBC433F5
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Sep 2021 06:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6E661057
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Sep 2021 06:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhIGGai (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Sep 2021 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbhIGGai (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Sep 2021 02:30:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFADC061575
        for <linux-sparse@vger.kernel.org>; Mon,  6 Sep 2021 23:29:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r7so12372687edd.6
        for <linux-sparse@vger.kernel.org>; Mon, 06 Sep 2021 23:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DoUkTM9OSVPQyL0DYZj9FNsmQwyG4sWIIF0+q1weA+0=;
        b=PCliyzw4KgnbCMQivRfufJPN5r6z06yBMMeX8noYH35pOgAui/MuHCPiBJ4ISpytgl
         Efxw9POZ2Jia4orUJcgN5axQzcznaI0c7v5sX7CzbEoLMBQTOVkXedbCfkxVuTJD1l/9
         lCPqBFew2eCWQLdWW9vaNJmzwxqnZmsJFE0NSUWnftGhd8xwAupcOEQ7Po4woBtUNzOW
         EUmO5g4LTcKUMSvxvZBvaXkZ2pLBEuiZjhj0sp4sS+Gbfy64L+udKRh7xQwJKqTdCA1Y
         RrTrY6de6ivkuPUxiHc4MizMlPuLXUEqYmqbgOjCFh6rbbWbrqr4dg/oMs5EYunX16eZ
         +o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DoUkTM9OSVPQyL0DYZj9FNsmQwyG4sWIIF0+q1weA+0=;
        b=iuBY6jlOnMuTTVb1m5E+KDQOFNMUkk/tcHWYvYk/kKrg9Lg3dpWr+lYJBmKSfvGPe0
         IbKOpVDaDn9BETdnOko6BRyXAgFWmK8WajTqQ+CP4PEipUQBmQxAWlnTq6gOTVhsPCBG
         u/+1FuLRAHxDQG+q/7CFgNEOrgB/RpER4dDGx/liqC+pKx3Sf/NIiYZGrjRIjOPIYxOS
         71PkSG0kACwO5IizNJcXzndUjCiIwYTdS7L3CSaTzdp6qv1XnbfdZ4O/ZKtVS0gY2zL+
         3QBD1LTbbpkPsV9FQQRinZEhhwdh1eJIvUZf08oiy/r4lKp37+A/PxPcF+5rhZCrkwJ3
         O+Kw==
X-Gm-Message-State: AOAM532h4jUMLqfpfxGhQftl4qCPY8gILf8+JHvhO8YNF+sBOH3RX3Pd
        5Qmmuo8OYV2y6Ro0vGHlgsU=
X-Google-Smtp-Source: ABdhPJy+3HAvqDn0ETWlUwl4GuvZvAxZtnQWiHFwbt8N4eW/SnVv2yEQh7rXFIQVzubunbgxfxvf+w==
X-Received: by 2002:a05:6402:1907:: with SMTP id e7mr16485501edz.201.1630996171051;
        Mon, 06 Sep 2021 23:29:31 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:6d64:8b57:17a6:ebc0])
        by smtp.gmail.com with ESMTPSA id b13sm5327171ede.97.2021.09.06.23.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 23:29:30 -0700 (PDT)
Date:   Tue, 7 Sep 2021 08:29:28 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sparse@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: [ANNOUNCE] Sparse v0.6.4
Message-ID: <20210907062928.qy37irlznwborcab@mail>
References: <20210906042111.lhoq7egtpmw3jcv6@mail>
 <0c4480ce-6c92-7788-772c-581a76c2df51@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c4480ce-6c92-7788-772c-581a76c2df51@codethink.co.uk>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Sep 06, 2021 at 11:04:14AM +0100, Ben Dooks wrote:
> On 06/09/2021 05:21, Luc Van Oostenryck wrote:
> > Sparse v0.6.4 is now out.
> > 
> > The source code can be found at its usual repository:
> >     git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.4
> > 
> > The tarballs can be found at:
> >     https://www.kernel.org/pub/software/devel/sparse/dist/
> > 
> > Many thanks to people who have somehow contributed to the 299
> > patches of this release:
> >     Ramsay Jones, Linus Torvalds, Kyle Russell
> 
> This has reminded me I have lost track of the printf formatting
> changes. Is it possible to re-sync and work out what still needs
> to be done to get this work merged?

Sure, the series can be merged with just a few trival conflicts.

I think things were left at 
https://lore.kernel.org/linux-sparse/20201013232231.10349-1-luc.vanoostenryck@gmail.com/T/#ma187dd3978640fccac03c0194fd5bdd84c437721

but the series is now at:
  git://github.com/lucvoo/sparse-dev.git format-check

Are these patches fine for you?

-- Luc
