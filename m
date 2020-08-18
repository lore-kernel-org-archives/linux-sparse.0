Return-Path: <SRS0=Baf2=B4=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D83C433E1
	for <linux-sparse@archiver.kernel.org>; Tue, 18 Aug 2020 18:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E561B2078B
	for <linux-sparse@archiver.kernel.org>; Tue, 18 Aug 2020 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jb6RpHlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRSJ5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSJ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Aug 2020 14:09:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D1C061389
        for <linux-sparse@vger.kernel.org>; Tue, 18 Aug 2020 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GW5yFaxdPchBHsCBKfrFObPB9IkM75bRWwXB5/8fLwc=; b=Jb6RpHlz53t3UxEYwLjLD2u99T
        ug0GVWQBEdjSXgzDlOo4euD3/IK3D/gsaQEvGorkUaC7tLvckL0Zj70vOPHerPfYedI24drQ9YYla
        ZHC5mhvPOK4dI0rnZ72Ik+JmXPCP/hvmz9G8Gu1FsyrNGBYopy3VWmF3OSsu3fBOpdLyRzvjE2vCm
        Oy4Zzy63Tia3aLxGxY/3wwk4bw7RLl5TOe86OuEcjVl9Uy2BH43tqRb6G0kg250JzR0CPc/ojiUsF
        7wDNWtiJj7R2eEcooTQBK1cNDLSBn0vjIbH5GhugXor4VYyGQGUF2EKcSCpF+vxleycTwr8EIOOBW
        UMVQXA5w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k863W-0000J6-AR; Tue, 18 Aug 2020 18:09:54 +0000
To:     Linux-Sparse <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: sparse problem with duplicate __iomem?
Message-ID: <bdbcbf14-07b1-76e1-faee-4d27225778e5@infradead.org>
Date:   Tue, 18 Aug 2020 11:09:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

On kernel 5.9-rc1, either i386 or x86_64 builds, I am seeing these
sparse warnings:

../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: warning: duplicate [noderef]
../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: error: multiple address space given: __iomem & __iomem

for this source line:

	u8 __iomem *dst, __iomem *sig;


Should one of those __iomem-s be removed?
I.e., does "__iomem" apply to everything after it, up to the ending ';',
or just up to the next comma ','? 


thanks.
-- 
~Randy

