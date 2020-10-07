Return-Path: <SRS0=ZUDq=DO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05943C4363D
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 23:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892072083B
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 23:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVShvybd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgJGXP7 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 7 Oct 2020 19:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgJGXP7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Oct 2020 19:15:59 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC4C061755
        for <linux-sparse@vger.kernel.org>; Wed,  7 Oct 2020 16:15:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cq12so3948745edb.2
        for <linux-sparse@vger.kernel.org>; Wed, 07 Oct 2020 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lCu0bukN+vQ7SHyiY3sVbYvdTW2VLMNROJfN0dXemHY=;
        b=cVShvybdeWhaFBjEFUZG1IqC9Iz1V6L1ILLE/Hm7GA+5V4SweDJo7rLW41ftcUZrio
         9XSXK5YTC6stVq9kvWSKeLdzNEOBBgXgDmUYeq9MY5bpMZZCGFzGBMmyBEjF4ZwMY+HM
         iYzuzLlUc6Uv7nUAPXK0OXlqn2uXa429aBU+pMdgvHwbXd9vtj9zLLmZ98WotoGmzvAr
         OgPd2+DGxgUB/Q1F7SouhAWxGs4YAiaaaSV6S6z3H2tILyPmrSdsGOEf/EOE93CQptA4
         di0LvDkHhnaxWq6hbDEt5SNSvDyGoiBABrdaGXC4faXDN4+i5t+mpSmus/zrSU5K8+v4
         /YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lCu0bukN+vQ7SHyiY3sVbYvdTW2VLMNROJfN0dXemHY=;
        b=W6z/zr8JufR1h7UwAo9eA/rMa9e9jyyJue2udshT411z/DAxoI2asn/uegwiYZXww4
         31JouTGw5BJeRUcUnrp9rqSUh0MRSQWECBZnTKPkJz5ruMduloQU46y794EfB4vBqIWW
         bfpKDhXbHvhPdGq7uR3a6gqEftyu2/+8uGQjnz+WyprDsRPKBc9A0S92sTIQsVBXM/ov
         GLKRYfD+19zBhARsM3UNhe8aI3NF/fp89/jvtebmku5/27DVV4jaDMEPSwTgvRU4T9UM
         L1VDbi8DbcI+vNyG1IGVMl6UQMPmkmRb9e4ufM5X5h4RLfj8K6xheOmPZhS3cAjK7DKh
         AM0Q==
X-Gm-Message-State: AOAM530780ebtx/jQsZrNE3hu4fqkgwGkhY4iGc2hBqrgN/RHPgV3byU
        A7Mx9khCePDCnwHlnpwgYLw=
X-Google-Smtp-Source: ABdhPJymvb1Op5GQCQ/Svlt+Z+ZSXwOUWu2K2qgj89fhXslD7QQMkwEWjWN3F3BkiXLYu5IX+G9E6w==
X-Received: by 2002:a50:9b5b:: with SMTP id a27mr5947540edj.374.1602112556028;
        Wed, 07 Oct 2020 16:15:56 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:48d7:7240:c96a:4414])
        by smtp.gmail.com with ESMTPSA id 12sm2488118edw.50.2020.10.07.16.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 16:15:55 -0700 (PDT)
Date:   Thu, 8 Oct 2020 01:15:54 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     linux-sparse@vger.kernel.org, ovs-dev@openvswitch.org,
        Ian Stokes <ian.stokes@intel.com>,
        Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] flex-array: allow arrays of unions with flexible members.
Message-ID: <20201007231554.d3vgykhycm3pcezg@ltop.local>
References: <20201007115234.1482603-1-i.maximets@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007115234.1482603-1-i.maximets@ovn.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Oct 07, 2020 at 01:52:34PM +0200, Ilya Maximets wrote:
> The actual code in question that makes sparse fail
> OVS build could be found here:
>   https://github.com/openvswitch/ovs/blob/39fbd2c3f0392811689ec780f09baf90faceb877/lib/netdev-linux.c#L1238

I'm impressed and surprised you're using of includes just for Sparse.
I also see that this is since 2011. Just for my curiosity, have
you an idea for why exactly this was needed and if it is still
really needed?

-- Luc
