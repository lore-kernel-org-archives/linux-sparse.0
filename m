Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6431C4727F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F912071E
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 09:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgI3JSU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:18:20 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:52774 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbgI3JSU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 05:18:20 -0400
X-Greylist: delayed 2548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 05:18:20 EDT
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kNXaZ-0002rQ-SU
        for <linux-sparse@vger.kernel.org> ; Wed, 30 Sep 2020 09:35:51 +0100
To:     linux-sparse@vger.kernel.org
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Subject: update to format parsing branch
Organization: Codethink Limited.
Message-ID: <3960bea7-69ef-ed00-66cf-ac73d5cd8876@codethink.co.uk>
Date:   Wed, 30 Sep 2020 09:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

I've done a rebase to v0.6.2 and put the result up at:

https://gitlab.com/CodethinkLabs/sparse bjdooks/printf-new3

Should I put this through a new round of review?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
